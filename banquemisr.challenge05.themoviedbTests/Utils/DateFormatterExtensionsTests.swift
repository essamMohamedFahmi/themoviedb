//
//  DateFormatterExtensionsTests.swift
//  banquemisr.challenge05.themoviedbTests
//
//  Created by Essam Fahmy on 12/08/2024.
//

import XCTest

@testable import banquemisr_challenge05_themoviedb

final class DateFormatterExtensionsTests: XCTestCase {
    func testAPIFormatter() {
        let dateString = "2024-11-22"
        let date = DateFormatter.apiFormatter.date(from: dateString)
        XCTAssertNotNil(date, "The API formatter should parse the date string successfully.")
    }

    func testDisplayFormatter() {
        let date = DateFormatter.apiFormatter.date(from: "2024-11-22")
        XCTAssertNotNil(date, "The API formatter should parse the date string successfully.")
        
        let displayString = DateFormatter.displayFormatter.string(from: date!)
        XCTAssertEqual(displayString, "Nov 22, 2024", "The display formatter should correctly format the date for presentation.")
    }
}
