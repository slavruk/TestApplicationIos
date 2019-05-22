//
//  InfoVideoObject.swift
//  TestApplicationIos
//
//  Created by Stas Lavruk on 5/20/19.
//  Copyright © 2019 Stas Lavruk. All rights reserved.
//

import Foundation

@objc protocol InfoVideoProtocol {
    
    var videoObject: VideoObject { get }
    
    func getVideoById(requestURL: URL, params: VideoInfoRequest, completion: @escaping (VideoInfoContainerCompetionHandler))
}

typealias VideoInfoContainerCompetionHandler = (_ success: Bool, _ result: AnyObject?, _ error: String?) -> Void

final class VideoInfoContainer: NSObject, InfoVideoProtocol {
    
    var videoObject: VideoObject
    
    override init() {
        self.videoObject = VideoObject(with:
            VideoInfoModel(kind: "", etag: "", pageInfo: PageInfo(totalResults: 0, resultsPerPage: 0),
                           items: nil))
    }
    
    func getVideoById(requestURL: URL, params: VideoInfoRequest, completion: @escaping (VideoInfoContainerCompetionHandler)) {
        ServerAPIManager().getVideosById(requestURL: Constants.API.getVideoById, params: params)
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
