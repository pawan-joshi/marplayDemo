//
//  NetworkManager.swift
//  MarsPlayDemo
//
//  Created by Pawan Joshi on 11/12/18.
//  Copyright © 2018 Pawan Joshi. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON

class NetworkManager {

    static var dafaultHeaders: HTTPHeaders {
        var authorizationHeader: [String: String] = [String: String]()
        authorizationHeader["accessToken"] = "SessionToken" //this will be saved at the time of login
        //we can add other header fields if required.
        return authorizationHeader
    }
    
    static var dafaultParameters: [String: Any] {
        var parameters: [String: Any] = [String: Any]()
        parameters["devicePushToken"] = "devicePushToken"
        parameters["deviceType"] = "deviceType" //iOS or Android
        return parameters
    }
    
    static var isNetworkReachable: Bool {
        let manager = NetworkReachabilityManager(host: Constants.BASE_URL)
        let isReachable = manager?.isReachable ?? false
        return isReachable
    }
    
    /**
     Performs GET request to fetch data
     
     - parameter urlString:                 api end point url
     - parameter requiresDefaultParameters: not every api call requires device APNS token to be sent, this flag denotes if it does
     - parameter params: request parameters
     - parameter headers: request headers
     - parameter completionHandler: handler
     
     */
    class func requestGETUrl(_ urlString: String, _ requiresDefaultParameters: Bool = false, params: [String: Any]?, headers: [String: String]?, successHandler: @escaping (_ response: [String: Any]) -> Void, failureHandler: @escaping (_ error: NSError) -> Void) {
        
        let parameters = finalizeRequestParameters(requiresDefaultParameters: requiresDefaultParameters, params: params)
        let headers = finalizeRequestHeaders(headers: headers)
        Alamofire.request(urlString, method: HTTPMethod.get, parameters: parameters, encoding: URLEncoding.default, headers: headers).responseString(completionHandler: { (response) in
            response.result.ifSuccess {
                if response.result.value != nil {
                    let responseJson = JSON(parseJSON: response.result.value ?? "{}")
                    if let responseDictionary = responseJson.dictionaryObject {
                        successHandler(responseDictionary)
                    } else {
                        successHandler([:])
                    }
                } else {
                    successHandler([:])
                }
            }
            response.result.ifFailure {
                let error = errorForHTTPStatus(response.response?.statusCode ?? -10)
                failureHandler(error)
            }
        })
        
    }
    
    /**
     Performs GET request to fetch data
     
     - parameter params:                    request parameters
     - parameter requiresDefaultParameters: adds default parameters if it should
     
     */
    private class func finalizeRequestParameters(requiresDefaultParameters: Bool, params: [String: Any]?) -> [String: Any] {
        var parameters: [String: Any] = [String: Any]()
        parameters = params?.mapValues { value in
            return value
            } ?? [String: Any]()
        if requiresDefaultParameters {
            parameters.merge(dafaultParameters) { (first, _) -> Any in
                first
            }
        }
        return parameters
    }
    
    /**
     Performs GET request to fetch data
     
     - parameter params:                    request headers
     - parameter requiresDefaultParameters: adds default headers if it should
     
     */
    private class func finalizeRequestHeaders(headers: [String: String]?) -> [String: String] {
        var requestHeaders: [String: String] = [String: String]()
        requestHeaders = headers?.mapValues { value in
            return value
            } ?? [String: String]()
        requestHeaders.merge(dafaultHeaders) { (first, _) -> String in
            first
        }
        return requestHeaders
    }
    
    /**
     Create an error for response you probably don't want (400-500 HTTP responses for example).
     
     - parameter code: Code for error.
     
     - returns: An NSError.
     */
    private class func errorForHTTPStatus(_ code: Int) -> NSError {
        let text = HTTPStatusCode(statusCode: code).statusDescription
        let errorDictionary = [NSLocalizedFailureReasonErrorKey: NSLocalizedString("Error", comment: "Error"), NSLocalizedDescriptionKey: text]
        return NSError(domain: "HTTP", code: code, userInfo: errorDictionary)
    }
}

