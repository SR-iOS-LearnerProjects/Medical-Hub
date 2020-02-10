//
//  MyProfileViewController.swift
//  MedicalHub
//
//  Created by Sridatta Nallamilli on 08/01/20.
//  Copyright © 2020 Sridatta Nallamilli. All rights reserved.
//

import UIKit
import DScrollView
import Popover

class MyProfileViewController: UIViewController {

    // MARK: - Outlets
    
    @IBOutlet weak var menuButton: UIButton!
    @IBOutlet weak var editButton: UIButton!
    
    @IBOutlet weak var profileImg: UIImageView!

    @IBOutlet weak var nameTF: UITextField!
    @IBOutlet weak var passwordTF: UITextField!
    @IBOutlet weak var emailTF: UITextField!
    @IBOutlet weak var maritalStatusTF: UITextField!
    @IBOutlet weak var dobTF: UITextField!
    @IBOutlet weak var ageTF: UITextField!
    @IBOutlet weak var bloodGrpTF: UITextField!
    @IBOutlet weak var genderTF: UITextField!
    @IBOutlet weak var nationalityTF: UITextField!
    @IBOutlet weak var countryTF: UITextField!
    @IBOutlet weak var phnNoTF: UITextField!
    @IBOutlet weak var phnCodeTF: UITextField!
    @IBOutlet weak var remarksTV: UITextView!
    
    @IBOutlet weak var nameView: UIView!
    @IBOutlet weak var passwordView: UIView!
    @IBOutlet weak var emailView: UIView!
    @IBOutlet weak var maritalStatusView: UIView!
    @IBOutlet weak var dobView: UIView!
    @IBOutlet weak var ageView: UIView!
    @IBOutlet weak var bloodGrpView: UIView!
    @IBOutlet weak var genderView: UIView!
    @IBOutlet weak var nationalityView: UIView!
    @IBOutlet weak var countryView: UIView!
    @IBOutlet weak var phnNoView: UIView!
    @IBOutlet weak var remarksView: UIView!
    @IBOutlet weak var profileImgView: UIView!
    
    @IBOutlet weak var editImgBtn: UIButton!
    @IBOutlet weak var mrmsBtn: UIButton!
    @IBOutlet weak var maritalStatusBtn: UIButton!
    @IBOutlet weak var bloodGrpBtn: UIButton!
    @IBOutlet weak var genderBtn: UIButton!
    @IBOutlet weak var nationalityBtn: UIButton!
    @IBOutlet weak var countryBtn: UIButton!
    @IBOutlet weak var phnNoBtn: UIButton!
    @IBOutlet weak var submitBtn: UIButton!
    
    @IBOutlet weak var bodyView: UIView!
    @IBOutlet weak var bodyContentView: UIView!
    
    @IBOutlet weak var customDropdownView: UIView!
    
    @IBOutlet weak var countryFlagImg: UIImageView!
    @IBOutlet weak var nationalityFlagImg: UIImageView!
    @IBOutlet weak var phnNoFlagImg: UIImageView!
    @IBOutlet weak var phoneDropDownImg: UIImageView!
    
    @IBOutlet weak var customTableView: UITableView!
    
    // MARK:- Variables
    
    var currentTF = UITextField()
    var pickerView = UIPickerView()
    var imagePicker = UIImagePickerController()
    var textFieldViews = UIView()
    
    var respectWordArr = ["Mr.","Mrs."]
    var maritalStatusArr = ["Single","Married"]
    var bloodGrpArr = ["A+","A-","B+","B-","AB+","AB-","O+"]
    var genderArr = ["Male","Female","Other"]
    
    var popView                                         = Popover()
    var popArr:NSMutableArray                           = NSMutableArray()
    var popOverType                                     = "name"
    
    var ud                                              : UserDefaults?
    var addOrEdit                                       : Bool?
    var accountObj: Account                             = Account()
    var countryCodeStr                                  : String!
    var countryApiIDStr                                 : String!
    var countryLocaleImg                                : String!
    
    var nationCodeStr                                   : String!
    var nationApiIDStr                                  : String!
    var nationLocaleImg                                 : String!
    
    var phoneCodeStr                                    : String!
    var phoneApiIDStr                                   : String!
    var phoneLocaleImg                                  : String!
    var udObject: JSON                                  = JSON()
    var imgdata                                         = JSON();
    var imgTaken                                        = false
    
