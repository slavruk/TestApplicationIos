//
//  VideoListModel.swift
//  TestApplicationIos
//
//  Created by Stas Lavruk on 04/05/2019.
//  Copyright © 2019 Stas Lavruk. All rights reserved.
//

import Foundation

struct VideoListModel: Codable {
    let kind, etag, nextPageToken, regionCode: String?
    let pageInfo: PageInfo
    let items: [Item]
}

struct Item: Codable {
    let kind: String
    let etag: String
    let id: ID
    let snippet: Snippet
}

struct ID: Codable {
    let kind: String
    let videoID: String
    
    enum CodingKeys: String, CodingKey {
        case kind
        case videoID = "videoId"
    }
}

struct Default: Codable {
    let url: String
    let width, height: Int
}

struct PageInfo: Codable {
    let totalResults, resultsPerPage: Int
}
