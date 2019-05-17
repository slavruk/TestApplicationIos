//
//  TestApplicationIosTests.swift
//  TestApplicationIosTests
//
//  Created by Stas Lavruk on 5/17/19.
//  Copyright © 2019 Stas Lavruk. All rights reserved.
//

import XCTest

@testable import TestApplicationIos

class TestApplicationIosTests: XCTestCase {
    
    var controllerUnderTest: RootVC!
    
    override func setUp() {
        controllerUnderTest = UIStoryboard(name: "RootVC", bundle: nil).instantiateViewController(withIdentifier: "RootViewController") as? RootVC
    }
    
    override func tearDown() {
        controllerUnderTest = nil
    }
    
    
    
    func test_AddingVideoObject() {
        // Given
        var objectsArray: [Item] = []
        let data = self.stub(urlString: "videoList")
        // When
        let resultParsed = ResponseDataParser.parse(responseData: data, type: VideoListModel.self)
        if let dataPatsed = resultParsed.dataParsed {
            XCTAssertNotNil(dataPatsed, "No data")
            objectsArray = dataPatsed.items
        } else {
            XCTAssertNotNil(resultParsed, "Parse Error")
        }
        XCTAssertFalse(objectsArray.isEmpty, "objectsArray not empty.")
        // Then
        XCTAssertEqual(controllerUnderTest.videoList.count, 0, "The number of videoObject in array is 0.")
        controllerUnderTest.updateSearchVideoList(videoList: objectsArray)
        XCTAssertEqual(controllerUnderTest.videoList.count, 10, "The number of videoObject in array is 10.")
    }
    
    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }
}

extension TestApplicationIosTests {
    func stub(urlString: String) -> Data {
        let bundle = Bundle(for: type(of: self))
        let path = bundle.path(forResource: urlString, ofType: "json")
        let data = try? Data(contentsOf: URL(fileURLWithPath: path!), options: .alwaysMapped)
        return data ?? Data()
    }
    
}
