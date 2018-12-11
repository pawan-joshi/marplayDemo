//
//  Movie.swift
//  MarsPlayDemo
//
//  Created by Pawan Joshi on 11/12/18.
//  Copyright © 2018 Pawan Joshi. All rights reserved.
//

import Foundation
import SwiftyJSON

public struct Movie {
    
    // MARK: Declaration for string constants to be used to decode and also serialize.
    private struct SerializationKeys {
        static let title = "Title"
        static let imdbID = "imdbID"
        static let poster = "Poster"
        static let type = "Type"
        static let year = "Year"
    }
    
    // MARK: Properties
    public var title: String?
    public var imdbID: String?
    public var poster: String?
    public var type: String?
    public var year: String?
    
    public var yearTimestamp: String {
        let currentYearString = formattedStringUsingFormat("yyyy", date: Date())
        if let currentYear = currentYearString.toInt(), let yearValue = year?.toInt() {
            let difference = currentYear - yearValue
            switch difference {
            case 0:
                return "This year"
            case 1:
                return "1 year ago"
            default:
                return "\(difference) years ago"
            }
        } else {
            return "Release unknown"
        }
    }
    
    fileprivate func formattedStringUsingFormat(_ format: String, date: Date) -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = format
        let dateString = formatter.string(from: date)
        return dateString
    }
    // MARK: SwiftyJSON Initializers
    /// Initiates the instance based on the object.
    ///
    /// - parameter object: The object of either Dictionary or Array kind that was passed.
    /// - returns: An initialized instance of the class.
    public init(object: Any) {
        self.init(json: JSON(object))
    }
    
    /// Initiates the instance based on the JSON that was passed.
    ///
    /// - parameter json: JSON object from SwiftyJSON.
    public init(json: JSON) {
        title = json[SerializationKeys.title].string
        imdbID = json[SerializationKeys.imdbID].string
        poster = json[SerializationKeys.poster].string
        type = json[SerializationKeys.type].string
        year = json[SerializationKeys.year].string
    }
    
    /// Generates description of the object in the form of a NSDictionary.
    ///
    /// - returns: A Key value pair containing all valid values in the object.
    public func dictionaryRepresentation() -> [String: Any] {
        var dictionary: [String: Any] = [:]
        if let value = title { dictionary[SerializationKeys.title] = value }
        if let value = imdbID { dictionary[SerializationKeys.imdbID] = value }
        if let value = poster { dictionary[SerializationKeys.poster] = value }
        if let value = type { dictionary[SerializationKeys.type] = value }
        if let value = year { dictionary[SerializationKeys.year] = value }
        return dictionary
    }
    
}

