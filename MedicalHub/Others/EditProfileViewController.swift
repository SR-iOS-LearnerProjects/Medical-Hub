//
//  EditProfileViewController.swift
//  MedicalHub
//
//  Created by Sridatta Nallamilli on 08/01/20.
//  Copyright © 2020 Sridatta Nallamilli. All rights reserved.
//

import UIKit

class EditProfileViewController: UIViewController {

    @IBOutlet var menuButton: UIButton!
    
    var currentTF = UITextField()
    var pickerView = UIPickerView()
    
    @IBOutlet weak var profileImg: UIImageView!
    var imagePicker = UIImagePickerController()
    
    @IBOutlet var mrmsBtn: UIButton!
    @IBOutlet var phnNoBtn: UIButton!
    
    @IBOutlet weak var nameTF: UITextField!
    @IBOutlet weak var passwordTF: UITextField!
    @IBOutlet weak var maritalStatusTF: UITextField!
    @IBOutlet weak var phnNoTF: UITextField!
    @IBOutlet weak var dobTF: UITextField!
    @IBOutlet weak var genderTF: UITextField!
    @IBOutlet weak var nationalityTF: UITextField!
    @IBOutlet weak var countryTF: UITextField!
    
    @IBOutlet weak var remarksTV: UITextView!
    
    @IBOutlet var tfViews: [UIView]!
    
    @IBOutlet var submitBtn: UIButton!
    
    var phnNoBtnTitle = ""
    
    @IBOutlet var popOverView: UIView!
    
    var textFieldViews = UIView()
    
