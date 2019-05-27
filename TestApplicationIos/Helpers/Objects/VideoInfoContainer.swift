//
//  InfoVideoObject.swift
//  TestApplicationIos
//
//  Created by Stas Lavruk on 5/20/19.
//  Copyright © 2019 Stas Lavruk. All rights reserved.
//

import Foundation
import PromiseKit

protocol InfoVideoProtocol {
    
    var videoObject: VideoObject? { get }
    
//    func getVideoById(requestURL: URL, params: VideoInfoRequest, completion: @escaping (VideoInfoContainerCompetionHandler))
    func getVideoById<Request: Codable>(requestURL: URL, params: Request) -> Promise<VideoInfoModel>

}

typealias VideoInfoContainerCompetionHandler = (_ success: Bool, _ result: AnyObject?, _ error: String?) -> Void

final class VideoInfoContainer: NSObject, InfoVideoProtocol {
    
    var networkManager: AFNetworkProtocol
    var videoObject: VideoObject?
    
    init(_ networkManager: AFNetworkProtocol) {
        self.networkManager = networkManager
    }
    
    override init() {
        networkManager = AFNetworkManager()
    }
    
    func getVideoById<Request: Codable>(requestURL: URL, params: Request) -> Promise<VideoInfoModel> {
        return networkManager.getRequestWith(methodPath: requestURL, params: params, response: VideoInfoModel.self)
//        print(networkManager)
//        ServerAPIManager(networkManager).getVideosById(requestURL: requestURL, params: params)
//        { (result, success, error) in
//            if success, let videoInfo = result as? VideoInfoModel {
//                // Create an object that contains video properties.
//                self.videoObject = VideoObject(with: videoInfo)
//                completion(true, videoInfo as AnyObject, nil)
//            } else {
//                completion(false, nil, error ?? "error")
//            }
//        }
    }
}