    var maritalApiValue                                 = ""
    var genderApiValue                                  = ""
    
    let scrollView = DScrollView()
    let scrollViewContainer = DScrollViewContainer(axis: .vertical, spacing: 0)
    let scrollViewElement = DScrollViewElement(height: 796, backgroundColor: UIColor.clear)
    
    
    // MARK:- Life Cycle Methods
    
    override func viewDidLoad() {
        super.viewDidLoad()

        let reveal: SWRevealViewController = revealViewController()
        reveal.tapGestureRecognizer()
         menuButton.addTarget(revealViewController(), action: #selector(SWRevealViewController.revealToggle(_:)), for: UIControl.Event.touchUpInside)
        
        ud = UserDefaults.standard
        
        // Image Styles
//        profileImg.layer.cornerRadius = profileImg.frame.height / 2.0
        profileImg.layer.shadowColor = #colorLiteral(red: 0.2588235438, green: 0.7568627596, blue: 0.9686274529, alpha: 1)
        profileImg.layer.shadowOpacity = 1
        profileImg.layer.shadowRadius = 150
        profileImg.layer.shadowOffset = CGSize(width: 10, height: 10)
        
        // Adding Scroll View
        bodyView.addSubview(scrollView)
        
        bodyView.addScrollView(scrollView, withSafeArea: .vertical, hasStatusBarCover: true, statusBarBackgroundColor: UIColor.clear, container: scrollViewContainer, elements: scrollViewElement)
        
        scrollViewElement.addSubview(bodyContentView)
        
        
        
        dobTF.delegate = self
        
        imagePicker.delegate = self
        imagePicker.allowsEditing = true
        
        if UIImagePickerController.isSourceTypeAvailable(.camera) {
            imagePicker.sourceType = .camera;
            imagePicker.cameraCaptureMode = .photo;
        }
        
        profileImg.layer.cornerRadius = profileImg.frame.height / 2.0
        profileImgView.layer.cornerRadius = profileImgView.frame.height / 2.0
        
        passwordTF.isSecureTextEntry = true
        
        addOrEdit = false
        submitBtn.isHidden = true
        
//        setCornerRadiuesBlue([profileImgView], profileImgView.frame.height / 2.0)
        
        setCornerRadiuesBlue([nameView, passwordView, emailView, maritalStatusView, dobView, ageView, bloodGrpView, genderView, nationalityView, countryView, phnNoView, remarksView], 4.0)
        
//        setBlueShadow([profileImgView])
        
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        ud?.set(1, forKey: "menuSelect")
        ud?.synchronize()
        
        if imgTaken == false {
            let userDStr = getUserDefaultsValue(for: userDetailkey)
            let userDetailsJson = JSON(userDStr)
            print(userDetailsJson)
            countryFlagImg.image = nil
            nationalityFlagImg.image = nil
            phnNoFlagImg.image = nil
//            self.setLanguage()
            self.editOrShowData()
            self.getUserProfileApi()
        }
        else {
            imgTaken = false
        }
    }
    
  
    func editOrShowData() {
        emailTF.isUserInteractionEnabled = false
        if addOrEdit == false { // show profile
            mrmsBtn.isUserInteractionEnabled = false
            maritalStatusBtn.isUserInteractionEnabled = false
            genderBtn .isUserInteractionEnabled = false
            countryBtn.isUserInteractionEnabled = false
//            dobBtn.isUserInteractionEnabled = false
//            bloodGrpBtn.isUserInteractionEnabled = false
            nationalityBtn.isUserInteractionEnabled = false
            phnNoBtn.isUserInteractionEnabled = false
            
            nameTF.isUserInteractionEnabled = false
            passwordTF.isUserInteractionEnabled = false
            maritalStatusTF.isUserInteractionEnabled = false
            dobTF.isUserInteractionEnabled = false
            ageTF.isUserInteractionEnabled = false
            bloodGrpTF.isUserInteractionEnabled = false
            genderTF.isUserInteractionEnabled = false
            nationalityTF.isUserInteractionEnabled = false
            countryTF.isUserInteractionEnabled = false
            phnNoTF.isUserInteractionEnabled = false
            phnCodeTF.isUserInteractionEnabled = false
            remarksTV.isUserInteractionEnabled = false
            phnNoTF.isUserInteractionEnabled = false
            editButton.isHidden = false
            editImgBtn.isHidden = true
            submitBtn.isHidden = true
            
            maritalStatusBtn.isHidden = true
            genderBtn.isHidden = true
            countryBtn.isHidden = true
//            dobBtn.isHidden = true
            bloodGrpBtn.isHidden = true
            nationalityBtn.isHidden = true
            phnNoBtn.isHidden = true
            phoneDropDownImg.isHidden = true
            mrmsBtn.setImage(UIImage(named: ""), for: UIControl.State.normal)
        }
        else { // edit profile
            mrmsBtn.isUserInteractionEnabled = true
            maritalStatusBtn.isUserInteractionEnabled = true
            genderBtn.isUserInteractionEnabled = true
            countryBtn.isUserInteractionEnabled = true
//            dobBtn.isUserInteractionEnabled = true
            bloodGrpBtn.isUserInteractionEnabled = true
            nationalityBtn.isUserInteractionEnabled = true
            phnNoBtn.isUserInteractionEnabled = true
            
            nameTF.isUserInteractionEnabled = true
            passwordTF.isUserInteractionEnabled = true
            maritalStatusTF.isUserInteractionEnabled = true
            dobTF.isUserInteractionEnabled = true
            ageTF.isUserInteractionEnabled = true
            bloodGrpTF.isUserInteractionEnabled = true
            genderTF.isUserInteractionEnabled = true
//            nationalityTF.isUserInteractionEnabled = true
//            countryTF.isUserInteractionEnabled = true
            phnNoTF.isUserInteractionEnabled = true
            remarksTV.isUserInteractionEnabled = true
            phnNoTF.isUserInteractionEnabled = true
            phnCodeTF.isUserInteractionEnabled = true
            editButton.isHidden = true
            editImgBtn.isHidden = false
            submitBtn.isHidden = false
            
            maritalStatusBtn.isHidden = false
            genderBtn.isHidden = false
            countryBtn.isHidden = false
//            dobBtn.isHidden = false
            bloodGrpBtn.isHidden = false
            nationalityBtn.isHidden = false
            phnNoBtn.isHidden = false
            phoneDropDownImg.isHidden = false
            mrmsBtn.setImage(UIImage(named: "dropdown"), for: UIControl.State.normal)
        }
    }

    
    // PopOver Function
    func popOverFunction(width:CGFloat,height:CGFloat,startPoint:CGPoint){
        print(height)
        customDropdownView.frame = CGRect.init(x: 0, y: 0, width: width, height: height)
        popView = Popover.init(showHandler: {
            self.customTableView.reloadData()
        }, dismissHandler: {
        })
        popView.show(customDropdownView, point: startPoint)
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
            
//            let now = NSDate()
//            if dobTF.text > now as Date{
//                toastMessage(controller: self, messge: "Invalid Date of birth")
//                return
//            }
        }
        print(datePicker.date)
    }
    
//    extension Date {
//       var age: Int {
//           return Calendar.current.dateComponents([.year], from: self, to: Date()).year!
//       }
//    }
    
