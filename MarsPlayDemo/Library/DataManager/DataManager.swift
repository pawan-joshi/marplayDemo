//
//  DataManager.swift
//  MarsPlayDemo
//
//  Created by Pawan Joshi on 11/12/18.
//  Copyright © 2018 Pawan Joshi. All rights reserved.
//

import Foundation
import SwiftyJSON

class DataManager {
    
    static let contentListPageSize: String = "10"
    
    /**
     Handles faliure response due to access denied. There could be a lot of reasons for this type of api call faliure, most importantly this function handles of the user session/token got expired
     
     */
    fileprivate class func handleAccessDeniedResponse(_ message: String) {
        // preform logout
    }
    
    /**
     Handles faliure response
     
     - parameter message: response faliure message
     
     */
    class func handleAPIResponseFailure(_ message: String) -> String? {
        switch message {
        case HTTPStatusCode.unauthorized.statusDescription:
            handleAccessDeniedResponse(message)
            return nil
        default:
            return message
        }
        
    }
    
    /**
     Handles simple success / faliure api response
     
     - parameter response:   response from network manager
     - parameter completion: handler
     
     */
    class func handleAPIResponse(_ response: [String: Any], completion: (_ success: Bool, _ message: String) -> Void) {
        
    }
    
    /**
     Handles data object type api response
     
     - parameter response:   response from network manager
     - parameter completion: handler
     
     */
    class func handleDataAPIResponse(_ response: [String: Any], completion: (_ success: Bool, _ message: String, _ result: [String: Any]) -> Void) {
        
    }
    
    /**
     Handles list type data api response
     
     - parameter response:   response from network manager
     - parameter completion: handler
     
     */
    class func handleListAPIResponse(_ response: [String: Any], completion: (_ success: Bool, _ message: String, _ contentList: [[String: Any]], _ totalResults: Int) -> Void) {
        var isSuccess: Bool = false
        if let successString = response[Constants.APIServicesKeys.success] as? String, successString == "True" {
            isSuccess = true
        }
        let message: String? = response[Constants.APIServicesKeys.message] as? String
        let dataArray: [[String: Any]]? = response[Constants.APIServicesKeys.data] as? [[String: Any]]
        completion(isSuccess, message ?? "", dataArray ?? [[String: Any]](), -1)
    }
    
}
