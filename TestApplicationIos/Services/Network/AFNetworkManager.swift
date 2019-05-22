//
//  AFNetworkManager.swift
//  TestApplicationIos
//
//  Created by Stas Lavruk on 03/05/2019.
//  Copyright © 2019 Stas Lavruk. All rights reserved.
//

import Foundation
import Alamofire

protocol AFNetworkProtocol {
    var header: HTTPHeaders? { get }
    func getRequestWith<T: Codable>(methodPath: URL, params: T, completion: @escaping (_ responseData: (DataResponse<Any>)) -> ())
}

class AFNetworkManager: AFNetworkProtocol {
    
    var header: HTTPHeaders? {
        return ["Content-Type": "application/json",
                "Accept": "application/json"]
    }
    
    func getRequestWith<T: Codable>(methodPath: URL,
                                    params: T,
                                    completion: @escaping (_ responseData: (DataResponse<Any>)) -> ()) {
        let encoder = JSONEncoder()
        let jsonData = try! encoder.encode(params)
        do {
            let dict = try JSONSerialization.jsonObject(with: jsonData, options: .allowFragments) as? Parameters
            Alamofire.request(
                methodPath,
                method: .get,
                parameters: dict,
                encoding: URLEncoding.default,
                headers: header
                )
                .validate()
                .responseJSON { (requestData) in
                    completion(requestData)
            }
        } catch { print(error) }
    }
}
