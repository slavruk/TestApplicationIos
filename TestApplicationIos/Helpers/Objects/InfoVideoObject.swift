//
//  InfoVideoObject.swift
//  TestApplicationIos
//
//  Created by Stas Lavruk on 5/20/19.
//  Copyright © 2019 Stas Lavruk. All rights reserved.
//

import Foundation

protocol InfoVideoProtocol {
    
    var video: VideoObject? { get }
    
    func getVideoById(videoId: String,  completion: @escaping (GettingVideoInfoCompetionHandler))
}

typealias GettingVideoInfoCompetionHandler = (_ success: Bool, _ result: AnyObject?, _ error: String) -> Void

class InfoVideoObject: NSObject, InfoVideoProtocol {
    
    var video: VideoObject?
    
    func getVideoById(videoId: String, completion: @escaping (GettingVideoInfoCompetionHandler)) {
        ServerAPIManager.getVideosById(
            params: ["part": "snippet,contentDetails,statistics",
                     "id" : videoId,
                     "key": Constants.API.apiKey
            ])
        { (result, success, error) in
            if success, let videoInfo = result as? VideoModel {
                // Create an object that contains video properties.
                self.video = VideoObject(with: videoInfo)
                completion(true, videoInfo as AnyObject, "")
            } else {
                completion(false, nil, error ?? "error")
            }
        }
    }
    
    
    
    
    
    
}
