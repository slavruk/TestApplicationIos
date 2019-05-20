//
//  TestApplicationIosMockTests.swift
//  TestApplicationIosMockTests
//
//  Created by Stas Lavruk on 5/17/19.
//  Copyright © 2019 Stas Lavruk. All rights reserved.
//

import XCTest

@testable import TestApplicationIos

class MockDownloadVideoListManager: DownloadVideoListProtocol {
    
    var videolist: [Item]
    
    init() {
        videolist = []
    }
    
    func downloadVideoList(params: [String : Any], completion: @escaping (DowloadVideoCompetionHandler)) {
        LSActivityIndicator.showIndicator(fullScreen: false)
        ServerAPIManager.getVideosList(params: params)
        { (result, success, error) in
            LSActivityIndicator.hideIndicator()
            if success, let videoList = result as? VideoListModel {
                self.videolist = videoList.items
                completion(true, "")
            } else {
                completion(false, error ?? "error")
            }
        }
    }
    
    
}

class TestApplicationIosMockTests: XCTestCase {
    
    var controllerUnderTest: RootVC!
    var mockDownloadVideoListManager: MockDownloadVideoListManager?
	
    override func setUp() {
        controllerUnderTest = UIStoryboard(name: "RootVC", bundle: nil).instantiateViewController(withIdentifier: "RootViewController") as? RootVC
        mockDownloadVideoListManager = MockDownloadVideoListManager()
    }

    override func tearDown() {
        controllerUnderTest = nil
        mockDownloadVideoListManager = nil
    }

    func test_downloadVideoList() {
        guard let videoList = mockDownloadVideoListManager?.videolist else {
            XCTFail("Error load mockDownloadListManager")
            return
        }
        //Given
        let expectation = self.expectation(description: "Status code: 200")
        XCTAssertTrue(videoList.isEmpty, "The videoObjects array is not empty.")
        mockDownloadVideoListManager?.downloadVideoList(params: [
            "part": "snippet",
            "maxResults": 10,
            "regionCode": "UA",
            "order": "viewCount",
            "type": "video",
            "key": Constants.API.apiKey])
        { (success, error) in
            // When
            if success {
                XCTAssertTrue(success, "Data not loaded")
            } else {
                XCTAssertGreaterThan(error.count, 0, "No error message.")
            }
            // Then
            XCTAssertEqual(self.mockDownloadVideoListManager?.videolist.count, 10, "The number of videos in array is not equal to 10.")
            expectation.fulfill()
        }
        waitForExpectations(timeout: 5.0, handler: nil)
    }

    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }

}
