//
//  Field.swift
//  Game1
//
//  Created by Track Ensure on 2021-01-09.
//

import Foundation

class Field {
    
    var size = Size()
    var emptyCellBG = " "
    var fenceBG = "🌵"
    var cells = [Point: String]()
    
    init(width: Int, height: Int) {
        self.size.width = width
        self.size.height = height
    }
    
    subscript(x: Int, y: Int) -> String? {
        get {
            return cells[Point(x: x, y: y)]
        }
        
        set {
            cells[Point(x: x, y: y)] = newValue
        }
    }
}
