//
//  MovieServices.swift
//  MarsPlayDemo
//
//  Created by Pawan Joshi on 11/12/18.
//  Copyright © 2018 Pawan Joshi. All rights reserved.
//

import UIKit

extension DataManager {

    class func getMovies(_ page: Int, completion: @escaping (_ success: Bool, _ message: String?, _ users: [Movie], _ nextPage: Int) -> Void) {
        
        if NetworkManager.isNetworkReachable {
            
            let parameters: [String: Any] = [Constants.APIServicesKeys.search: "Batman", Constants.APIServicesKeys.apiKey: Constants.omdbAPIKey, Constants.APIServicesKeys.page: page]
            
            NetworkManager.requestGETUrl(Constants.APIServices.getMoviesAPI, params: parameters, headers: nil, successHandler: { (response) in
                
                handleListAPIResponse(response, completion: { (success, message, movieList, totalResults) in
                    
                    if success {
                        let movies = movieList.map { Movie(object: $0) }
                        completion(true, message, movies, page+1)
                    } else {
                        completion(false, message, [Movie](), -1)
                    }
                    
                })
                
            }) { (error) in
                let infoDictionary = error.userInfo
                if let localizedDescription = infoDictionary[NSLocalizedDescriptionKey] as? String, let message = handleAPIResponseFailure(localizedDescription) {
                    completion(false, message, [Movie](), -1)
                } else {
                    completion(false, "", [Movie](), -1)
                }
                
            }
        } else {
            
            // network is not available get data from local data base
        }
        
    }
    
}
