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
