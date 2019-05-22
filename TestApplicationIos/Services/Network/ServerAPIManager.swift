//
//  ServerAPIManager.swift
//  TestApplicationIos
//
//  Created by Stas Lavruk on 03/05/2019.
//  Copyright © 2019 Stas Lavruk. All rights reserved.
//

import Foundation

final class ServerAPIManager {
    
    typealias NetworkCompletionBlock = (_ result: AnyObject?, _ isSuccess: Bool, _ errorMessage: String?) -> Void
    
    class func getVideosList(params: VideoListRequest, completion: @escaping (NetworkCompletionBlock)) {
        let requestURL = Constants.API.searchViedos
        AFNetworkManager.getRequestWith(methodPath: requestURL, params: params)
        { (responseData) in
            switch responseData.result {
            case .success:
                let resultParsed = ResponseDataParser.parse(responseData: responseData.data, type: VideoListModel.self)
                if let data = resultParsed.dataParsed {
                    completion(data as AnyObject, true, nil)
                } else {
                    print("parse error: \(String(describing: responseData.result.value))")
                    completion(nil, false, resultParsed.error)
                }
            case .failure(let error):
                completion(nil, false, error.localizedDescription)
            }
            
        }
    }
    
    class func getVideosById(params: VideoInfoRequest, completion: @escaping (NetworkCompletionBlock)) {
        let requestURL = Constants.API.getVideoById
        AFNetworkManager.getRequestWith(methodPath: requestURL, params: params)
        { (responseData) in
            switch responseData.result {
            case .success:
                let resultParsed = ResponseDataParser.parse(responseData: responseData.data, type: VideoInfoModel.self)
                if let data = resultParsed.dataParsed {
                    completion(data as AnyObject, true, nil)
                } else {
                    print("parse error: \(String(describing: responseData.result.value))")
                    completion(nil, false, resultParsed.error)
                }
            case .failure(let error):
                completion(nil, false, error.localizedDescription)
            }

        }
    }
}
