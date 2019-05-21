//
//  VideoListRequest.swift
//  TestApplicationIos
//
//  Created by Stas Lavruk on 5/16/19.
//  Copyright © 2019 Stas Lavruk. All rights reserved.
//

import Foundation

struct VideoListRequest: Codable {
    let part: String = "snippet"
    let maxResults: Int
    let regionCode: String
    let order: String = "viewCount"
    let type: String = "video"
    let key: URL
    
    init(maxResults: Int,
         regionCode: String,
         key: URL) {
        self.maxResults = maxResults
        self.regionCode = regionCode
        self.key = key
    }
}
