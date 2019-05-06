//
//  Constants.swift
//  TestApplicationIos
//
//  Created by Stas Lavruk on 04/05/2019.
//  Copyright © 2019 Stas Lavruk. All rights reserved.
//

import Foundation

struct Constants {
    struct API {
        
        static var apiKey = "AIzaSyBGPpqn3URS6RxOn5BBVOglTQVYMIbeEqM"
        static var hostYouTube = URL(string: "https://www.googleapis.com/youtube")!
        
        static let getVideos = hostYouTube.appendingPathComponent("/v3/videos")
    }
}