    @IBAction func editImg(_ sender: UIButton) {
        
    }

    @IBAction func mrmsBtnClick(_ sender: UIButton) {
       self.popArr = NSMutableArray(array: self.respectWordArr)
       self.popOverType = "name"
        self.customTableView.reloadData()
       let startPointf = CGPoint(x: (sender as AnyObject).center.x, y: (sender as AnyObject).center.y + 20 )
       let startPoint = (sender as AnyObject).superview?.convert(startPointf, to: self.view)
       var sampleHeight = self.popArr.count * 28
       if sampleHeight > 200{
         sampleHeight = 200
       }else{
       }
       self.popOverFunction( width: mrmsBtn.frame.width, height: CGFloat(sampleHeight),startPoint: startPoint!)
    }

    @IBAction func maritalStatusBtnClick(_ sender: UIButton) {
       self.popArr = NSMutableArray(array: self.maritalStatusArr)
       self.popOverType = "maritalStatus"
        self.customTableView.reloadData()
       let startPointf = CGPoint(x: (sender as AnyObject).center.x, y: (sender as AnyObject).center.y + 20 )
       let startPoint = (sender as AnyObject).superview?.convert(startPointf, to: self.view)
       var sampleHeight = self.popArr.count * 28
       if sampleHeight > 200{
         sampleHeight = 200
       }else{
       }
       self.popOverFunction( width: maritalStatusBtn.frame.width, height: CGFloat(sampleHeight),startPoint: startPoint!)
    }

