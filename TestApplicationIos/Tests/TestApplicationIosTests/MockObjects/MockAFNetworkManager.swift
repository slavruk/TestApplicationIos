//
//  MockAFNetworkManager.swift
//  TestApplicationIos
//
//  Created by Stas Lavruk on 5/22/19.
//  Copyright © 2019 Stas Lavruk. All rights reserved.
//

import Foundation
import Alamofire

@testable import TestApplicationIos

class MockAFNetworkManager: AFNetworkProtocol {
    
    var header: HTTPHeaders? {
        return ["Content-Type": "application/json",
                "Accept": "application/json"]
    }
    
    init() {}
    
    func getRequestWith<T>(methodPath: URL, params: T, completion: @escaping (_ responseData: (DataResponse<Any>)) -> ()) {
        let bundle = Bundle(for: type(of: self))
        guard let path = bundle.path(forResource: methodPath.path, ofType: "json") else { return }
        do {
            let data = try Data(contentsOf: URL(fileURLWithPath: path), options: .alwaysMapped)
            let result = Alamofire.Result<Any>.success(Data())
            let dataRequest = DataResponse<Any>.init(request: nil, response: nil, data: data, result: result)
            completion(dataRequest)
        }
        catch { print(error) }
    }
}
