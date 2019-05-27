//
//  ServerAPIManager.swift
//  TestApplicationIos
//
//  Created by Stas Lavruk on 03/05/2019.
//  Copyright © 2019 Stas Lavruk. All rights reserved.
//

import Foundation
import PromiseKit

protocol ServerAPIMangerProtocol {
    func getVideosList(requestURL: URL, params: VideoListRequest, completion: @escaping (NetworkCompletionBlock))
    func getVideosById(requestURL: URL, params: VideoInfoRequest, completion: @escaping (NetworkCompletionBlock))
}

internal typealias NetworkCompletionBlock = (_ result: AnyObject?, _ isSuccess: Bool, _ errorMessage: String?) -> Void

final class ServerAPIManager: ServerAPIMangerProtocol {
    
    let networkManager: AFNetworkProtocol
    
    init(_ networkManager: AFNetworkProtocol = AFNetworkManager()) {
        self.networkManager = networkManager
        print(self.networkManager)
    }
    
    func getVideosList(requestURL: URL, params: VideoListRequest, completion: @escaping (NetworkCompletionBlock)) {
        let requestURL = Constants.API.searchViedos
        //        networkManager.getRequestWith(methodPath: requestURL, params: params)
        //        { (responseData) in
        //            switch responseData.result {
        //            case .success:
        //                let resultParsed = ResponseDataParser.parse(responseData: responseData.data, type: VideoListModel.self)
        //                if let data = resultParsed.dataParsed {
        //                    completion(data as AnyObject, true, nil)
        //                } else {
        //                    print("parse error: \(String(describing: responseData.result.value))")
        //                    completion(nil, false, resultParsed.error)
        //                }
        //            case .failure(let error):
        //                completion(nil, false, error.localizedDescription)
        //            }
        //        }
        
    }
    
//    func getVideos(requestURL: URL, params: VideoListRequest) -> (videoList: VideoListModel?, error: Error?) {
////        firstly {
////            networkManager.getRequestWith(methodPath: requestURL, params: params, response: VideoListModel.self)
////            }.done { dataVideoList in
////
////            }.catch { error in
////                return (nil, error)
////                //                UIAlertController(/*…*/).show()
////        }
////        let result = networkManager.getRequestWith(methodPath: requestURL, params: params, response: VideoListModel.self)
////        firstly {
////            networkManager.getRequestWith(methodPath: requestURL, params: params, response: VideoListModel.self)
////            }.done { dataVideoList in
////                
////                
////            }.catch { error in
////                
////        }
//    }
    
    func getVideosById(requestURL: URL, params: VideoInfoRequest, completion: @escaping (NetworkCompletionBlock)) {
        //        let requestURL = Constants.API.getVideoById
        //        networkManager.getRequestWith(methodPath: requestURL, params: params)
        //        { (responseData) in
        //            switch responseData.result {
        //            case .success:
        //                let resultParsed = ResponseDataParser.parse(responseData: responseData.data, type: VideoInfoModel.self)
        //                if let data = resultParsed.dataParsed {
        //                    completion(data as AnyObject, true, nil)
        //                } else {
        //                    print("parse error: \(String(describing: responseData.result.value))")
        //                    completion(nil, false, resultParsed.error)
        //                }
        //            case .failure(let error):
        //                completion(nil, false, error.localizedDescription)
        //            }
        //        }
    }
}
