//
//  DateFormatterExtensionsTests.swift
//  banquemisr.challenge05.themoviedbTests
//
//  Created by Essam Fahmy on 12/08/2024.
//

import XCTest

@testable import banquemisr_challenge05_themoviedb

final class DateFormatterExtensionsTests: XCTestCase {
    func testDisplayFormatter() {
        let dateString = "2024-11-25"
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        let expectedDate = dateFormatter.date(from: dateString)
        
        let formattedDate = DateFormatter.displayFormatter.string(from: expectedDate!)
        let expectedFormattedString = "25 Nov 2024"
        
        XCTAssertEqual(formattedDate, expectedFormattedString, "The formatted date should match the expected formatted string.")
    }
    
    func testInvalidDateString() {
        let invalidDateString = "invalid-date"
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        let invalidDate = dateFormatter.date(from: invalidDateString)
        
        XCTAssertNil(invalidDate, "The invalid date string should not convert to a valid date.")
    }
    
    func testEmptyString() {
        let emptyString = ""
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        let emptyDate = dateFormatter.date(from: emptyString)
        
        XCTAssertNil(emptyDate, "The empty string should not convert to a valid date.")
    }
}

