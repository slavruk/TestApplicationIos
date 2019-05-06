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
        
        static var apiKey = "AIzaSyCBBl2czmm5gcNe_arkRBqJ4yDTM9XGYRQ"
        static var hostYouTube = URL(string: "https://www.googleapis.com/youtube")!
        
        static let searchViedos = hostYouTube.appendingPathComponent("/v3/search")
        static let getVideoById = hostYouTube.appendingPathComponent("/v3/videos")


    }
}
