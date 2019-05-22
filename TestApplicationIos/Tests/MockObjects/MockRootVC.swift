//
//  MockRootVC.swift
//  TestApplicationIos
//
//  Created by Stas Lavruk on 5/22/19.
//  Copyright © 2019 Stas Lavruk. All rights reserved.
//

import Foundation

class MockRootVC: RootVCProtocol {
    
    var videoObjects: [VideoObject]
    
    init() {
        videoObjects = []
    }
    
    func getVideoList(params: VideoListRequest) {
        
    }
    
    func getVideoById(videoId: String) {
        
    }
}
