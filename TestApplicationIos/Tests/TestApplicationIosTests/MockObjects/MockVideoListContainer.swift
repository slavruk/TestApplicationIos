//
//  MockVideoListContainer.swift
//  TestApplicationIosMockTests
//
//  Created by Stas Lavruk on 5/21/19.
//  Copyright © 2019 Stas Lavruk. All rights reserved.
//

import Foundation

@testable import TestApplicationIos

class MockVideoListContainer: VideoListProtocol {
        
    var networkManager: AFNetworkProtocol
    var videoList: [Item] = []
    
    init(_ networkManager: AFNetworkProtocol = AFNetworkManager()) {
        self.networkManager = networkManager
    }
    
    func downloadVideoList(requestURL: URL, params: VideoListRequest, completion: @escaping (DowloadVideoCompetionHandler)) {
        LSActivityIndicator.showIndicator(fullScreen: false)
        ServerAPIManager(networkManager).getVideosList(requestURL: URL(string: "videoList")!, params: params)
        { (result, success, error) in
            LSActivityIndicator.hideIndicator()
            if success, let videoList = result as? VideoListModel {
                self.videoList = videoList.items
                completion(true, result, nil)
            } else {
                completion(false, nil, error ?? "error")
            }
        }
    }
}
