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
    
    let testVideoId = "CsKls-A0anc"
    
    var controllerUnderTest: RootVC!
    var mockDownloadVideoListContainer: MockDownloadVideoListContainer?
    var mockVideoInfoContainer: MockVideoInfoContainer?
    
    var requestParamsVideoList: VideoListRequest?
    
    override func setUp() {
        requestParamsVideoList = VideoListRequest(
            maxResults: 10,
            regionCode: "UA",
            q: "")
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
        mockDownloadVideoListContainer?.downloadVideoList(params: requestParamsVideoList!)
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
        let expectation = self.expectation(description: "Status code: 200.")
        mockVideoInfoContainer?.getVideoById(params: VideoInfoRequest(id: testVideoId))
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
            XCTAssertEqual(self.mockVideoInfoContainer?.videoObject?.viedoId, self.testVideoId, "Id not equal to expected.")
            expectation.fulfill()
        }
        waitForExpectations(timeout: 5.0, handler: nil)
    }
    
    func test_DownloadVideoList() {
        // This is an example of a performance test case.
        self.measure {
            self.mockDownloadVideoListContainer?.downloadVideoList(params: requestParamsVideoList!)
            { (success, result, error) in
                if success, let _ = result as? VideoInfoModel {
                    print("Success")
                } else {
                    print("Error")
                }
            }
        }
    }
    
    func test_DownloadVideoById() {
        // This is an example of a performance test case.
        self.measure {
            self.mockVideoInfoContainer?.getVideoById(params: VideoInfoRequest(id: testVideoId))
            { (success, result, error) in
                if success, let _ = result as? VideoInfoModel {
                    print("Success")
                } else {
                    print("Error")
                }
            }
        }
    }
}
