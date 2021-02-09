//
//  TableViewController.swift
//  Game1
//
//  Created by Track Ensure on 2021-01-17.
//

import Foundation
import UIKit

class TableViewController: UITableViewController{
    
    @IBOutlet weak var gameFieldWidth: UITextField!
    @IBOutlet weak var gameFieldHeight: UITextField!
    
    @IBOutlet weak var holeXCoordinate: UITextField!
    @IBOutlet weak var holeYCoordinate: UITextField!
    
    @IBOutlet weak var boxXCoordinate: UITextField!
    @IBOutlet weak var boxYCoordinate: UITextField!
    
    @IBOutlet weak var personXCoordinate: UITextField!
    @IBOutlet weak var personYCoordinate: UITextField!
    
    @IBAction func fieldStepper(_ sender: UIStepper) {
        sender.minimumValue = 4
        sender.maximumValue = 10
        sender.stepValue = 1
        
        switch(sender.tag){
        case 0:
            gameFieldWidth.text = String(Int(sender.value))
        case 1:
            gameFieldHeight.text = String(Int(sender.value))
        default: break
        }
    }
    
    @IBAction func holeStepper(_ sender: UIStepper) {
        sender.minimumValue = 1
        sender.stepValue = 1
        
        switch(sender.tag){
        case 0:
            sender.maximumValue = Double(Int(gameFieldWidth.text!)!)
            holeXCoordinate.text = String(Int(sender.value))
        case 1:
            sender.maximumValue = Double(Int(gameFieldHeight.text!)!)
            holeYCoordinate.text = String(Int(sender.value))
        default: break
        }
    }
    
    @IBAction func boxStepper(_ sender: UIStepper) {
        sender.minimumValue = 2
        sender.stepValue = 1
        
        switch(sender.tag){
        case 0:
            sender.maximumValue = Double(Int(gameFieldWidth.text!)!) - 1
            boxXCoordinate.text = String(Int(sender.value))
        case 1:
            sender.maximumValue = Double(Int(gameFieldHeight.text!)!) - 1
            boxYCoordinate.text = String(Int(sender.value))
        default: break
        }
        
    }
    
    @IBAction func personStepper(_ sender: UIStepper) {
        sender.minimumValue = 1
        sender.stepValue = 1
        
        switch(sender.tag){
        case 0:
            sender.maximumValue = Double(Int(gameFieldWidth.text!)!)
            personXCoordinate.text = String(Int(sender.value))
        case 1:
            sender.maximumValue = Double(Int(gameFieldHeight.text!)!)
            personYCoordinate.text = String(Int(sender.value))
        default: break
        }
    }
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let fieldColumns = Int(gameFieldWidth.text!)
        let fieldRows = Int(gameFieldHeight.text!)
        let holeX = Int(holeXCoordinate.text!)
        let holeY = Int(holeYCoordinate.text!)
        let boxX = Int(boxXCoordinate.text!)
        let boxY = Int(boxYCoordinate.text!)
        let personX = Int(personXCoordinate.text!)
        let personY = Int(personYCoordinate.text!)
        
        
        if(boxX == holeX && boxY == holeY){
            showWarningAlert(caseNumber:0)
        } else if(boxX == personX && boxY == personY){
            showWarningAlert(caseNumber:1)
        } else if(holeX == personX && holeY == personY){
            showWarningAlert(caseNumber:2)
        }  else {
        
        
            if let controller = segue.destination as? GameViewController {
                controller.columnsNumber = fieldColumns
                controller.rowsNumber = fieldRows
                controller.holeX = holeX
                controller.holeY = holeY
                controller.boxX = boxX
                controller.boxY = boxY
                controller.personX = personX
                controller.personY = personY
                
                controller.modalTransitionStyle = .flipHorizontal
//                controller.modalPresentationStyle = .fullScreen
            }
        }
        }
    
    func showWarningAlert(caseNumber: Int) {
        var alert = UIAlertController()
        
        switch(caseNumber){
        case 0:
            alert = UIAlertController(title: "Move Box Game", message: "Координаты коробки совпадают с координатами места сброса. Измените координаты.", preferredStyle: .alert)
        case 1:
            alert = UIAlertController(title: "Move Box Game", message: "Координаты коробки совпадают с координатами персонажа. Измените координаты.", preferredStyle: .alert)
        case 2:
            alert = UIAlertController(title: "Move Box Game", message: "Координаты точки сброса совпадают с координатами персонажа. Измените координаты.", preferredStyle: .alert)

        default: break
        }
        
        alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: nil))
        self.present(alert, animated: true, completion: nil)

    }
    
}