    @IBAction func bloodGrpBtnClick(_ sender: UIButton) {
       self.popArr = NSMutableArray(array: self.bloodGrpArr)
       self.popOverType = "bloodGroup"
        self.customTableView.reloadData()
       let startPointf = CGPoint(x: (sender as AnyObject).center.x, y: (sender as AnyObject).center.y + 20 )
       let startPoint = (sender as AnyObject).superview?.convert(startPointf, to: self.view)
       var sampleHeight = self.popArr.count * 28
       if sampleHeight > 200{
         sampleHeight = 200
       }else{
       }
       self.popOverFunction( width: bloodGrpBtn.frame.width, height: CGFloat(sampleHeight),startPoint: startPoint!)
    }

    @IBAction func genderBtnClick(_ sender: UIButton) {
       self.popArr = NSMutableArray(array: self.genderArr)
       self.popOverType = "gender"
        self.customTableView.reloadData()
       let startPointf = CGPoint(x: (sender as AnyObject).center.x, y: (sender as AnyObject).center.y + 20 )
       let startPoint = (sender as AnyObject).superview?.convert(startPointf, to: self.view)
       var sampleHeight = self.popArr.count * 28
       if sampleHeight > 200{
         sampleHeight = 200
       }else{
       }
       self.popOverFunction( width: genderBtn.frame.width, height: CGFloat(sampleHeight),startPoint: startPoint!)
    }
    
    @IBAction func nationalityBtnAction (_ sender: UIButton) {
       let countryView = CountrySelectView.shared
       countryView.barTintColor = .red
       if getUserDefaultsValue(for: languageKey) == "1" {
           countryView.displayLanguage = .english
           countryView.displayNationLanguage = .english
       }
       else {
           countryView.displayLanguage = .arabic
           countryView.displayNationLanguage = .arabic
       }
       countryView.displayNationNameCountryName = .NationName
       self.view.addSubview(countryView)
       countryView.show()
       countryView.selectedCountryCallBack = { (countryDic) -> Void in
           if getUserDefaultsValue(for: languageKey) == "1" {
               self.nationalityTF.text = "\(countryDic["nationality_english"] as! String)"
           }
           else {
               self.nationalityTF.text = "\(countryDic["nationality_arabic"] as! String)"
           }
           self.nationalityFlagImg.image = countryDic["countryImage"] as? UIImage
           self.nationApiIDStr = "\(countryDic["id"] as! String)"
       }
    }
    
    @IBAction func countryBtnAction (_ sender: UIButton) {
       let countryView = CountrySelectView.shared
       countryView.barTintColor = .red
       if getUserDefaultsValue(for: languageKey) == "1" {
           countryView.displayLanguage = .english
           countryView.displayNationLanguage = .english
       }
       else {
           countryView.displayLanguage = .arabic
           countryView.displayNationLanguage = .arabic
       }
       countryView.displayNationNameCountryName = .countyName
       self.view.addSubview(countryView)
       countryView.show()
       countryView.selectedCountryCallBack = { (countryDic) -> Void in
           if getUserDefaultsValue(for: languageKey) == "1" {
               self.countryTF.text = "\(countryDic["country_english"] as! String)"
           }
           else {
               self.countryTF.text = "\(countryDic["country_arabic"] as! String)"
           }
           self.countryFlagImg.image = countryDic["countryImage"] as? UIImage
           self.countryApiIDStr = "\(countryDic["id"] as! String)"
       }
    }
    
     @IBAction func phnNoBtnClick(_ sender: UIButton) {
        let countryView = CountrySelectView.shared
        countryView.barTintColor = .red
        if getUserDefaultsValue(for: languageKey) == "1" {
            countryView.displayLanguage = .english
            countryView.displayNationLanguage = .english
        }
        else {
            countryView.displayLanguage = .arabic
            countryView.displayNationLanguage = .arabic
        }
        countryView.displayNationNameCountryName = .countyName
        self.view.addSubview(countryView)
        countryView.show()
        countryView.selectedCountryCallBack = { (countryDic) -> Void in
            //self.phoneNumberTxt.text = "+\(countryDic["code"] as! NSNumber)"
            self.phnCodeTF.text = "+\(countryDic["code"] as! String)"
            self.phnNoFlagImg.image = countryDic["countryImage"] as? UIImage
            self.phoneApiIDStr = "\(countryDic["id"] as! String)"
        }
    //            let popVC = self.storyboard?.instantiateViewController(withIdentifier: "CodesPopOver") as! CodesPopOverViewController
    //            self.navigationController?.pushViewController(popVC, animated: true)

        }
    
