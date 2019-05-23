//
//  DownloadVideoListManager.swift
//  TestApplicationIos
//
//  Created by Stas Lavruk on 5/17/19.
//  Copyright © 2019 Stas Lavruk. All rights reserved.
//

import Foundation

@objc protocol VideoListProtocol {
        
    var videoList: [Item] { get }
    
    func downloadVideoList(requestURL: URL, params: VideoListRequest, completion: @escaping (DowloadVideoCompetionHandler))
}

typealias DowloadVideoCompetionHandler = (_ success: Bool, _ result: AnyObject?, _ error: String?) -> Void


final class VideoListContainer: NSObject, VideoListProtocol {
    
    var networkManager: AFNetworkProtocol
    var videoList: [Item] = []
    
    init(_ networkManager: AFNetworkProtocol) {
        self.networkManager = networkManager
    }
    
    override init() {
        networkManager = AFNetworkManager()
    }
    
    func downloadVideoList(requestURL: URL, params: VideoListRequest, completion: @escaping (DowloadVideoCompetionHandler)) {
        LSActivityIndicator.showIndicator(fullScreen: false)
        ServerAPIManager(networkManager).getVideosList(requestURL: requestURL, params: params)
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
