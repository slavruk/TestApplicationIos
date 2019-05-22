//
//  ResponseDataParser.swift
//  TestApplicationIos
//
//  Created by Stas Lavruk on 03/05/2019.
//  Copyright © 2019 Stas Lavruk. All rights reserved.
//

import Foundation

final class ResponseDataParser {
        
    class func parse<T: Codable>(responseData: Data?, type: T.Type) -> (dataParsed: T?, error: String?) {
        guard let data = responseData else {
            return (dataParsed: nil, error: "Server error")
        }
        do {
            let dataParsed = try JSONDecoder().decode(T.self, from: data)
            return (dataParsed: dataParsed, error: nil)
        } catch let error {
            print(error)
        }
        return (dataParsed: nil, error: "Server error")
    }
}
