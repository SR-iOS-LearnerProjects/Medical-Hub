//
//  PatientMenuViewController.swift
//  MedicalHub
//
//  Created by Sridatta Nallamilli on 13/01/20.
//  Copyright © 2020 Sridatta Nallamilli. All rights reserved.
//

import UIKit

class PatientMenuViewController: UIViewController {

    @IBOutlet var patientTableView: UITableView!
    
    var patientRelationArr = ["Relation 1","Relation 2","Relation 3","Relation 4","Relation 5","Relation 6","Relation 7","Relation 8","Relation 9","Relation 10"]
    var patientNameArr = ["Name 1","Name 2","Name 3","Name 4","Name 5","Name 6","Name 7","Name 8","Name 9","Name 10"]
    var patientAgeArr = ["10","42","23","10","42","23","10","42","23","68"]
    var patientGenderArr = ["Male","Female","Male","Male","Female","Male","Male","Female","Male","Female"]
    
    @IBOutlet var menuButton: UIButton!
    @IBOutlet var addPatientBtn: UIButton!
    
    @IBOutlet weak var patientImg: UIImageView!
    
    @IBOutlet weak var patientName: UILabel!
    @IBOutlet weak var patientAge: UILabel!
    @IBOutlet weak var patientGender: UILabel!
    
    @IBOutlet weak var patientCount: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        let reveal: SWRevealViewController = revealViewController()
        reveal.tapGestureRecognizer()
         menuButton.addTarget(revealViewController(), action: #selector(SWRevealViewController.revealToggle(_:)), for: UIControl.Event.touchUpInside)
    
//        patientCount.text = patientRelationArr[MaxRowCount]
        
    }
    
    @IBAction func addPatientBtnClicked(_ sender: UIButton) {
        let vc = self.storyboard?.instantiateViewController(identifier: "AddPatientVC") as! AddPatientViewController
        self.navigationController?.pushViewController(vc, animated: true)
    }

}

extension PatientMenuViewController: UITableViewDelegate, UITableViewDataSource {
    
    // Row Height
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
    
    // Row Count
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return patientRelationArr.count
    }
    
    // Cell Data
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = patientTableView.dequeueReusableCell(withIdentifier: "cell") as! PatientMenuTableViewCell
        cell.relationName.text = patientRelationArr[indexPath.row]
        cell.name.text = patientNameArr[indexPath.row]
        cell.age.text = patientAgeArr[indexPath.row]
        cell.gender.text = patientGenderArr[indexPath.row]
        return cell
    }
    
    // Leading Swipe Actions
    func tableView(_ tableView: UITableView, leadingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let accept = UIContextualAction(style: .destructive, title: "Accept") { (action, view, nil) in
            print("Accept")
//            self.patientRelationArr.remove(at: indexPath.row)
//            self.patientTableView.deleteRows(at: [indexPath], with: .automatic)
        }
        accept.backgroundColor = #colorLiteral(red: 0.3411764801, green: 0.6235294342, blue: 0.1686274558, alpha: 1)
        
        return UISwipeActionsConfiguration(actions: [accept])
    }
    
    // Trailing Swipe Actions
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let edit = editAction(at: indexPath)
        let delete = deleteAction(at: indexPath)
        
        let config = UISwipeActionsConfiguration(actions: [delete, edit])
        config.performsFirstActionWithFullSwipe = false
        return config
    }
    
    func editAction(at indexPath: IndexPath) -> UIContextualAction {
        let action = UIContextualAction(style: .destructive, title: "") { (action, view, completion) in
            let vc = self.storyboard?.instantiateViewController(withIdentifier: "EditPatientVC") as! EditPatientViewController
            vc.name = self.patientNameArr[indexPath.row]
            vc.gender = self.patientGenderArr[indexPath.row]
            self.navigationController?.pushViewController(vc, animated: true)
            completion(true)
        }
        action.image = #imageLiteral(resourceName: "editwithback")
        action.backgroundColor = #colorLiteral(red: 0.3334169686, green: 0.1903461814, blue: 0.620075345, alpha: 1)
        return action
    }
    
    func deleteAction(at indexPath: IndexPath) -> UIContextualAction {
        let action = UIContextualAction(style: .destructive, title: "") { (action, view, completion) in
            self.patientRelationArr.remove(at: indexPath.row)
            self.patientTableView.deleteRows(at: [indexPath], with: .automatic)
            completion(true)
        }
        action.image = #imageLiteral(resourceName: "deletewithback")
        action.backgroundColor = #colorLiteral(red: 0.3334169686, green: 0.1903461814, blue: 0.620075345, alpha: 1)
        return action
    }
    
}
