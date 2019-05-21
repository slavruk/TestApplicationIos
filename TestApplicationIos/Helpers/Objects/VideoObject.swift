//
//  VideoObject.swift
//  TestApplicationIos
//
//  Created by Stas Lavruk on 05/05/2019.
//  Copyright © 2019 Stas Lavruk. All rights reserved.
//

import UIKit

@objc final class VideoObject: NSObject {
    
    let viedoId: String
    let imageUrl: String
    let title: String
    let duration: String
    let viewsCount: String
    let datePublished: String
    
    init(with model: VideoInfoModel) {
//        guard let videoInfo = model.items?[0] else { return }
        viedoId = model.items?[0].id ?? ""
        imageUrl = model.items?[0].snippet.thumbnails.maxres?.url ?? ""
        title = model.items?[0].snippet.title ?? ""
        duration = model.items?[0].contentDetails.duration ?? "0"
        viewsCount = model.items?[0].statistics?.viewCount ?? "0"
        datePublished = model.items?[0].snippet.publishedAt ?? ""
    }
}