enum HTTPStatusCode: Int {
    case `continue` = 100,
    switchingProtocols = 101
    
    case ok = 200,
    created = 201,
    accepted = 202,
    nonAuthoritativeInformation = 203,
    noContent = 204,
    resetContent = 205,
    partialContent = 206
    
    case multipleChoices = 300,
    movedPermanently = 301,
    found = 302,
    seeOther = 303,
    notModified = 304,
    useProxy = 305,
    unused = 306,
    temporaryRedirect = 307
    
    case badRequest = 400,
    unauthorized = 401,
    paymentRequired = 402,
    forbidden = 403,
    notFound = 404,
    methodNotAllowed = 405,
    notAcceptable = 406,
    proxyAuthenticationRequired = 407,
    requestTimeout = 408,
    conflict = 409,
    gone = 410,
    lengthRequired = 411,
    preconditionFailed = 412,
    requestEntityTooLarge = 413,
    requestUriTooLong = 414,
    unsupportedMediaType = 415,
    requestedRangeNotSatisfiable = 416,
    expectationFailed = 417
    
    case internalServerError = 500,
    notImplemented = 501,
    badGateway = 502,
    serviceUnavailable = 503,
    gatewayTimeout = 504,
    httpVersionNotSupported = 505
    
    case invalidUrl = -1001
    
    case unknownStatus = 0
    
    init(statusCode: Int) {
        self = HTTPStatusCode(rawValue: statusCode) ?? .unknownStatus
    }
    
    public var statusDescription: String {
        switch self {
        case .continue:
            return "Continue"
        case .switchingProtocols:
            return "Switching protocols"
        case .ok:
            return "OK"
        case .created:
            return "Created"
        case .accepted:
            return "Accepted"
        case .nonAuthoritativeInformation:
            return "Non authoritative information"
        case .noContent:
            return "No content"
        case .resetContent:
            return "Reset content"
        case .partialContent:
            return "Partial Content"
        case .multipleChoices:
            return "Multiple choices"
        case .movedPermanently:
            return "Moved Permanently"
        case .found:
            return "Found"
        case .seeOther:
            return "See other Uri"
        case .notModified:
            return "Not modified"
        case .useProxy:
            return "Use proxy"
        case .unused:
            return "Unused"
        case .temporaryRedirect:
            return "Temporary redirect"
        case .badRequest:
            return "Bad request"
        case .unauthorized:
            return "Access denied"
        case .paymentRequired:
            return "Payment required"
        case .forbidden:
            return "Forbidden"
        case .notFound:
            return "Page not found"
        case .methodNotAllowed:
            return "Method not allowed"
        case .notAcceptable:
            return "Not acceptable"
        case .proxyAuthenticationRequired:
            return "Proxy authentication required"
        case .requestTimeout:
            return "Request timeout"
        case .conflict:
            return "Conflict request"
        case .gone:
            return "Page is gone"
        case .lengthRequired:
            return "Lack content length"
        case .preconditionFailed:
            return "Precondition failed"
        case .requestEntityTooLarge:
            return "Request entity is too large"
        case .requestUriTooLong:
            return "Request uri is too long"
        case .unsupportedMediaType:
            return "Unsupported media type"
        case .requestedRangeNotSatisfiable:
            return "Request range is not satisfiable"
        case .expectationFailed:
            return "Expected request is failed"
        case .internalServerError:
            return "Internal server error"
        case .notImplemented:
            return "Server does not implement a feature for request"
        case .badGateway:
            return "Bad gateway"
        case .serviceUnavailable:
            return "Service unavailable"
        case .gatewayTimeout:
            return "Gateway timeout"
        case .httpVersionNotSupported:
            return "Http version not supported"
        case .invalidUrl:
            return "Invalid url"
        default:
            return "Unknown status code"
        }
    }
}
