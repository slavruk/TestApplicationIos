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
    
    var videoObject: VideoObject
    
    init() {
        self.videoObject = VideoObject(with:
            VideoInfoModel(kind: "", etag: "", pageInfo: PageInfo(totalResults: 0, resultsPerPage: 0),
                           items: nil))
    }
    
    func getVideoById(requestURL: URL, params: VideoInfoRequest, completion: @escaping (VideoInfoContainerCompetionHandler)) {
        LSActivityIndicator.showIndicator(fullScreen: false)
        MockServerAPIManager().getVideosById(requestURL: requestURL, params: params)
        { (result, success, error) in
            LSActivityIndicator.hideIndicator()
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
