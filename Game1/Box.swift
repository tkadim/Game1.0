//
//  Box.swift
//  Game1
//
//  Created by Track Ensure on 2021-01-09.
//

import Foundation

class Box {
    var hitTheHole = false
    var deadEnd = false
    var gameField: Field
    var hole: Hole
    let avatar = "🥡"
    var coords: Point{
        didSet {
            if((coords.x < 1) || (coords.x > self.gameField.size.width)){
                coords.x = oldValue.x
            } else if((coords.y < 1) || (coords.y > self.gameField.size.height)){
                coords.y = oldValue.y
            } else if((coords.x == hole.coords.x) && (coords.y == hole.coords.y)){
                gameField[coords.x, coords.y] = hole.avatar
                hitTheHole = true
            } else if( (((coords.x == 1) || (coords.x == self.gameField.size.width) || (coords.y == 1) || (coords.y == self.gameField.size.height)) &&
                        (hole.coords.x > 1) && (hole.coords.x < self.gameField.size.width) && (hole.coords.y > 1) && (hole.coords.y < self.gameField.size.height)) ||
                        
                        ( ((coords.x == 1)||(coords.y == self.gameField.size.height)||(coords.x == self.gameField.size.width)) && hole.coords.y == 1 && hole.coords.x > 1 && hole.coords.x < self.gameField.size.width ) ||
                
                        ( ((coords.y == 1)||(coords.x == 1)||(coords.y == self.gameField.size.height)) && hole.coords.x == self.gameField.size.width && hole.coords.y > 1 && hole.coords.y < self.gameField.size.height ) ||
                
                        ( ((coords.x == 1)||(coords.y == 1)||(coords.x == self.gameField.size.width)) && hole.coords.y == self.gameField.size.height && hole.coords.x > 1 && hole.coords.x < self.gameField.size.width ) ||
                
                        ( ((coords.y == 1)||(coords.x == self.gameField.size.width)||(coords.y == self.gameField.size.height)) && hole.coords.x == 1 && hole.coords.y > 1 && hole.coords.y < self.gameField.size.height )
                    )
                        
                        {
                gameField[coords.x, coords.y] = self.avatar
                deadEnd = true
            } else {
                gameField[coords.x, coords.y] = self.avatar
            }
        }
    }
   
    init(gameField: Field, hole: Hole, coords: Point) {
        
        self.gameField = gameField
        self.hole = hole
        self.coords = coords
        
    }
    
    func move(direction: Direction) {
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
}
