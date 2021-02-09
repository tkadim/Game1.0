//
//  Point.swift
//  Game1
//
//  Created by Track Ensure on 2021-01-09.
//

import Foundation
struct Point: Hashable {
    var x = 0
    var y = 0

    init(x: Int, y: Int) {
        self.x = x
        self.y = y
    }
}
