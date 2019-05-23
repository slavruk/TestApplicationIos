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
    
    var networkManager: AFNetworkProtocol
    var videoObject: VideoObject?
    
    init(_ networkManager: AFNetworkProtocol = AFNetworkManager()) {
        self.networkManager = networkManager
    }
    
    func getVideoById(requestURL: URL, params: VideoInfoRequest, completion: @escaping (VideoInfoContainerCompetionHandler)) {
        ServerAPIManager(networkManager).getVideosById(requestURL: URL(string: "videoInfo")!, params: params)
        { (result, success, error) in
            if success, let videoInfo = result as? VideoInfoModel {
                // Create an object that contains video properties.
                self.videoObject = VideoObject(with: videoInfo)
                completion(true, videoInfo as AnyObject, nil)
            } else {
                completion(false, nil, error ?? "error")
            }
        }
    }
}
