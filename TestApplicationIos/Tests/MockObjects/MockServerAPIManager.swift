//
//  MockServerAPIManager.swift
//  TestApplicationIos
//
//  Created by Stas Lavruk on 5/22/19.
//  Copyright © 2019 Stas Lavruk. All rights reserved.
//

import Foundation

@testable import TestApplicationIos

class MockServerAPIManager: ServerAPIMangerProtocol {
    
    let networkManager: AFNetworkProtocol
    
    init(_ networkManager: AFNetworkProtocol = MockAFNetworkManager()) {
        self.networkManager = networkManager
    }
    
    func getVideosList(requestURL: URL, params: VideoListRequest, completion: @escaping (NetworkCompletionBlock)) {
        networkManager.getRequestWith(methodPath: requestURL, params: params)
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
    
    func getVideosById(requestURL: URL, params: VideoInfoRequest, completion: @escaping (NetworkCompletionBlock)) {
        networkManager.getRequestWith(methodPath: requestURL, params: params)
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
