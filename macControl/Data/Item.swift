//
//  Item.swift
//  macControl
//
//  Created by Alejandro Garcia on 17/8/23.
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
