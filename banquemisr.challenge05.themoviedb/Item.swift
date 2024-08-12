//
//  Item.swift
//  banquemisr.challenge05.themoviedb
//
//  Created by Essam Fahmy on 12/08/2024.
//

import Foundation
import SwiftData

@Model
final class Item {
    var timestamp: Date
    
    init(timestamp: Date) {
        self.timestamp = timestamp
    }
}
