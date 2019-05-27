//
//  AlamofireExtensions.swift
//  TestApplicationIos
//
//  Created by Stas Lavruk on 5/27/19.
//  Copyright © 2019 Stas Lavruk. All rights reserved.
//

import Foundation
import Alamofire
import PromiseKit

extension Alamofire.DataRequest {
    
    public func responseJSON() -> Promise<DataResponse<Any>> {
        return Promise { seal in
            responseJSON() { response in
                switch response.result {
                case .success(let value):
                    seal.fulfill(response)
                case .failure(let error):
                    seal.reject(error)
                }
            }
        }
    }
}
