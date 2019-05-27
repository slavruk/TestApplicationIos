//
//  DownloadVideoListManager.swift
//  TestApplicationIos
//
//  Created by Stas Lavruk on 5/17/19.
//  Copyright © 2019 Stas Lavruk. All rights reserved.
//

import Foundation
import PromiseKit

protocol VideoListProtocol {
    
    var videoList: [Item] { get }
    
    func downloadVideoList<Request: Codable>(requestURL: URL, params: Request) -> Promise<VideoListModel>
}

//typealias DowloadVideoCompetionHandler = (_ success: Bool, _ result: AnyObject?, _ error: String?) -> Void

typealias VideoList = (_ success: Bool, _ result: VideoListModel?, _ error: String?) -> Void


final class VideoListContainer: NSObject, VideoListProtocol {
    
    var networkManager: AFNetworkProtocol
    var videoList: [Item] = []
    
    init(_ networkManager: AFNetworkProtocol) {
        self.networkManager = networkManager
    }
    
    override init() {
        networkManager = AFNetworkManager()
    }
    
    func downloadVideoList<Request: Codable>(requestURL: URL, params: Request) -> Promise<VideoListModel> {
        return networkManager.getRequestWith(methodPath: requestURL, params: params, response: VideoListModel.self)
    }
}

