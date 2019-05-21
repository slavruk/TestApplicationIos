//
//  InfoVideoObject.swift
//  TestApplicationIos
//
//  Created by Stas Lavruk on 5/20/19.
//  Copyright © 2019 Stas Lavruk. All rights reserved.
//

import Foundation

@objc protocol InfoVideoProtocol {
    
    var videoObject: VideoObject? { get }
    
    func getVideoById(videoId: String, completion: @escaping (VideoInfoContainerCompetionHandler))
    
}

typealias VideoInfoContainerCompetionHandler = (_ success: Bool, _ result: AnyObject?, _ error: String) -> Void

final class VideoInfoContainer: NSObject, InfoVideoProtocol {
    
    var videoObject: VideoObject?
    
    func getVideoById(videoId: String, completion: @escaping (VideoInfoContainerCompetionHandler)) {
        ServerAPIManager.getVideosById(
            params: ["part": "snippet,contentDetails,statistics",
                     "id" : videoId,
                     "key": Constants.API.apiKey ?? ""
            ])
        { (result, success, error) in
            if success, let videoInfo = result as? VideoInfoModel {
                // Create an object that contains video properties.
                self.videoObject = VideoObject(with: videoInfo)
                completion(true, videoInfo as AnyObject, "")
            } else {
                completion(false, nil, error ?? "error")
            }
        }
    }
    
    
    
    
    
    
}
