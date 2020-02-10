//
//  EditPatientViewController.swift
//  MedicalHub
//
//  Created by Sridatta Nallamilli on 20/01/20.
//  Copyright © 2020 Sridatta Nallamilli. All rights reserved.
//

import UIKit

class EditPatientViewController: UIViewController {

    var currentTF = UITextField()
    var pickerView = UIPickerView()
    
    @IBOutlet weak var nameTF: UITextField!
    @IBOutlet weak var passwordTF: UITextField!
    @IBOutlet weak var maritalStatusTF: UITextField!
    @IBOutlet weak var phnNoTF: UITextField!
    @IBOutlet weak var dobTF: UITextField!
    @IBOutlet weak var genderTF: UITextField!
    @IBOutlet weak var nationalityTF: UITextField!
    @IBOutlet weak var countryTF: UITextField!
    
    @IBOutlet var phnNoBtn: UIButton!
    @IBOutlet var submitBtn: UIButton!
    
    var Arr = ["Mr.","Ms."]
    var maritalStatusArr = ["Single","Married"]
    var genderArr = ["Male","Female","Other"]
    
    var name = ""
    var password = ""
    var maritalStatus = ""
    var phnNo = ""
    var dob = ""
    var gender = ""
    var nationality = ""
    var country = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()

        dobTF.delegate = self
        
        nameTF.text = name
        passwordTF.text = password
        maritalStatusTF.text = maritalStatus
        phnNoTF.text = phnNo
        dobTF.text = dob
        genderTF.text = gender
        nationalityTF.text = nationality
        countryTF.text = country
        
    }
    
    // Date Picker Function
    func openDatePicker() {
        let datePicker = UIDatePicker()
        datePicker.datePickerMode = .date
        datePicker.addTarget(self, action: #selector(datePickerValueChangedHandler(datePicker:)), for: .valueChanged)
        dobTF.inputView = datePicker
    }
    
    @objc func datePickerValueChangedHandler(datePicker: UIDatePicker) {
        if let datePicker = dobTF.inputView as? UIDatePicker {
            
            let dateFormat = DateFormatter()
            dateFormat.dateStyle = .medium
            dobTF.text = dateFormat.string(from: datePicker.date)
        
            print(datePicker.date)
        }
        print(datePicker.date)
    }
    
    @IBAction func backBtnClicked(_ sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
    }

}

// MARK: - Extensions

extension EditPatientViewController: UITextFieldDelegate {
    func textFieldDidBeginEditing(_ textField: UITextField) {
        self.openDatePicker()
        
        // Picker View Text Fields
        self.pickerView.delegate = self
        self.pickerView.dataSource = self
        
        currentTF = textField
        if currentTF == maritalStatusTF {
            maritalStatusTF.inputView = pickerView
        }
        else if currentTF == genderTF {
            genderTF.inputView = pickerView
        }
        
    }
}

extension EditPatientViewController: UIPickerViewDelegate, UIPickerViewDataSource {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        
        if currentTF == maritalStatusTF {
            return maritalStatusArr.count
        }
        else if currentTF == genderTF {
            return genderArr.count
        }
        else {
            return 0
        }
        
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        
        if currentTF == maritalStatusTF {
            return maritalStatusArr[row]
        }
        else if currentTF == genderTF {
            return genderArr[row]
        }
        else {
            return ""
        }
        
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
//        districtsTextfield.text = districtsArr[row]
        
        if currentTF == maritalStatusTF {
            maritalStatusTF.text = maritalStatusArr[row]
        }
        else if currentTF == genderTF {
            genderTF.text = genderArr[row]
        }
        
    }
    
    
}
