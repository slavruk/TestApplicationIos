//
//  TestApplicationIosFakeTests.swift
//  TestApplicationIosFakeTests
//
//  Created by Stas Lavruk on 5/16/19.
//  Copyright © 2019 Stas Lavruk. All rights reserved.
//

import Foundation
import Alamofire

import XCTest

@testable import TestApplicationIos

class TestApplicationIosFakeTests: XCTestCase {
    
    let testVideoId = "CevxZvSJLk8"
    
    var controllerUnderTest: RootVC!
    
    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
        controllerUnderTest = UIStoryboard(name: "RootVC", bundle: nil).instantiateViewController(withIdentifier: "RootViewController") as? RootVC
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        controllerUnderTest = nil
    }
    
    func test_ParseDataVideoList() {
        // Given
        let data = self.stub(urlString: "videoList")
        
        // When
        XCTAssertGreaterThan(data.count, 0, "No data")
        let resultParsed = ResponseDataParser.parse(responseData: data, type: VideoListModel.self)
        
        // Then
//        var data = resultParsed.dataParsed
        XCTAssertNotNil(resultParsed.dataParsed)
        XCTAssertEqual(resultParsed.dataParsed?.items.count, 10)
        XCTAssertNotEqual(data.count, 0)
    }
    
    func test_ParseDataVideoListError() {
        // Given
        let data = self.stub(urlString: "Empty")
        
        // When
        let resultParsed = ResponseDataParser.parse(responseData: data, type: VideoListModel.self)
        
        // Then
        XCTAssertNotNil(data)
        XCTAssertNotEqual(resultParsed.dataParsed?.items.count, 10, "Didn't parse 10 items from fake response")
        XCTAssertEqual(data.count, 0)
    }
    
    
    func test_ParseDataVideo() {
        // Given
        let data = self.stub(urlString: "videoInfo")
        
        // When
        XCTAssertGreaterThan(data.count, 0, "No data")
        let resultParsed = ResponseDataParser.parse(responseData: data, type: VideoInfoModel.self)
        
        // Then
        XCTAssertNotNil(data)
        XCTAssertEqual(resultParsed.dataParsed?.items?.first?.id, testVideoId)
        XCTAssertEqual(resultParsed.dataParsed?.items?.count, 1)
        XCTAssertNotEqual(data.count, 0)
    }
    
    func test_ParseDataVideoError() {
        // Given
        let data = self.stub(urlString: "Empty")
        
        // When
        XCTAssertEqual(data.count, 0)
        let resultParsed = ResponseDataParser.parse(responseData: data, type: VideoInfoModel.self)
        
        // Then
        XCTAssertNotNil(data)
        XCTAssertNotEqual(resultParsed.dataParsed?.items?.count, 0)
        XCTAssertEqual(data.count, 0)
    }
}