    @IBAction func editImgAction (_ sender: UIButton) {
        self.view.endEditing(true);
        let actionSheet = UIAlertController.init(title: "", message: "Please choose a source type below", preferredStyle: .actionSheet);
        actionSheet.addAction(UIAlertAction.init(title: "Camera", style: .default, handler: { (_) in
            self.imagePicker.sourceType = .camera
            self.present(self.imagePicker, animated: true, completion: nil)
        }))
        actionSheet.addAction(UIAlertAction.init(title: "Gallery", style: .default, handler: { (_) in
            self.imagePicker.sourceType = .savedPhotosAlbum
            self.present(self.imagePicker, animated: true, completion: nil)
        }))
        actionSheet.addAction(UIAlertAction.init(title: "Cancel", style: .destructive, handler: nil));
        self.present(actionSheet, animated: true, completion: nil);
    }
    
    @IBAction func editButtonCliked(_ sender: UIButton) {
        addOrEdit = true
        self.editOrShowData()
    //            let vc = self.storyboard?.instantiateViewController(withIdentifier: "EditProfile") as! EditProfileViewController
    //            self.revealViewController()?.pushFrontViewController(vc, animated: true)
        }
    
    @IBAction func submitBtnClick(_ sender: UIButton) {
        if nameTF.text!.isEmpty {
            toastMessage(controller: self, message: "Please enter name")
        }
        else if passwordTF.text!.isEmpty {
            toastMessage(controller: self, message: "Please enter password")
        }
        else if passwordTF.text!.count < 6 || passwordTF.text!.count > 20 {
            toastMessage(controller: self, message: "Enter characters between 6-20")
        }
        else if emailTF.text!.isEmpty {
            toastMessage(controller: self, message: "Please enter email")
        }
        else if !isValidEmail(emailTF.text!) {
            toastMessage(controller: self, message: "Please enter valid email")
        }
        else if maritalStatusTF.text!.isEmpty {
            toastMessage(controller: self, message: "Please select marital status")
        }
        else if dobTF.text!.isEmpty {
            toastMessage(controller: self, message: "Please select date of birth")
        }
        else if ageTF.text!.isEmpty {
            toastMessage(controller: self, message: "Please select date of birth")
        }
        else if bloodGrpTF.text!.isEmpty {
            toastMessage(controller: self, message: "Please select blood group")
        }
        else if genderTF.text!.isEmpty {
            toastMessage(controller: self, message: "Please select gender")
        }
        else if nationalityTF.text!.isEmpty {
            toastMessage(controller: self, message: "Please select nation")
        }
        else if countryTF.text!.isEmpty {
            toastMessage(controller: self, message: "Please select country")
        }
        else if phnCodeTF.text!.isEmpty {
            toastMessage(controller: self, message: "Please enter phone code")
        }
        else if phnNoTF.text!.isEmpty {
            toastMessage(controller: self, message: "Please enter phone number")
        }
        else if phnNoTF.text!.count > 15 || phnNoTF.text!.count < 5{
            toastMessage(controller: self, message: "Phone number should be between 5 to 15 digits")
        }
        else if remarksTV.text!.isEmpty {
            toastMessage(controller: self, message: "Please enter remarks")
        }
        else {
            
            let accountParams: Account = Account()
            accountParams.userID = udObject["user_id"].stringValue
            accountParams.respectWord = mrmsBtn.titleLabel?.text
            accountParams.userName = nameTF.text
            accountParams.email = emailTF.text
            accountParams.password = passwordTF.text
            accountParams.gender = genderApiValue
            accountParams.dobStr = dobTF.text
            accountParams.bloodGroup = bloodGrpTF.text
            accountParams.age = ageTF.text
            accountParams.remarks = remarksTV.text
            accountParams.nationalityID = nationApiIDStr
            accountParams.countryID = countryApiIDStr
            accountParams.contactNumber = phnNoTF.text
            accountParams.phoneCode = phnCodeTF.text
            accountParams.phoneCodeID = phoneApiIDStr
            accountParams.maritialStatus = maritalApiValue
            var allimages = [JSON]();
            allimages.append(imgdata);
            accountParams.profile_pic = allimages
            print(accountParams)
            
            let params: [String: Any] = ["user_id": accountParams.userID!, "user_name": accountParams.userName!, "email": accountParams.email!, "password": accountParams.password!, "gender": accountParams.gender!, "dob": accountParams.dobStr!, "blood_group": accountParams.bloodGroup!, "remarks": accountParams.remarks!, "nationality": accountParams.nationalityID!, "country_id": accountParams.countryID!, "contact_number": accountParams.contactNumber!, "phone_code": accountParams.phoneCode!, "phone_code_id": accountParams.phoneCodeID!, "marital_status": accountParams.maritialStatus!, "respect_word": accountParams.respectWord!, "platform": platform, "device_id": getUserDefaultsValue(for: deviceTokenKey), "language": getUserDefaultsValue(for: languageKey)]
            print(params)
            startLoad()
            accountObj.profileSetUpApiCall(accountParams: accountParams, success: { (response) in
                stopLoad()
                self.addOrEdit = false
                let userdetails = response.rawString();
                saveDefaults(value: userdetails, Key: userDetailkey);
                self.getProfileApiResponse(response: response)
                self.editOrShowData()
            }) { (error) in
                stopLoad()
            }
        }
    }
    
    
    
}


