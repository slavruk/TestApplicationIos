//
//  ContryObject.swift
//  TestApplicationIos
//
//  Created by Stas Lavruk on 06/05/2019.
//  Copyright © 2019 Stas Lavruk. All rights reserved.
//

import Foundation

struct CountryObject {
    
    let flagUrl: String
    let name: String
    let alphaCode: String
    
    init(flagUrl: String, name: String, alphaCode: String) {
        self.flagUrl = flagUrl
        self.name = name
        self.alphaCode = alphaCode
    }
}
