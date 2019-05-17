//
//  VideoObject.swift
//  TestApplicationIos
//
//  Created by Stas Lavruk on 05/05/2019.
//  Copyright © 2019 Stas Lavruk. All rights reserved.
//

import UIKit

class VideoObject {
    
    let viedoId: String
    let imageUrl: String
    let title: String
    let duration: String
    let viewsCount: String
    let datePublished: String
    
//    init(viedoId: String, imageUrl: String, title: String, duration: String, viewsCount: Int, datePublished: String) {
//        self.viedoId = viedoId
//        self.imageUrl = imageUrl
//        self.title = title
//        self.duration = duration
//        self.viewsCount = viewsCount
//        self.datePublished = datePublished
//    }
    
    init?(with model: VideoModel) {
        guard let videoInfo = model.items?[0] else { return nil }
        viedoId = videoInfo.id
        imageUrl = videoInfo.snippet.thumbnails.maxres?.url ?? ""
        title = videoInfo.snippet.title
        duration = videoInfo.contentDetails.duration
        viewsCount = videoInfo.statistics?.viewCount ?? "0"
        datePublished = videoInfo.snippet.publishedAt
    }
}
