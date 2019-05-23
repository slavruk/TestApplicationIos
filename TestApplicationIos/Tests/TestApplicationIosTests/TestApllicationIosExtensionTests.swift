//
//  TestApllicationIosExtensionTests.swift
//  TestApplicationIosTests
//
//  Created by Stas Lavruk on 5/23/19.
//  Copyright © 2019 Stas Lavruk. All rights reserved.
//

import XCTest

@testable import TestApplicationIos

class TestApllicationIosExtensionTests: XCTestCase {

    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func test_ConvertDateFormat() {
        // Given
        let date = "2013-09-05T20:00:22.000Z"
        let formattedDateString = Date().convertDateFormat(date.trim(firstIndex: date.startIndex, offset: 10))
        // When
        XCTAssertNotNil(formattedDateString)
        XCTAssertEqual(formattedDateString, "05/09/2013")
    }
    
    func test_convertYTFormattedDuration() {
        // Given
        let duration = "PT4M30S"
        // When
        let result = duration.convertYTFormattedDuration()
        // Then
        XCTAssertNotNil(result)
        XCTAssertEqual(result, "04:30")
    }

}
