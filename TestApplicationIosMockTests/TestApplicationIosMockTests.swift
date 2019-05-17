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
    
    var videoList: [Item] = []
    
    func downloadVideoList(params: [String : Any]) {
        LSActivityIndicator.showIndicator(fullScreen: false)
        ServerAPIManager.getVideosList(params: params)
        { (result, success, error) in
            LSActivityIndicator.hideIndicator()
            if success, let videoList = result as? VideoListModel {
                self.videoList = videoList.items
            } else {
                //UIHelper.showConfirmationAlertWith(title: "Error", message: error, action: nil, inViewController: self)
            }
        }
    }
    
    func getVideoList() -> [AnyObject] {
        return videoList as [AnyObject]
    }
    
    
}

class TestApplicationIosMockTests: XCTestCase {

    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testExample() {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
    }

    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }

}
