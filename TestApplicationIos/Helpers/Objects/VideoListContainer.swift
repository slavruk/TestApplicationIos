//
//  DownloadVideoListManager.swift
//  TestApplicationIos
//
//  Created by Stas Lavruk on 5/17/19.
//  Copyright © 2019 Stas Lavruk. All rights reserved.
//

import Foundation

@objc protocol DownloadVideoListProtocol {
    
    var videoList: [Item] { get }
    
    func downloadVideoList(params: VideoListRequest, completion: @escaping (DowloadVideoCompetionHandler))
}

typealias DowloadVideoCompetionHandler = (_ success: Bool, _ result: AnyObject?, _ error: String) -> Void

final class VideoListContainer: NSObject, DownloadVideoListProtocol {
    
    var videoList: [Item]
    
    override init() {
        videoList = []
    }
    
    func downloadVideoList(params: VideoListRequest, completion: @escaping (DowloadVideoCompetionHandler)) {
        LSActivityIndicator.showIndicator(fullScreen: false)
        ServerAPIManager.getVideosList(params: params)
        { (result, success, error) in
            LSActivityIndicator.hideIndicator()
            if success, let videoList = result as? VideoListModel {
                self.videoList = videoList.items
                completion(true, result, "")
            } else {
                completion(false, nil, error ?? "error")
            }
        }
    }
}
