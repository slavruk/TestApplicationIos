//
//  VideoListRequest.swift
//  TestApplicationIos
//
//  Created by Stas Lavruk on 5/16/19.
//  Copyright © 2019 Stas Lavruk. All rights reserved.
//

import Foundation

@objc class VideoListRequest: NSObject, Codable {
    let part: String = "snippet"
    let maxResults: Int
    let regionCode: String
    let order: String = "viewCount"
    let type: String = "video"
    let key: String = Constants.API.apiKey ?? ""
    var q: String?
    
    init(maxResults: Int,
         regionCode: String,
         q: String) {
        self.maxResults = maxResults
        self.regionCode = regionCode
        self.q = q
    }
}
