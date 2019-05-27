//
//  TestApplicationIosMockTests.swift
//  TestApplicationIosMockTests
//
//  Created by Stas Lavruk on 5/17/19.
//  Copyright © 2019 Stas Lavruk. All rights reserved.
//

import XCTest
import Alamofire

@testable import TestApplicationIos

class TestApplicationIosMockTests: XCTestCase {
    
    let testVideoId = "CevxZvSJLk8"
    let timeOutValue = 5.0
    
    var controllerUnderTest: RootVC?
    var mockDownloadVideoListContainer: VideoListContainer?
    var mockVideoInfoContainer: VideoInfoContainer?
    var networkManager: AFNetworkManager!
    
    var requestParamsVideoList: VideoListRequest?
    
    override func setUp() {
        requestParamsVideoList = VideoListRequest(
            maxResults: 10,
            regionCode: "UA",
            q: "")
        controllerUnderTest = RootVC()
        controllerUnderTest?.videoListContainer = MockVideoListContainer(MockAFNetworkManager())
        controllerUnderTest?.videoInfoContainer = MockVideoInfoContainer(MockAFNetworkManager())
        mockDownloadVideoListContainer = VideoListContainer()
        mockDownloadVideoListContainer?.networkManager = MockAFNetworkManager()
        mockVideoInfoContainer = VideoInfoContainer()
        mockVideoInfoContainer?.networkManager = MockAFNetworkManager()
        networkManager = AFNetworkManager()
    }
    
    override func tearDown() {
        controllerUnderTest = nil
        mockDownloadVideoListContainer = nil
        mockVideoInfoContainer = nil
        networkManager = nil
    }
    
    func test_RootVCgetVideoListSuccess() {
        // Given
        let expectation = self.expectation(description: "Status code: 200")
        controllerUnderTest?.getVideoList(params: requestParamsVideoList!)
        // When
        XCTAssertNotEqual(controllerUnderTest?.countVideosInList, 0)
        XCTAssertEqual(controllerUnderTest?.countVideosInList, 10)
        XCTAssertEqual(controllerUnderTest?.videoObjects.count, 10)
        expectation.fulfill()
        waitForExpectations(timeout: timeOutValue, handler: nil)
    }
    
    func test_getVideoList() {
        let videoListContainer = mockDownloadVideoListContainer?.videoList
        // Given
        let expectation = self.expectation(description: "Status code: 200")
        XCTAssertTrue(videoListContainer!.isEmpty)
        mockDownloadVideoListContainer?.downloadVideoList(requestURL: URL(string: "videoList")!, params: requestParamsVideoList!)
        { (success, result, error) in
            // When
            XCTAssertNotNil(result)
            XCTAssertTrue(success)
            XCTAssertNil(error)
            let videoList = result as? VideoListModel
            XCTAssertNotNil(videoList)
            XCTAssertEqual(videoList?.items.count, 10)
            expectation.fulfill()
        }
        waitForExpectations(timeout: timeOutValue, handler: nil)
    }
    
    func test_getVideoListServerError() {
        let videoListContainer = mockDownloadVideoListContainer?.videoList
        // Given
        let expectation = self.expectation(description: "Status code: 200")
        XCTAssertTrue(videoListContainer!.isEmpty)
        mockDownloadVideoListContainer?.downloadVideoList(requestURL: URL(string: "Empty")!, params: requestParamsVideoList!)
        { (success, result, error) in
            // When
            XCTAssertNil(result)
            XCTAssertFalse(success)
            XCTAssertNotNil(error)
            XCTAssertEqual(error, "Server error")
            expectation.fulfill()
        }
        waitForExpectations(timeout: timeOutValue, handler: nil)
    }
    
    func test_getInfoVideoById() {
        // Given
        let expectation = self.expectation(description: "Status code: 200.")
        mockVideoInfoContainer?.getVideoById(requestURL: URL(string: "videoInfo")!, params: VideoInfoRequest(id: testVideoId))
        { (success, result, error) in
            // When
            XCTAssertNotNil(result)
            XCTAssertTrue(success)
            XCTAssertNil(error)
            let videoInfo = result as? VideoInfoModel
            XCTAssertNotNil(videoInfo)
            XCTAssertEqual(videoInfo?.items?.count, 1)
            XCTAssertEqual(videoInfo?.items?.first?.id, self.testVideoId)
            expectation.fulfill()
        }
        waitForExpectations(timeout: timeOutValue, handler: nil)
    }
    
    func test_getInfoVideoByIdServerError() {
        // Given
        let expectation = self.expectation(description: "Status code: 200.")
        mockVideoInfoContainer?.getVideoById(requestURL: URL(string: "Empty")!, params: VideoInfoRequest(id: testVideoId))
        { (success, result, error) in
            // When
            XCTAssertNil(result)
            XCTAssertFalse(success)
            XCTAssertNotNil(error)
            XCTAssertEqual(error, "Server error")
            expectation.fulfill()
        }
        waitForExpectations(timeout: timeOutValue, handler: nil)
    }
    
    func test_getRequestWith() {
        // Given
        let expectation = self.expectation(description: "Status code: 200.")
        // When
        networkManager.getRequestWith(methodPath: Constants.API.getVideoById, params: VideoInfoRequest(id: testVideoId))
        { (responseData) in
            // Then
            XCTAssertNotNil(responseData.request)
            XCTAssertNotNil(responseData.response)
            XCTAssertNotNil(responseData.data)
            XCTAssertNil(responseData.error)
            XCTAssertEqual(responseData.response?.statusCode, 200)
            expectation.fulfill()
        }
        waitForExpectations(timeout: timeOutValue, handler: nil)
    }
    
    func test_getRequestWithError() {
        // Given
        let expectation = self.expectation(description: "Status code: 200.")
        // When
        networkManager.getRequestWith(methodPath: URL(string: "https://www.googleapis.com/youtube1/v3/search")!, params: VideoInfoRequest(id: testVideoId))
        { (responseData) in
            // Then
            XCTAssertNotNil(responseData.request)
            XCTAssertNotNil(responseData.response)
            XCTAssertNotNil(responseData.data)
            XCTAssertNotNil(responseData.error)
            XCTAssertEqual(responseData.response?.statusCode, 404)
            expectation.fulfill()
        }
        waitForExpectations(timeout: timeOutValue, handler: nil)
    }
    
    //    func test_DownloadVideoList() {
    //        // This is an example of a performance test case.
    //        self.measure {
    //            self.mockDownloadVideoListContainer?.downloadVideoList(requestURL: URL(string: "videoList")!, params: requestParamsVideoList!)
    //            { (success, result, error) in
    //
    //            }
    //        }
    //    }
    //
    //    func test_DownloadVideoById() {
    //        // This is an example of a performance test case.
    //        self.measure {
    //            self.mockVideoInfoContainer?.getVideoById(requestURL: URL(string: "videoInfo")!, params: VideoInfoRequest(id: testVideoId))
    //            { (success, result, error) in
    //            }
    //        }
    //    }
}
