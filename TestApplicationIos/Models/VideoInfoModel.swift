//
//  VideoModel.swift
//  TestApplicationIos
//
//  Created by Stas Lavruk on 06/05/2019.
//  Copyright © 2019 Stas Lavruk. All rights reserved.
//

import Foundation

struct VideoInfoModel: Codable {
    let kind, etag: String
    let pageInfo: PageInfo
    let items: [ItemVideo]?
}

struct ItemVideo: Codable {
    let kind, etag, id: String
    let snippet: Snippet
    let contentDetails: ContentDetails
    let statistics: Statistics?
}

struct ContentDetails: Codable {
    let duration, dimension, definition, caption: String
    let licensedContent: Bool
    let projection: String
}

struct Snippet: Codable {
    let publishedAt, channelID, title, description: String
    let thumbnails: Thumbnails
    let channelTitle: String
    let tags: [String]?
    let categoryID, liveBroadcastContent: String?
    let localized: Localized?
    let defaultAudioLanguage: String?
    
    enum CodingKeys: String, CodingKey {
        case publishedAt
        case channelID = "channelId"
        case title, description, thumbnails, channelTitle, tags
        case categoryID = "categoryId"
        case liveBroadcastContent, localized, defaultAudioLanguage
    }
}

struct Localized: Codable {
    let title, description: String
}

struct Thumbnails: Codable {
    let thumbnailsDefault, medium, high, standard: Default?
    let maxres: Default?
    
    enum CodingKeys: String, CodingKey {
        case thumbnailsDefault = "default"
        case medium, high, standard, maxres
    }
}

struct Statistics: Codable {
    let viewCount, likeCount, dislikeCount, favoriteCount: String?
    let commentCount: String?
}
