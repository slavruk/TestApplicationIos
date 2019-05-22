//
//  MockDownloadVideoListContainer.swift
//  TestApplicationIosMockTests
//
//  Created by Stas Lavruk on 5/21/19.
//  Copyright © 2019 Stas Lavruk. All rights reserved.
//

import Foundation

@testable import TestApplicationIos

class MockDownloadVideoListContainer: DownloadVideoListProtocol {
        
    var videoList: [Item]
    
    init() {
        videoList = []
    }
    
    func downloadVideoList(requestURL: URL, params: VideoListRequest, completion: @escaping (DowloadVideoCompetionHandler)) {
        LSActivityIndicator.showIndicator(fullScreen: false)
        MockServerAPIManager().getVideosList(requestURL: requestURL, params: params)
        { (result, success, error) in
            LSActivityIndicator.hideIndicator()
            if success, let videoList = result as? VideoListModel {
                self.videoList = videoList.items
                completion(true, videoList as AnyObject, nil)
            } else {
                completion(false, nil, error ?? "Error")
            }
        }
    }
}
