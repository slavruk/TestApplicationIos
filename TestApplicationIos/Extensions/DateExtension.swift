//
//  DateExtension.swift
//  TestApplicationIos
//
//  Created by Stas Lavruk on 05/05/2019.
//  Copyright © 2019 Stas Lavruk. All rights reserved.
//

import Foundation

extension Date {
    
    /*
     Converts a date to the specified format.
     */
    func convertDateFormat(_ date: String) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        let date = dateFormatter.date(from: date)
        dateFormatter.dateFormat = "dd/MM/yyyy"
        return  dateFormatter.string(from: date!)
    }
}
