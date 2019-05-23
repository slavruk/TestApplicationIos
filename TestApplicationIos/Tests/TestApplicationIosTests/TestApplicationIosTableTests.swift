//
//  TestApplicationIosTests.swift
//  TestApplicationIosTests
//
//  Created by Stas Lavruk on 5/23/19.
//  Copyright © 2019 Stas Lavruk. All rights reserved.
//

import XCTest

@testable import TestApplicationIos

class TestApplicationIosTableTests: XCTestCase {
    
    var tableCell: RootTableViewCell!
    
    
    override func setUp() {
        tableCell = RootTableViewCell(frame: CGRect())
    }

    override func tearDown() {
        tableCell = nil
    }

    func test_Configure() {
        // Given
        let data = self.stub(urlString: "videoInfo")
        let resultParsed = ResponseDataParser.parse(responseData: data, type: VideoInfoModel.self)
        let testVideoObject = VideoObject(with: resultParsed.dataParsed!)
        
        // When
        tableCell.videoObject = testVideoObject
        XCTAssertNotNil(tableCell.videoObject)
        tableCell.configure()
        //Then
        XCTAssertEqual(testVideoObject.datePublished, "2013-09-05T20:00:22.000Z")
    }
    
    func test_ConvertDateFormat() {
        // Given
        let date = "2013-09-05T20:00:22.000Z"
        let formattedDateString = Date().convertDateFormat(date.trim(firstIndex: date.startIndex, offset: 10))
        // When
        XCTAssertNotNil(formattedDateString)
        XCTAssertEqual(formattedDateString, "05/09/2013")
    }
    
    func test_PrepareForReuse() {
        tableCell.prepareForReuse()
        XCTAssertNil(tableCell.nameVideLabel)
    }
}

extension TestApplicationIosTableTests {
    
    func stub(urlString: String) -> Data {
        let bundle = Bundle(for: type(of: self))
        guard let path = bundle.path(forResource: urlString, ofType: "json") else { return Data() }
        let data = try? Data(contentsOf: URL(fileURLWithPath: path), options: .alwaysMapped)
        return data ?? Data()
    }
}
