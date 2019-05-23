//
//  MockSessionManger.swift
//  TestApplicationIos
//
//  Created by Stas Lavruk on 5/23/19.
//  Copyright © 2019 Stas Lavruk. All rights reserved.
//

import UIKit
//import Alamofire

@testable import Alamofire

class Request {
    
    var patch: String
    
    init(patch: String){
        self.patch = patch
    }
    
    func responseJSON(options: JSONSerialization.ReadingOptions = .allowFragments, completionHandler: @escaping (DataResponse<Any>) -> Void) {
        let bundle = Bundle(for: type(of: self))
        let path = bundle.path(forResource: patch, ofType: "json")!
        do {
            let data = try Data(contentsOf: URL(fileURLWithPath: path), options: .alwaysMapped)
            let result = Alamofire.Result<Any>.success(Data())
            let dataRequest = DataResponse<Any>.init(request: nil, response: nil, data: data, result: result)
            completionHandler(dataRequest)
        }
        catch { print(error) }
    }
    
    func request(pathcFile: String) -> Request {
        
        return Request(patch: pathcFile)
    }
}

//class MockDataRequest: Alamofire.Request {
//
//    override init(session: URLSession, requestTask: Alamofire.Request.RequestTask, error: Error? = nil) {
//
//    }
//    //    override func responseJSON(queue: DispatchQueue? = nil, options: JSONSerialization.ReadingOptions = .allowFragments, completionHandler: @escaping (DataResponse<Any>) -> Void) -> Self {
//    //
//    //    }
//}

class MockDataRequest: Alamofire.DataRequest {
    
    override init(session: URLSession, requestTask: Alamofire.Request.RequestTask, error: Error? = nil) {
        super.init(session: session, requestTask: requestTask)
    }
    
    override func responseJSON(queue: DispatchQueue? = nil, options: JSONSerialization.ReadingOptions = .allowFragments, completionHandler: @escaping (DataResponse<Any>) -> Void) -> Self {
        
    }
    
}
