//
//  Constants.swift
//  MarsPlayDemo
//
//  Created by Pawan Joshi on 11/12/18.
//  Copyright © 2018 Pawan Joshi. All rights reserved.
//

import Foundation

struct Constants {
    
    static let BASE_URL: String = "http://www.omdbapi.com/"
    
    static let omdbAPIKey: String = "eeefc96f"
    
    struct AlertTitles {
        static let nevaAssinTitle = "NevaAssin"
        static let errorTitle = nevaAssinTitle
        static let warningTitle = "warning"
        static let successTitle = "success"
    }
    
    struct AlertMessages {
        static let sessionExpired = APIResponseFaliureMessages.unauthorizedAccess
    }
    
    
    struct APIResponseFaliureMessages {
        static let unauthorizedAccess = "Your session has expired! Please login again."
    }
    
    struct APIServices {
        
        static let getMoviesAPI = Constants.APIServices.apiURL("")
        static func apiURL(_ methodName: String) -> String {
            return BASE_URL + methodName
        }
    }

    struct APIServicesKeys {
        static let search = "s"
        static let page = "page"
        static let apiKey = "apiKey"
        static let success = "Response"
        static let totalResults = "totalResults"
        static let message = "message"
        static let data = "Search"
    }
    
}
