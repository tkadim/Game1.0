//
//  Person.swift
//  Game1
//
//  Created by Track Ensure on 2021-01-09.
//

import Foundation


class Person {
    var gameField: Field
    var box: Box
    var hole: Hole
    let avatar = "🚶"
    var coords: Point{
        
        didSet {
            switch (x: coords.x, y: coords.y) {
            
            case let coord where
                    ( (coord.x < 1) || (coord.x > self.gameField.size.width) ) ||
                    ( (oldValue.x == 2 && coord.x == 1 && box.coords.x == 1 && coord.y == box.coords.y ) || (oldValue.x == (self.gameField.size.width - 1) && coord.x == self.gameField.size.width && box.coords.x == self.gameField.size.width && coord.y == box.coords.y ) ) ||
                    ( (coord.x == hole.coords.x) && (oldValue.y == hole.coords.y) ):
                
                coords.x = oldValue.x
                
            
            case let coord where
                    ( (coord.y < 1) || (coord.y > self.gameField.size.height) ) ||
                    ( (oldValue.y == 2 && coord.y == 1 && box.coords.y == 1 && coord.x == box.coords.x ) || (oldValue.y == (self.gameField.size.height - 1) && coord.y == self.gameField.size.height && box.coords.y == self.gameField.size.height && coord.x == box.coords.x ) ) ||
                    ( (coord.y == hole.coords.y) && (oldValue.x == hole.coords.x) ):
                
                coords.y = oldValue.y
            
            case let coord where (coord.x == box.coords.x && coord.y == box.coords.y) && coord.x > oldValue.x :
                
                box.move(direction: .right)
                updatePersonFieldPosition(oldPosition: oldValue, newPosition: coords)

            case let coord where (coord.x == box.coords.x && coord.y == box.coords.y) && coord.x < oldValue.x :
                
                box.move(direction: .left)
                updatePersonFieldPosition(oldPosition: oldValue, newPosition: coords)

            case let coord where (coord.x == box.coords.x && coord.y == box.coords.y) && coord.y > oldValue.y :
                
                box.move(direction: .down)
                updatePersonFieldPosition(oldPosition: oldValue, newPosition: coords)

            case let coord where (coord.x == box.coords.x && coord.y == box.coords.y) && coord.y < oldValue.y :
                
                box.move(direction: .up)
                updatePersonFieldPosition(oldPosition: oldValue, newPosition: coords)

            default:
                updatePersonFieldPosition(oldPosition: oldValue, newPosition: coords)

            }

        }
    }
   
    
    init(gameField: Field, box: Box, hole: Hole, coords: Point ) {
        self.gameField = gameField
        self.box = box
        self.hole = hole
        self.coords = coords
        
    }

    func go(direction: Direction) {
        switch direction {
        case .up:
            self.coords.y -= 1
        case .down:
            self.coords.y += 1
        case .left:
            self.coords.x -= 1
        case .right:
            self.coords.x += 1

        }
    }
    
    func updatePersonFieldPosition(oldPosition: Point, newPosition: Point) {
        gameField[oldPosition.x, oldPosition.y] = gameField.emptyCellBG
        gameField[newPosition.x, newPosition.y] = self.avatar
    }

}
