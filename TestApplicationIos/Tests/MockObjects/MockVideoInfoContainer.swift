//
//  MockVideoInfoContainer.swift
//  TestApplicationIosMockTests
//
//  Created by Stas Lavruk on 5/21/19.
//  Copyright © 2019 Stas Lavruk. All rights reserved.
//

import Foundation

@testable import TestApplicationIos

class MockVideoInfoContainer: InfoVideoProtocol {
    
    var videoObject: VideoObject?
    
    func getVideoById(params: VideoInfoRequest, completion: @escaping (VideoInfoContainerCompetionHandler)) {
        ServerAPIManager.getVideosById(params: params)
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