    @IBOutlet var nameView: UIView!
    @IBOutlet weak var maritalStatusView: UIView!
    @IBOutlet weak var dobView: UIView!
    @IBOutlet weak var nationalityView: UIView!
    @IBOutlet weak var passwordView: UIView!
    @IBOutlet weak var phnNoView: UIView!
    @IBOutlet weak var genderView: UIView!
    @IBOutlet weak var countryView: UIView!
    @IBOutlet weak var remarksView: UIView!
    
    
    var Arr = ["Mr.","Ms."]
    var maritalStatusArr = ["Single","Married"]
    var genderArr = ["Male","Female","Other"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        dobTF.delegate = self
        
        imagePicker.delegate = self
        self.profileImg.layer.cornerRadius = self.profileImg.frame.height / 2.0
        
        passwordTF.isSecureTextEntry = true
        
        saveChanges()
        
        phnNoBtn.setTitle(phnNoBtnTitle, for: .normal)
        
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
    
    // User Defaults
    func saveChanges() {
//        let savedProfileImg = UserDefaults.standard.object(forKey: "profileImg")
        let savedName = UserDefaults.standard.object(forKey: "name")
        let savedMrms = UserDefaults.standard.object(forKey: "mrms")
        let savedPass = UserDefaults.standard.object(forKey: "pwd")
        let savedMarriage = UserDefaults.standard.object(forKey: "marriage")
        let savedPhn = UserDefaults.standard.object(forKey: "phn")
        let savedDob = UserDefaults.standard.object(forKey: "dob")
        let savedGender = UserDefaults.standard.object(forKey: "gender")
        let savedNationality = UserDefaults.standard.object(forKey: "nationality")
        let savedCountry = UserDefaults.standard.object(forKey: "country")
        let savedRemarks = UserDefaults.standard.object(forKey: "remarks")
        
//        if let profileImgInput = savedProfileImg as? UIImage {
//            profileImg.image = profileImgInput
//        }
        if let nameInput = savedName as? String {
            nameTF.text = nameInput
        }
        if let mrmsInput = savedMrms as? String {
            mrmsBtn.setTitle(mrmsInput, for: .normal)
        }
        if let passInput = savedPass as? String {
            passwordTF.text = passInput
        }
        if let marriageInput = savedMarriage as? String {
            maritalStatusTF.text = marriageInput
        }
        if let phnInput = savedPhn as? String {
            phnNoTF.text = phnInput
        }
        if let dobInput = savedDob as? String {
            dobTF.text = dobInput
        }
        if let genderInput = savedGender as? String {
            genderTF.text = genderInput
        }
        if let nationalityInput = savedNationality as? String {
            nationalityTF.text = nationalityInput
        }
        if let countryInput = savedCountry as? String {
            countryTF.text = countryInput
        }
        if let remarksInput = savedRemarks as? String {
            remarksTV.text = remarksInput
        }
    }
    
    
    // Button Actions
    @IBAction func menuBtnClick(_ sender: UIButton) {
        let reveal: SWRevealViewController = revealViewController()
        reveal.tapGestureRecognizer()
         menuButton.addTarget(revealViewController(), action: #selector(SWRevealViewController.revealToggle(_:)), for: UIControl.Event.touchUpInside)
    }
    
    @IBAction func editImg(_ sender: UIButton) {
        imagePicker.sourceType = .camera
        imagePicker.allowsEditing = true
        present(imagePicker, animated: true, completion: nil)
    }
    
    @IBAction func mrmsBtnClick(_ sender: UIButton) {
        let popController = PopoverController(items: setupPopItem(), fromView: mrmsBtn, direction: .down, reverseHorizontalCoordinates: true, style: PopoverStyle.normal, initialIndex: 1) {
           print("Yeah Done !!")
       }
       popover(popController)
    }
    
    // PopOver View
    private func setupPopItem() -> [PopoverItem]{
        let mr = PopoverItem(title: "Mr.", titleColor: .clear) {
            debugPrint($0.title) // code here for click event
            self.mrmsBtn.setTitle("Mr.", for: .normal)
        }
        let ms = PopoverItem(title: "Ms.", titleColor: .clear){
            debugPrint($0.title) // code here for click event
            self.mrmsBtn.setTitle("Ms.", for: .normal)
        }
        return [ms, mr]
    }

    @IBAction func phnNoBtnClick(_ sender: UIButton) {
        let popVC = self.storyboard?.instantiateViewController(withIdentifier: "CodesPopOver") as! CodesPopOverViewController
        self.navigationController?.pushViewController(popVC, animated: true)

    }
    
    @IBAction func submitBtnClick(_ sender: UIButton) {
        
//        UserDefaults.standard.set(profileImg.image, forKey: "profileImg")
        UserDefaults.standard.set(nameTF.text, forKey: "name")
        UserDefaults.standard.set(mrmsBtn.title(for: .normal), forKey: "mrms")
        UserDefaults.standard.set(passwordTF.text, forKey: "pwd")
        UserDefaults.standard.set(maritalStatusTF.text, forKey: "marriage")
        UserDefaults.standard.set(phnNoTF.text, forKey: "phn")
        UserDefaults.standard.set(dobTF.text, forKey: "dob")
        UserDefaults.standard.set(genderTF.text, forKey: "gender")
        UserDefaults.standard.set(nationalityTF.text, forKey: "nationality")
        UserDefaults.standard.set(countryTF.text, forKey: "country")
        UserDefaults.standard.set(remarksTV.text, forKey: "remarks")
        
//        self.view.isUserInteractionEnabled = false
        self.view.addSubview(popOverView)
        
        popOverView.layer.cornerRadius = 10
        popOverView.layer.shadowColor = #colorLiteral(red: 0.2588235438, green: 0.7568627596, blue: 0.9686274529, alpha: 1)
        popOverView.layer.shadowRadius = 2
        popOverView.layer.shadowOpacity = 1
        popOverView.layer.shadowOffset = CGSize(width: 0, height: 0)
        popOverView.center = self.view.center
    }
    
    @IBAction func dismissBtnClick(_ sender: UIButton) {
        self.popOverView.removeFromSuperview()
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "MyProfile") as! MyProfileViewController
        UserDefaults.standard.set(nameTF.text, forKey: "name")
        self.revealViewController()?.pushFrontViewController(vc, animated: true)
    }
    
}

// MARK: - Extensions

extension EditProfileViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if let image = info[UIImagePickerController.InfoKey.editedImage] as? UIImage {
            profileImg.image = image
        }
        dismiss(animated: true, completion: nil)
        
    }
}

extension EditProfileViewController: UITextFieldDelegate {
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

extension EditProfileViewController: UIPickerViewDelegate, UIPickerViewDataSource {
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
