//
//  VideoInfoRequest.swift
//  TestApplicationIos
//
//  Created by Stas Lavruk on 5/16/19.
//  Copyright © 2019 Stas Lavruk. All rights reserved.
//

import Foundation

struct VideoInfoRequest: Codable {
    let part: String = "snippet,contentDetails,statistics"
    let id: String
    let key: String
    
    init(id: String, key: String) {
        self.id = id
        self.key = key
    }
}
