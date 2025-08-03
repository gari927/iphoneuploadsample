//
//  Item.swift
//  iphoneuploadsample
//
//  Created by 宮内耕介 on 2025/08/03.
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
