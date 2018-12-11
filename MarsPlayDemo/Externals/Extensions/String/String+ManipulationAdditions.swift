//
//  String+Additions.swift
//  MarsPlayDemo
//
//  Created by Pawan Joshi on 11/12/18.
//  Copyright © 2018 Pawan Joshi. All rights reserved.
//

import Foundation

// MARK: - String Extension

extension String {
    /**
     Strips the specified characters from the beginning of string.
     
     - parameter set: Give character set to apply on string for trimming
     
     - returns: A String trimmed after left whitespace
     */
    func trimmedLeft(characterSet set: CharacterSet = CharacterSet.whitespacesAndNewlines) -> String {
        if let range = rangeOfCharacter(from: set.inverted) {
            return String(self[range.lowerBound ..< endIndex])
        }
        
        return ""
    }
    
    /**
     Strips the specified characters from the end of string.
     
     - parameter set: Give character set to apply on string for trimming
     
     - returns: A String trimmed after right whitespace
     */
    func trimmedRight(characterSet set: CharacterSet = CharacterSet.whitespacesAndNewlines) -> String {
        if let range = rangeOfCharacter(from: set.inverted, options: NSString.CompareOptions.backwards) {
            return String(self[startIndex ..< range.upperBound])
        }
        
        return ""
    }
    
    /**
     Strips whitespaces from both the beginning and the end of string.
     
     - returns: A String after trimmed white space
     */
    func trimmed() -> String {
        return trimmedLeft().trimmedRight()
    }
    
    /**
     Parses a string containing a non-negative integer value into an optional UInt if the string is a well formed number.
     
     - returns: A UInt parsed from the string or nil if it cannot be parsed.
     */
    func toUInt() -> UInt? {
        if let val = Int(self.trimmed()) {
            if val < 0 {
                return nil
            }
            return UInt(val)
        }
        
        return nil
    }
    
    func toInt() -> Int? {
        if let val = Int(self.trimmed()) {
            if val < 0 {
                return nil
            }
            return val
        }
        
        return nil
    }
}
