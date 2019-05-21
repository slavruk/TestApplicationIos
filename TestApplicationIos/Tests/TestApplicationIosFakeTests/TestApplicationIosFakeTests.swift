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
    
    var controllerUnderTest: RootVC!
    
    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
        controllerUnderTest = UIStoryboard(name: "RootVC", bundle: nil).instantiateViewController(withIdentifier: "RootViewController") as? RootVC
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        controllerUnderTest = nil
    }
    
    func test_RequestSearchVideoList() {
        // Given
        let expectation = self.expectation(description: "Status code: 200")
        let url = Constants.API.searchViedos
        let params: [String: Any] = [
            "part": "snippet",
            "maxResults": 10,
            "regionCode": "UA",
            "order": "viewCount",
            "type": "video",
            "key": Constants.API.apiKey ?? ""]
        // When
        AFNetworkManager.getRequestWith(methodPath: url, params: params) { (response) in
            // Then
            XCTAssertNil(response.error, "Error \(response.error!.localizedDescription)")
            XCTAssertNotNil(response, "No response")
            XCTAssertEqual(response.response?.statusCode ?? 0, 200, "Status code not 200")
            expectation.fulfill()
        }
        waitForExpectations(timeout: 5.0, handler: nil)
    }
    
    func test_RequestGetVideoById() {
        // Given
        let expectation = self.expectation(description: "Status code: 200")
        let url = Constants.API.getVideoById
        let params: [String: Any] = [
            "part": "snippet,contentDetails,statistics",
            "id": "CevxZvSJLk8",
            "key": Constants.API.apiKey ?? ""]
        // When
        AFNetworkManager.getRequestWith(methodPath: url, params: params) { (response) in
            // Then
            XCTAssertNil(response.error, "Error \(response.error!.localizedDescription)")
            XCTAssertNotNil(response, "No response")
            XCTAssertEqual(response.response?.statusCode ?? 0, 200, "Status code not 200")
            expectation.fulfill()
        }
        waitForExpectations(timeout: 5.0, handler: nil)
    }
    
    func test_ParseDataVideoList() {
        // Given
        let data = self.stub(urlString: "videoList")
        
        // When
        XCTAssertGreaterThan(data.count, 0, "No data")
        let resultParsed = ResponseDataParser.parse(responseData: data, type: VideoListModel.self)
        
        // Then
        if let data = resultParsed.dataParsed {
            XCTAssertNotNil(data)
            XCTAssertEqual(data.items.count, 10, "Didn't parse 10 items from fake response")
        } else {
            XCTFail("Parsing json error")
        }
    }
    
    
    
    func test_ParseDataVideo() {
        // Given
        let data = self.stub(urlString: "videoInfo")
        
        // When
        XCTAssertGreaterThan(data.count, 0, "No data")
        let resultParsed = ResponseDataParser.parse(responseData: data, type: VideoInfoModel.self)
        
        // Then
        if let data = resultParsed.dataParsed {
            XCTAssertNotNil(data)
        } else {
            XCTFail("Parsing json error")
        }
    }
}
