//
//  StringExtensionsTests.swift
//  banquemisr.challenge05.themoviedbTests
//
//  Created by essamfahmy on 27/11/2024.
//

import XCTest

@testable import banquemisr_challenge05_themoviedb

final class StringExtensionsTests: XCTestCase {
    func testInvalidStringToDateConversion() {
        let invalidDateString = "invalid-date"
        let convertedDate = invalidDateString.toDate(using: "yyyy-MM-dd")
        XCTAssertNil(convertedDate, "The conversion should return nil for an invalid date string.")
    }

    func testStringToDisplayDateConversion() {
        let dateString = "2024-11-25"
        let displayDate = dateString.toDisplayDate(using: "yyyy-MM-dd")
        XCTAssertEqual(displayDate, "25 Nov 2024", "The formatted display date should match the expected formatted date.")
    }

    func testInvalidStringToDisplayDateConversion() {
        let invalidDateString = "invalid-date"
        let displayDate = invalidDateString.toDisplayDate(using: "yyyy-MM-dd")
        XCTAssertEqual(displayDate, invalidDateString)
    }
}
