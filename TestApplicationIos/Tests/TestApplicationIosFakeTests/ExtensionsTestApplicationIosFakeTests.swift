//
//  ExtensionsTestApplicationIosFakeTests.swift
//  TestApplicationIosFakeTests
//
//  Created by Stas Lavruk on 5/16/19.
//  Copyright © 2019 Stas Lavruk. All rights reserved.
//

import Foundation

extension TestApplicationIosFakeTests {
    
    func stub(urlString: String) -> Data {
        let bundle = Bundle(for: type(of: self))
        guard let path = bundle.path(forResource: urlString, ofType: "json") else { return Data() }
        let data = try? Data(contentsOf: URL(fileURLWithPath: path), options: .alwaysMapped)
        return data ?? Data()
    }
}
