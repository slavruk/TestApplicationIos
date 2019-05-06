//
//  VideoListModel.swift
//  TestApplicationIos
//
//  Created by Stas Lavruk on 04/05/2019.
//  Copyright © 2019 Stas Lavruk. All rights reserved.
//

import Foundation

struct VideoListModel: Codable {
    let kind, etag, nextPageToken: String?
    let pageInfo: PageInfo?
    let items: [Item]?
}

struct PageInfo: Codable {
    let totalResults, resultsPerPage: Int?
}

struct Item: Codable {
    let kind: String?
    let etag, id: String?
    let snippet: Snippet?
    let contentDetails: ContentDetails?
    let statistics: Statistics?
}

struct Snippet: Codable {
    let publishedAt, channelID, title, description: String?
    let thumbnails: Thumbnails?
    let channelTitle: String?
    let tags: [String]?
    let categoryID: String?
    let liveBroadcastContent: String?
    let localized: Localized?
    let defaultAudioLanguage, defaultLanguage: String?
    
    enum CodingKeys: String, CodingKey {
        case publishedAt
        case channelID = "channelId"
        case title, description, thumbnails, channelTitle, tags
        case categoryID = "categoryId"
        case liveBroadcastContent, localized, defaultAudioLanguage, defaultLanguage
    }
}

struct Thumbnails: Codable {
    let thumbnailsDefault, medium, high: Default?
    let standard, maxres: Default?
    
    enum CodingKeys: String, CodingKey {
        case thumbnailsDefault = "default"
        case medium, high, standard, maxres
    }
}

struct Localized: Codable {
    let title, description: String?
}


struct ContentDetails: Codable {
    let duration: String?
    let dimension: Dimension?
    let definition: Definition?
    let caption: String?
    let licensedContent: Bool?
    let projection: Projection?
    let regionRestriction: RegionRestriction?
}

enum Definition: String, Codable {
    case hd = "hd"
    case sd = "sd"
}

enum Dimension: String, Codable {
    case the2D = "2d"
}

enum Projection: String, Codable {
    case rectangular = "rectangular"
}

struct RegionRestriction: Codable {
    let allowed: [String]?
}

struct Default: Codable {
    let url: String?
    let width, height: Int?
}

struct Statistics: Codable {
    let viewCount, likeCount, dislikeCount, favoriteCount: String?
    let commentCount: String?
}
