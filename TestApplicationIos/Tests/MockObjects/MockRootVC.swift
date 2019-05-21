//
//  MockRootVC.swift
//  TestApplicationIosMockTests
//
//  Created by Stas Lavruk on 5/21/19.
//  Copyright © 2019 Stas Lavruk. All rights reserved.
//

import Foundation

@testable import TestApplicationIos

//class MockRootVC: RootViewControllerProtocol {
//
//    var videoObjects: [VideoObject]
//
//    init() {
//        videoObjects = []
//    }
//
//    func getVideoList() {
//        <#code#>
//    }
//
//    func getVideoById(videoId: String) {
//        ServerAPIManager.getVideosById(
//            params: ["part": "snippet,contentDetails,statistics",
//                     "id" : videoId,
//                     "key": Constants.API.apiKey
//            ])
//        { (result, success, error) in
//            if success, let videoInfo = result as? VideoModel {
//                // Create an object that contains video properties.
//                //                    guard let videoObject = VideoObject(with: videoInfo) else { return }
//                self.videoObjects.append(VideoObject(with: videoInfo))
//                self.videoObjects = self.videoObjects.sorted {$0.viewsCount > $1.viewsCount}
////                self.tableView?.reloadData()
//            } else {
//                UIHelper.showConfirmationAlertWith(title: "Error", message: error, action: nil, inViewController: self)
//            }
//        }
//    }
//
//    func updateSearchVideoList(videoList items: [Item]) {
//        self.videoObjects.removeAll()
//        for item in items {
//            // If any property is absent, then complete the current iteration.
//            self.getVideoById(videoId: item.id.videoID)
//        }
//    }
//
//
//}
