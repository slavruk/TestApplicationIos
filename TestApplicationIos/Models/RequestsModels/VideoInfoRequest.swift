//
//  VideoInfoRequest.swift
//  TestApplicationIos
//
//  Created by Stas Lavruk on 5/16/19.
//  Copyright © 2019 Stas Lavruk. All rights reserved.
//

import Foundation

@objc class VideoInfoRequest: NSObject, Codable {
    let part: String = "snippet,contentDetails,statistics"
    let id: String
    let key: String = Constants.API.apiKey ?? ""
    
    init(id: String) {
        self.id = id
    }
}
