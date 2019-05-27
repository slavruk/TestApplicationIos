//
//  AFNetworkManager.swift
//  TestApplicationIos
//
//  Created by Stas Lavruk on 03/05/2019.
//  Copyright © 2019 Stas Lavruk. All rights reserved.
//

import Foundation
import Alamofire
import PromiseKit


protocol AFNetworkProtocol {
    var header: HTTPHeaders? { get }
    func getRequestWith<Request: Codable, Response: Codable>(methodPath: URL, params: Request, response: Response.Type) -> Promise<Response>
}

class AFNetworkManager: AFNetworkProtocol {
    
    
    var sessionManager: SessionManager
    
    var header: HTTPHeaders? {
        return ["Content-Type": "application/json",
                "Accept": "application/json"]
    }
    
    init(_ sessionManager: SessionManager = SessionManager.default) {
        self.sessionManager = sessionManager
    }
    
    func getRequestWith<Request: Codable, Response: Codable>(methodPath: URL, params: Request, response: Response.Type) -> Promise<Response> {
        let encoder = JSONEncoder()
        let jsonData = try! encoder.encode(params)
        let dict = try? JSONSerialization.jsonObject(with: jsonData, options: .allowFragments) as? Parameters
        return sessionManager.request(methodPath, method: .get, parameters: dict, encoding: URLEncoding.default, headers: header).responseDecodable(Response.self)
    }
}
