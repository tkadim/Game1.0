//
//  MoveBoxGame.swift
//  Game1
//
//  Created by Track Ensure on 2021-01-10.
//

import Foundation

class MoveBoxGame {
    var gameOver = false
    var gameField: Field
    var box: Box
    var person: Person
    var hole: Hole
    
    init(gameField: Field, box: Box, person: Person, hole: Hole) {
        self.gameField = gameField
        self.box = box
        self.person = person
        self.hole = hole
        
        var y = 0

        while y <= gameField.size.height + 1  {
            var x = 0

            while x <= gameField.size.width + 1 {
                
                switch (x, y) {

                case let coord where
                        (coord.1 == 0 || coord.1 == gameField.size.height + 1) ||
                        (coord.0 == 0 || coord.0 == gameField.size.width + 1):
                    
                    gameField[x, y] = gameField.fenceBG

                case let coord where coord.0 == person.coords.x && coord.1 == person.coords.y:

                    gameField[x, y] = person.avatar

                case let coord where coord.0 == box.coords.x && coord.1 == box.coords.y:

                    gameField[x, y] = box.avatar

                case let coord where coord.0 == hole.coords.x && coord.1 == hole.coords.y:

                    gameField[x, y] = hole.avatar

                default:

                    gameField[x, y] = gameField.emptyCellBG
                }
                x += 1
            }
            y += 1
        }
    }
    
    func printCurrentFieldState() -> [String] {
        var fieldString = [String]()
        var y = 0

        while (y <= gameField.size.height + 1)  {
            var x = 0

            while (x <= gameField.size.width + 1) {
                fieldString.append(gameField[x, y] ?? gameField.emptyCellBG)
//                if(x == gameField.size.width + 1){
//                    fieldString += "\n"
//                }
                x += 1
            }
            y += 1
        }
        return fieldString
    }
}