// MARK: - Extensions

extension UIView {
    func dropShadow(color: UIColor, opacity: Float = 0.5, offSet: CGSize, radius: CGFloat = 1, scale: Bool = true) {
      layer.masksToBounds = false
      layer.shadowColor = color.cgColor
      layer.shadowOpacity = opacity
      layer.shadowOffset = offSet
      layer.shadowRadius = radius
    }
}

//extension MyProfileViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
//    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
//        if let image = info[UIImagePickerController.InfoKey.editedImage] as? UIImage {
//            profileImg.image = image
//        }
//        dismiss(animated: true, completion: nil)
//
//    }
//}

// MARK:- TextField Delegate

extension MyProfileViewController: UITextFieldDelegate {
    func textFieldDidBeginEditing(_ textField: UITextField) {
        self.openDatePicker()
        
        // Picker View Text Fields
        self.pickerView.delegate = self
        self.pickerView.dataSource = self
        
        currentTF = textField
        if currentTF == maritalStatusTF {
            maritalStatusTF.inputView = pickerView
        }
        else if currentTF == bloodGrpTF {
            bloodGrpTF.inputView = pickerView
        }
        else if currentTF == genderTF {
            genderTF.inputView = pickerView
        }
        
    }
}

// MARK:- Picker View

extension MyProfileViewController: UIPickerViewDelegate, UIPickerViewDataSource {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        
        if currentTF == maritalStatusTF {
            return maritalStatusArr.count
        }
        else if currentTF == bloodGrpTF {
            return bloodGrpArr.count
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
        else if currentTF == bloodGrpTF {
            return bloodGrpArr[row]
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
        else if currentTF == bloodGrpTF {
            bloodGrpTF.text = bloodGrpArr[row]
        }
        else if currentTF == genderTF {
            genderTF.text = genderArr[row]
        }
        
    }
    
    
}

// MARK: - Get User Profile API
extension MyProfileViewController {

    func getUserProfileApi() {
        
        startLoad()
        accountObj.getUserProfileApiCall(paramValues: [getUserDefaultsValue(for: appUserIDKey)], success: { (response) in
            stopLoad()
            print(response)
            let userdetails = response.rawString();
            saveDefaults(value: userdetails, Key: userDetailkey);
            self.getProfileApiResponse(response: response)
            
        }) { (error) in
            stopLoad()
        }
    }
    
