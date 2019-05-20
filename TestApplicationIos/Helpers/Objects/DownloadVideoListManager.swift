//
//  DownloadVideoListManager.swift
//  TestApplicationIos
//
//  Created by Stas Lavruk on 5/17/19.
//  Copyright © 2019 Stas Lavruk. All rights reserved.
//

import Foundation

@objc protocol DownloadVideoListProtocol {
    
    var videolist: [Item] { get }
    /*
     Gets a list of videos according to the search criteria.
     */
    func downloadVideoList(params: [String: Any], completion: @escaping (DowloadVideoCompetionHandler))
    
//    func getVideoList() -> [AnyObject]
}

typealias DowloadVideoCompetionHandler = (_ success: Bool, _ error: String) -> Void

class DownloadVideoListManager: NSObject, DownloadVideoListProtocol {
    
    var videolist: [Item] = []
    
//    private var downloadVideoList: DownloadVideoListProtocol
    
    func downloadVideoList(params: [String : Any], completion: @escaping (DowloadVideoCompetionHandler)) {
        LSActivityIndicator.showIndicator(fullScreen: false)
        ServerAPIManager.getVideosList(params: params)
        { (result, success, error) in
            LSActivityIndicator.hideIndicator()
            if success, let videoList = result as? VideoListModel {
                self.videolist = videoList.items
                completion(true, "")
            } else {
                completion(false, error ?? "error")
            }
        }
    }
    
//    func getVideoList() -> [AnyObject] {
//        return videolist as [AnyObject]
//    }
}
