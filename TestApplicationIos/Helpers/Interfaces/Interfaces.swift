//
//  Interfaces.swift
//  TestApplicationIos
//
//  Created by Stas Lavruk on 5/21/19.
//  Copyright © 2019 Stas Lavruk. All rights reserved.
//

import Foundation

@objc protocol RootViewControllerProtocol {
    
    //    var currentCountryName: String { get set }
    //    var currentCountryCode: String { get set }
    //    var countVideosInList: Int { get set }
    var videoObjects: [VideoObject] { get set }
    
    func getVideoList()
    func getVideoById(videoId: String)
    func updateSearchVideoList(videoList items: [Item])
}

@objc protocol DownloadVideoListProtocol {
    
    var videolist: [Item] { get }
    /*
     Gets a list of videos according to the search criteria.
     */
    func downloadVideoList(params: [String: Any], completion: @escaping (DowloadVideoCompetionHandler))
    
    //    func getVideoList() -> [AnyObject]
}

@objc protocol InfoVideoProtocol {
    
    var video: VideoObject? { get }
    
    func getVideoById(videoId: String,  completion: @escaping (VideoInfoContainerCompetionHandler))
}