    func getProfileApiResponse(response: JSON) {
        let path = Bundle(for: CountrySelectView.self).resourcePath! + "/CountryPicker.bundle"
        let CABundle = Bundle(path: path)!
        udObject = response["user_details"]
        mrmsBtn.setTitle(udObject["respect_word"].stringValue, for: UIControl.State.normal)
        var urlStr = udObject["profile_pic"].stringValue
        urlStr = urlStr.replacingOccurrences(of: " ", with: "%20")
        let imageURL = URL(string: urlStr)
        profileImg.sd_setImage(with: imageURL, completed: nil)
        
        nameTF.text = udObject["user_name"].stringValue
        passwordTF.text = udObject["password"].stringValue
        emailTF.text = udObject["email"].stringValue
        maritalStatusTF.text = udObject["marital_status"].stringValue
        if udObject["marital_status"].stringValue == "Single" {
            maritalApiValue = "1"
        }
        else {
            maritalApiValue = "2"
        }
        dobTF.text = udObject["dob"].stringValue
        ageTF.text = udObject["age"].stringValue
        bloodGrpTF.text = udObject["blood_group"].stringValue
        genderTF.text = udObject["gender"].stringValue
        if udObject["gender"].stringValue == "Male" {
            genderApiValue = "1"
        }
        else {
            genderApiValue = "2"
        }
        nationalityTF.text = udObject["user_name"].stringValue
        
        countryTF.text = udObject["country_details"]["country_name"].stringValue
        countryCodeStr = udObject["country_details"]["phone_code"].stringValue
        countryApiIDStr = udObject["country_details"]["country_id"].stringValue
        countryLocaleImg = udObject["country_details"]["locale"].stringValue
        countryFlagImg.image = UIImage(named: countryLocaleImg, in:  CABundle, compatibleWith: nil)

        nationalityTF.text = udObject["nationality_details"]["nationality_name"].stringValue
        nationCodeStr = udObject["nationality_details"]["phone_code"].stringValue
        nationApiIDStr = udObject["nationality_details"]["nationality_id"].stringValue
        nationLocaleImg = udObject["nationality_details"]["locale"].stringValue
        nationalityFlagImg.image = UIImage(named: nationLocaleImg, in:  CABundle, compatibleWith: nil)
        
        phnCodeTF.text = udObject["phone_code_details"]["phone_code"].stringValue
        phoneCodeStr = udObject["phone_code_details"]["phone_code"].stringValue
        phoneApiIDStr = udObject["phone_code_details"]["phone_code_id"].stringValue
        phoneLocaleImg = udObject["phone_code_details"]["locale"].stringValue
        phnNoFlagImg.image = UIImage(named: phoneLocaleImg, in:  CABundle, compatibleWith: nil)
        
        phnNoTF.text = udObject["contact_number"].stringValue
        remarksTV.text = udObject["remarks"].stringValue
    }
}

// MARK:Image picker delegates

extension MyProfileViewController : UIImagePickerControllerDelegate, UINavigationControllerDelegate
{
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        imgTaken = true
        picker.dismiss(animated: true, completion:  nil);
    }
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        imgTaken = true
        if let editimg = info[.editedImage] as? UIImage
        {
            if let editpicData = editimg.jpegData(compressionQuality: 1.0)
            {
                
                profileImg.image = editimg
                imgdata["imgdata"].stringValue  = editpicData.base64EncodedString();
                imgdata["picname"].stringValue = "profile_pic";
            }
        }
        picker.dismiss(animated: true, completion:  nil);
    }
}

// MARK:- Table View Delegates for PopOver

extension MyProfileViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
            return self.popArr.count
        }
        
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = customTableView.dequeueReusableCell(withIdentifier: "cell") as! customDropdownTableViewCell
        cell.customDropdownCellLabel.text = (self.popArr.object(at: indexPath.row) as! String)
        return cell
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 30
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if self.popOverType == "name"{
            self.mrmsBtn.setTitle(self.popArr.object(at: indexPath.row) as? String, for: UIControl.State.normal)
            //self.nameTxt.text = (self.popArr.object(at: indexPath.row) as! String)
        }
        else if self.popOverType == "maritalStatus"{
            self.maritalStatusTF.text = self.popArr.object(at: indexPath.row) as? String
//            if self.maritalStatusTF.text == "Single" {
//                maritalApiValue = "1"
//            }
//            else {
//                maritalApiValue = "2"
//            }
        }else if self.popOverType == "gender"{
            self.genderTF.text = self.popArr.object(at: indexPath.row) as? String
//            if self.genderTxt.text == "Male" {
//                genderApiValue = "1"
//            }
//            else {
//                genderApiValue = "2"
//            }
        }
        else if self.popOverType == "bloodGroup"{
            self.bloodGrpTF.text = self.popArr.object(at: indexPath.row) as? String
        }
        
        popView.dismiss()
    }
}
