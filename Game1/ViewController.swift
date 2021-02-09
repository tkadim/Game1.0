//
//  ViewController.swift
//  Game1
//
//  Created by Track Ensure on 2021-01-08.
//

import UIKit

class ViewController: UIViewController {
    
    let idCell = "Settings"
//    @IBOutlet weak var settingsTable: UITableView!
    
    @IBOutlet weak var gameFieldRows: UITextField!
    @IBOutlet weak var gameFieldColumns: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
//        settingsTable.dataSource = self
//        settingsTable.delegate = self
    }

    
//    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
//        if let controller = segue.destination as? GameViewController {
//            controller.columnsNumber = gameFieldColumns.text
//            controller.rowsNumber = gameFieldRows.text
//            controller.modalTransitionStyle = .flipHorizontal
////            controller.modalPresentationStyle = .fullScreen
//        }
//    }
//
//    override func shouldPerformSegue(withIdentifier identifier: String, sender: Any?) -> Bool {
//        if identifier == "goToGameVC" {
//            if (gameFieldColumns.text!.isEmpty || gameFieldRows.text!.isEmpty) || (Int(gameFieldColumns.text!) == nil) || (Int(gameFieldRows.text!) == nil){
//                return false
//            }
//        }
//        return true
//    }
}

//extension ViewController: UITableViewDataSource, UITableViewDelegate{
//
//    func numberOfSections(in tableView: UITableView) -> Int {
//        return 4
//    }
//
//    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
//        switch(section){
//        case 0:
//            return "Field Size"
//        case 1:
//            return "Hole Coordinates"
//        case 2:
//            return "Box Coordinates"
//        case 3:
//            return "Person Coordinates"
//        default: return ""
//        }
//    }
//
//    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        return 1
//    }
//
//    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//        let cell = UITableViewCell(style: .default, reuseIdentifier: idCell)
//
//        cell.textLabel?.text = "Field Size:"
//
//
//
//
//        return cell
//    }
//}

