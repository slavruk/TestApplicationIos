//
//  ResponseDataParser.swift
//  TestApplicationIos
//
//  Created by Stas Lavruk on 03/05/2019.
//  Copyright © 2019 Stas Lavruk. All rights reserved.
//

import Foundation

class ResponseDataParser {
    
    class func parse(_ responseData: Data?) -> [String: Any]? {
        guard let responseData = responseData,
            let parsedData = try? JSONSerialization.jsonObject(with: responseData,
                                                               options: []) as? [String: Any]
            else { return nil }
        return parsedData
    }
    
    class func parseErrors(from responseData: Data?) -> String {
        guard let parsedResponse = parse(responseData),
            let error = parsedResponse["error"] as? String ?? parsedResponse["message"] as? String else {
                return "Unhandled error!"
        }
        return error
    }
    
    class func parse<T: Codable>(from statusCode: Int, responseData: Data?, type: T.Type) -> (dataParsed: T?, error: String?) {
        guard let data = responseData else {
            return (dataParsed: nil, error: "Server error")
        }
        if statusCode < 300 {
            do {
                let dataParsed = try JSONDecoder().decode(T.self, from: data)
                return (dataParsed: dataParsed, error: nil)
            } catch let error {
                print(error)
            }
        }
        return (dataParsed: nil, error: "Server error")
    }
}
