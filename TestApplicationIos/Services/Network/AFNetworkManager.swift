//
//  AFNetworkManager.swift
//  TestApplicationIos
//
//  Created by Stas Lavruk on 03/05/2019.
//  Copyright © 2019 Stas Lavruk. All rights reserved.
//

import Foundation
import Alamofire

class AFNetworkManager {
    
    static let shared = AFNetworkManager()
    
    private class var header: HTTPHeaders? {
        return ["Content-Type": "application/json",
                "Accept": "application/json"]
    }
    
//    class func getRequestWith(methodPath: URL,
//                              params: Data,
//                              completion: @escaping (_ responseData: (DataResponse<Any>)) -> ()) {
//        var request = URLRequest(url: methodPath)
//        request.httpMethod = HTTPMethod.put.rawValue
//        request.setValue("application/json; charset=UTF-8", forHTTPHeaderField: "Content-Type")
//        request.httpBody = params
//        Alamofire.request(request).responseJSON { (requestData) in
//            completion(requestData)
//        }
//    }
    
    class func getRequestWith(methodPath: URL,
                              params:[String:Any]?,
                              completion: @escaping (_ responseData: (DataResponse<Any>)) -> ()) {
        Alamofire.request(methodPath,
                          method: .get,
                          parameters: params,
                          headers: header).responseJSON { (requestData) in
                            completion(requestData)
        }.validate()
    }
}
