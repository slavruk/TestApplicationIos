//
//  TestApplicationIosMockTests.swift
//  TestApplicationIosMockTests
//
//  Created by Stas Lavruk on 5/17/19.
//  Copyright © 2019 Stas Lavruk. All rights reserved.
//

import XCTest

@testable import TestApplicationIos

class TestApplicationIosMockTests: XCTestCase {
    
    var controllerUnderTest: RootVC!
    var mockDownloadVideoListContainer: MockDownloadVideoListContainer?
    var mockVideoInfoContainer: MockVideoInfoContainer?
    
    
    override func setUp() {
        controllerUnderTest = UIStoryboard(name: "RootVC", bundle: nil).instantiateViewController(withIdentifier: "RootViewController") as? RootVC
        mockDownloadVideoListContainer = MockDownloadVideoListContainer()
        mockVideoInfoContainer = MockVideoInfoContainer()
    }
    
    override func tearDown() {
        controllerUnderTest = nil
        mockDownloadVideoListContainer = nil
        mockVideoInfoContainer = nil
    }
    
    func test_getVideoList() {
        guard let videoList = mockDownloadVideoListContainer?.videoList else {
            XCTFail("Error load mockDownloadListManager")
            return
        }
        // Given
        let expectation = self.expectation(description: "Status code: 200")
        XCTAssertTrue(videoList.isEmpty, "The videoObjects array is not empty.")
        mockDownloadVideoListContainer?.downloadVideoList(params: [
            "part": "snippet",
            "maxResults": 10,
            "regionCode": "UA",
            "order": "viewCount",
            "type": "video",
            "key": Constants.API.apiKey ?? ""])
        { (success, result, error) in
            // When
            XCTAssertNotNil(result, "No data")
            if success, let videoList = result as? VideoListModel {
                XCTAssertTrue(success, "Incorrect value.")
                XCTAssertNotNil(videoList, "No data parsed.")
            } else {
                XCTAssertFalse(success, "Incorrect value.")
                XCTAssertGreaterThan(error.count, 0, "No error message.")
            }
            // Then
            XCTAssertEqual(self.mockDownloadVideoListContainer?.videoList.count, 10, "The number of videos in array is not equal to 10.")
            expectation.fulfill()
        }
        waitForExpectations(timeout: 5.0, handler: nil)
    }
    
    func test_getInfoVideoById() {
        // Given
        let testVideoId = "CsKls-A0anc"
        let expectation = self.expectation(description: "Status code: 200.")
        mockVideoInfoContainer?.getVideoById(videoId: testVideoId, completion:
            { (success, result, error) in
                // When
                XCTAssertNotNil(result, "No data")
                if success, let videoInfo = result as? VideoInfoModel {
                    XCTAssertTrue(success, "Incorrect value.")
                    XCTAssertNotNil(videoInfo, "No data parsed.")
                    XCTAssertNotNil(self.mockVideoInfoContainer?.videoObject, "Error properties 'video' in MockVideoInfoContainer equal nil.")
                } else {
                    XCTAssertFalse(success, "Incorrect value.")
                    XCTAssertGreaterThan(error.count, 0, "No error message.")
                }
                // Then
                XCTAssertEqual(self.mockVideoInfoContainer?.videoObject?.viedoId, testVideoId, "Id not equal to expected.")
                expectation.fulfill()
        })
        waitForExpectations(timeout: 5.0, handler: nil)
    }
    
    func test_DownloadVideoList() {
        let params: [String: Any] = [
            "part": "snippet",
            "maxResults": 10,
            "regionCode": "UA",
            "order": "viewCount",
            "type": "video",
            "key": Constants.API.apiKey ?? ""]
        // This is an example of a performance test case.
        self.measure {
            self.mockDownloadVideoListContainer?.downloadVideoList(params: params, completion:
                { (success, result, error) in })
        }
    }
    
    func test_DownloadVideoById() {
        // This is an example of a performance test case.
        self.measure {
            self.mockVideoInfoContainer?.getVideoById(videoId: "CevxZvSJLk8", completion:
                { (success, result, error) in })
        }
    }
}
