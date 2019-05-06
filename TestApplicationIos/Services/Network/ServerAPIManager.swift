//
//  ServerAPIManager.swift
//  TestApplicationIos
//
//  Created by Stas Lavruk on 03/05/2019.
//  Copyright © 2019 Stas Lavruk. All rights reserved.
//

import Foundation

class ServerAPIManager {
    
    typealias NetworkCompletionBlock = (_ result: AnyObject?, _ isSuccess: Bool, _ errorMessage: String?) -> Void
    
    class func getVideosList(params: [String: Any], completion: @escaping (NetworkCompletionBlock)) {
        let requestURL = Constants.API.getVideos
        AFNetworkManager.getRequestWith(methodPath: requestURL, params: params)
        { (responseData) in
            switch responseData.result {
            case .success:
                let resultParsed = ResponseDataParser.parse(from: responseData.response!.statusCode, responseData: responseData.data, type: VideoListModel.self)
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
    
    class func downloadImage(urlString: String, completion: @escaping (NetworkCompletionBlock)) {
        print(urlString)
        guard let requestURL = URL(string: urlString) else { return }
        AFNetworkManager.getRequestData(methodPath: requestURL, params: nil)
        { (responseData) in
            switch responseData.result {
            case .success:
                if let data = responseData.data {
                    completion(data as AnyObject, true, nil)
                } else {
                    print("parse error: \(String(describing: responseData.result.value))")
                    completion(nil, false, (responseData.result.error as! String))
                }
            case .failure(let error):
                completion(nil, false, error.localizedDescription)
            }
            
        }
    }
}
