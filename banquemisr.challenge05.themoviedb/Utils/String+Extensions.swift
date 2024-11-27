//
//  String+Extensions.swift
//  banquemisr.challenge05.themoviedb
//
//  Created by essamfahmy on 27/11/2024.
//

import Foundation

extension String {
    // Convert a string to Date using a specific format
    func toDate(using format: String = "yyyy-MM-dd") -> Date? {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = format
        return dateFormatter.date(from: self)
    }

    // Convert a string to a display-friendly formatted date string
    func toDisplayDate(using format: String = "yyyy-MM-dd") -> String {
        guard let date = self.toDate(using: format) else {
            return self
        }
        return DateFormatter.displayFormatter.string(from: date)
    }
}
