//
//  StringExtension.swift
//  TestApplicationIos
//
//  Created by Stas Lavruk on 05/05/2019.
//  Copyright © 2019 Stas Lavruk. All rights reserved.
//

import Foundation

extension String {
    
    /*
     Cuts a substring out of a string.
     */
    func trim(firstIndex: String.Index, offset: Int) -> String {
        let currentString = self
        let index = currentString.index(currentString.startIndex, offsetBy: offset)
        let cutString = currentString[..<index]
        return String(cutString)
    }
    
    func convertYTFormattedDuration() -> String {
        
        let formattedDuration = self.replacingOccurrences(of: "PT", with: "").replacingOccurrences(of: "H", with:":").replacingOccurrences(of: "M", with: ":").replacingOccurrences(of: "S", with: "")
        
        let components = formattedDuration.components(separatedBy: ":")
        var duration = ""
        for component in components {
            duration = duration.count > 0 ? duration + ":" : duration
            if component.count < 2 {
                duration += "0" + component
                continue
            }
            duration += component
        }
        
        return duration
        
    }
}
