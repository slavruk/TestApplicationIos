//
//  VideoObject.swift
//  TestApplicationIos
//
//  Created by Stas Lavruk on 05/05/2019.
//  Copyright © 2019 Stas Lavruk. All rights reserved.
//

import UIKit

struct VideoObject {
    
    let viedoId: String
    let imageUrl: String
    let title: String
    let duration: String
    let viewsCount: Int
    let datePublished: String
    
    init(viedoId: String, imageUrl: String, title: String, duration: String, viewsCount: Int, datePublished: String) {
        self.viedoId = viedoId
        self.imageUrl = imageUrl
        self.title = title
        self.duration = duration
        self.viewsCount = viewsCount
        self.datePublished = datePublished
    }
}
