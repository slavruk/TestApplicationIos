//
//  DownloadVideoListObject.swift
//  TestApplicationIos
//
//  Created by Stas Lavruk on 5/17/19.
//  Copyright © 2019 Stas Lavruk. All rights reserved.
//

import Foundation

protocol DownloadVideoListProtocol {
    
    var videolist: [Item] { get }
    /*
     Gets a list of videos according to the search criteria.
     */
    func downloadVideoList(params: [String: Any])
    
    func getVideoList() -> [AnyObject]
}

class DownloadVideoListManager: DownloadVideoListProtocol {
    var videolist: [Item]
    
//    private var downloadVideoList: DownloadVideoListProtocol
    
    init() {
        videolist = []
    }
    
    func downloadVideoList(params: [String : Any]) {
        LSActivityIndicator.showIndicator(fullScreen: false)
        ServerAPIManager.getVideosList(params: params)
        { (result, success, error) in
            LSActivityIndicator.hideIndicator()
            if success, let videoList = result as? VideoListModel {
//                self.videoList.removeAll()
//                for item in videoList.items {
//                }
                self.videolist = videoList.items
            } else {
//                UIHelper.showConfirmationAlertWith(title: "Error", message: error, action: nil, inViewController: self)
            }
        }
    }
    
    func getVideoList() -> [AnyObject] {
        return videolist as [AnyObject]
    }
}
