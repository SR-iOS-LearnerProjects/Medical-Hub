//
//  RegisterViewController.swift
//  MedicalHub
//
//  Created by Sridatta Nallamilli on 07/01/20.
//  Copyright © 2020 Sridatta Nallamilli. All rights reserved.
//

import UIKit
import DScrollView

class RegisterViewController: UIViewController {

    // MARK:- Outlets
    @IBOutlet weak var nameTF               : UITextField!
    @IBOutlet weak var emailTF              : UITextField!
    @IBOutlet weak var passwordTF           : UITextField!
    @IBOutlet weak var conformPwdTF         : UITextField!
    @IBOutlet weak var phnCodeTF            : UITextField!
    @IBOutlet weak var phnNoTF              : UITextField!
    
    @IBOutlet weak var flagImg              : UIImageView!
    @IBOutlet weak var passwordLine         : UIImageView!
    @IBOutlet weak var conformPwdLine       : UIImageView!
    @IBOutlet weak var passwordLblImg       : UIImageView!
    @IBOutlet weak var conformPwdLblImg     : UIImageView!
    
    @IBOutlet weak var passwordLbl          : UILabel!
    @IBOutlet weak var conformPwdLbl        : UILabel!
    
    @IBOutlet var eyeBtn1                   : UIButton!
    @IBOutlet var eyeBtn2                   : UIButton!
    @IBOutlet var phnNoCodeBtn              : UIButton!
    @IBOutlet var termsCheckBoxBtn          : UIButton!
    @IBOutlet var createAccountBtn          : UIButton!
    @IBOutlet var english                   : UIButton!
    @IBOutlet var arabic                    : UIButton!
    
    @IBOutlet var bodyView                  : UIView!
    @IBOutlet var bodyContentView           : UIView!
    
    
    // MARK:- Variables
    var regType                                 : String?
    var socialData                              : JSON?
    var accountObj: Account                     = Account()
    var phoneCodeIDStr                          = ""
    let countryArr                              = NSArray()
    
    let scrollView = DScrollView()
    let scrollViewContainer = DScrollViewContainer(axis: .vertical, spacing: 0)
    let scrollViewElement = DScrollViewElement(height: 600, backgroundColor: UIColor.clear)
    
    
    // MARK:- Life Cycle Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        
//        let tapGesture = UITapGestureRecognizer()
//        tapGesture.addTarget(self, action: #selector(closeForgotView))
//        tapGesture.numberOfTapsRequired = 1
//        popOverView.addGestureRecognizer(tapGesture)
        
        eyeBtn1.setImage(UIImage.init(named: "viewoff"), for: UIControl.State.normal)
        eyeBtn2.setImage(UIImage.init(named: "viewoff"), for: UIControl.State.normal)
        termsCheckBoxBtn.setImage(UIImage.init(named: "inquirycheckbox"), for: UIControl.State.normal)
        
        passwordTF.isSecureTextEntry = true
        conformPwdTF.isSecureTextEntry = true
        
        createAccountBtn.isEnabled = false
        
        bodyView.addSubview(scrollView)
        
        bodyView.addScrollView(scrollView, withSafeArea: .vertical, hasStatusBarCover: true, statusBarBackgroundColor: UIColor.clear, container: scrollViewContainer, elements: scrollViewElement)
        
        scrollViewElement.addSubview(bodyContentView)
        
    }
  
    override func viewWillAppear(_ animated: Bool) {
        changeRegistrationUI()
//        setLanguage()
    }
    
    func changeRegistrationUI() {
        if regType == "social" {
            passwordLbl.isHidden = true
            conformPwdLbl.isHidden = true
            passwordLine.isHidden = true
            conformPwdLine.isHidden = true
            passwordLblImg.isHidden = true
            conformPwdLblImg.isHidden = true
            passwordTF.isHidden = true
            conformPwdTF.isHidden = true
            eyeBtn1.isHidden = true
            eyeBtn2.isHidden = true
//            lineImgTopconstraint.constant = -98
            if socialData!["email"].stringValue.isEmpty {
                emailTF.isUserInteractionEnabled = false
            }
            else {
                emailTF.isUserInteractionEnabled = true
            }
            nameTF.text = socialData?["first_name"].stringValue
            emailTF.text = socialData?["email"].stringValue
        }
        else {
            passwordLbl.isHidden = false
            conformPwdLbl.isHidden = false
            passwordLine.isHidden = false
            conformPwdLine.isHidden = false
            passwordLblImg.isHidden = false
            conformPwdLblImg.isHidden = false
            passwordTF.isHidden = false
            conformPwdTF.isHidden = false
            eyeBtn1.isHidden = false
            eyeBtn2.isHidden = false
//            lineImgTopconstraint.constant = 12
        }
    }
    
//    func setLanguage() {
//        loginBtn.setTitle("Login".localized(), for: UIControl.State.normal)
//        termsBtn.setTitle("Terms and Conditions Apply".localized(), for: UIControl.State.normal)
//        createAccountBtn.setTitle("Create Account".localized(), for: UIControl.State.normal)
//        selectLanguageLbl.text = "Select language".localized()
//        englishLbl.text = "English".localized()
//        arabicLbl.text = "Arabic".localized()
//        registerLbl.text = "Register".localized()
//        PlaceHolder.holdString(textField: nameTxt, placingString: "Name", color: .darkGray)
//        PlaceHolder.holdString(textField: emailTxt, placingString: "Email", color: .darkGray)
//        PlaceHolder.holdString(textField: passwordTxt, placingString: "Password", color: .darkGray)
//        PlaceHolder.holdString(textField: confirmPasswordTxt, placingString: "Confirm Password", color: .darkGray)
//        PlaceHolder.holdString(textField: phoneNumberTxt, placingString: "Phone Number", color: .darkGray)
//        PlaceHolder.holdString(textField: phoneCodeTxt, placingString: "Code", color: .darkGray)
//    }
    
   
    
    // MARK:- Button Actions
    
    @IBAction func loginBtnClick(_ sender: UIButton) {
         let vc = self.storyboard?.instantiateViewController(identifier: "LoginVC") as! LoginViewController
         self.navigationController?.pushViewController(vc, animated: true)
    }
    
    @IBAction func englishLang (_ sender: UIButton) {
        print("Language is changed to English")
        changeLanguage(value: "1")
    }
    
    @IBAction func arabicLang (_ sender: UIButton) {
        print("Language is changed to Arabic")
        changeLanguage(value: "2")
    }
    
    @IBAction func eyeBtn1Toggle(_ sender: UIButton) {
        if eyeBtn1.imageView?.image == UIImage.init(named: "viewoff") {
            eyeBtn1.setImage(UIImage.init(named: "viewon"), for: UIControl.State.normal)
            passwordTF.isSecureTextEntry = false
        }
        else {
            eyeBtn1.setImage(UIImage.init(named: "viewoff"), for: UIControl.State.normal)
            passwordTF.isSecureTextEntry = true
        }
    }
    
    @IBAction func eyeBtn2Toggle(_ sender: UIButton) {
        if eyeBtn2.imageView?.image == UIImage.init(named: "viewoff") {
            eyeBtn2.setImage(UIImage.init(named: "viewon"), for: UIControl.State.normal)
            conformPwdTF.isSecureTextEntry = false
        }
        else {
            eyeBtn2.setImage(UIImage.init(named: "viewoff"), for: UIControl.State.normal)
            conformPwdTF.isSecureTextEntry = true
        }
    }
 
    @IBAction func phnNoAction (_ sender: UIButton) {
//         popOverView.isHidden = false
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
            self.flagImg.image = countryDic["countryImage"] as? UIImage //UIImage(named: "\(countryDic["countryImage"] as! String)")
            self.phoneCodeIDStr = "\(String(describing: countryDic["id"]))"
        }

    }
    
    @IBAction func termsCheckedAction (_ sender: UIButton) {
        if termsCheckBoxBtn.imageView?.image == UIImage.init(named: "inquirycheckbox") {
            termsCheckBoxBtn.setImage(UIImage.init(named: "inquirycheck"), for: UIControl.State.normal)
            createAccountBtn.isEnabled = true
        }
        else {
            termsCheckBoxBtn.setImage(UIImage.init(named: "inquirycheckbox"), for: UIControl.State.normal)
            createAccountBtn.isEnabled = false
        }
    }
    
    @IBAction func createAccountAction (_ sender: UIButton) {
        if nameTF.text!.isEmpty {
            toastMessage(controller: self, message: "Please enter name")
        }
        else if emailTF.text!.isEmpty {
            toastMessage(controller: self, message: "Please enter email")
        }
        else if !isValidEmail(emailTF.text!) {
            toastMessage(controller: self, message: "Please enter valid email")
        }
        else {
            if regType == "social" {
                if phnCodeTF.text!.isEmpty {
                    toastMessage(controller: self, message: "Please enter phone code")
                }
                else if phnNoTF.text!.isEmpty {
                    toastMessage(controller: self, message: "Please enter phone number")
                }
                else if phnNoTF.text!.count > 15 || phnNoTF.text!.count < 5{
                    toastMessage(controller: self, message: "Phone number should be between 5 to 15 digits")
                }
                else if termsCheckBoxBtn.imageView?.image == UIImage.init(named: "inquirycheckbox") {
                    toastMessage(controller: self, message: "Please select terms and conditions")
                }
                else {
                    if socialData != nil {
                        socialRegistraion()
                    }
                }
            }
            else { // Email registration
                emailRegistraion()
            }
        }
    }
    
    func socialRegistraion() {
        let params = [emailTF.text!, nameTF.text!, socialData?["socialType"].stringValue, socialData?["id"].stringValue, phnNoTF.text!, phnCodeTF.text!, phoneCodeIDStr, socialData?["user_id"].stringValue, socialData?["socialProfilePic"].stringValue] as! [String]
        startLoad()
        accountObj.socialProfileSetupApiCall(paramValues: params, success: { (response) in
            stopLoad()
            if self.socialData!["email"].stringValue.isEmpty {
                self.apiResponse(response: response)
            }
            else {
                let userdetails = response.rawString();
                print("social login User Details: ",userdetails as Any)
                saveDefaults(value: true, Key: isSignInkey);
                saveDefaults(value: userdetails, Key: userDetailkey);
                saveDefaults(value: response["user_details"]["user_id"].stringValue, Key: appUserIDKey);
                saveDefaults(value: response["user_details"]["api_key"].stringValue, Key: loginAuthKey);
                if response["profile_setup"].stringValue == "0" {
//                    let storyboard = UIStoryboard(name: "Main", bundle: nil)
//                    let vc = storyboard.instantiateViewController(withIdentifier: "MyProfileVC") as! MyProfileVC
//                    vc.addOrEdit = false
//                    let rvc:SWRevealViewController = self.revealViewController() as SWRevealViewController
//                    rvc.pushFrontViewController(vc, animated: true)
                    
                    self.performSegue(withIdentifier: "reveal", sender: nil)
                    
//                    let rvc = self.storyboard?.instantiateViewController(identifier: "LoginToRVC") as! SWRevealViewController
//                     self.navigationController?.pushViewController(rvc, animated: true)

                    let alert = UIAlertController(title: "Profile Setup", message: "Please complete your profile details setup in My Profile menu.", preferredStyle: UIAlertController.Style.alert)

                    alert.addAction(UIAlertAction(title: "Dismiss", style: UIAlertAction.Style.destructive, handler: { _ in
                        //Cancel Action
                    }))

                    self.present(alert, animated: true, completion: nil)
                }
                else {
                    self.performSegue(withIdentifier: "reveal", sender: nil)
                }
            }
        }, failure: { (error) in
            stopLoad()
        })
    }
    
    func emailRegistraion() {
        if passwordTF.text!.isEmpty {
            toastMessage(controller: self, message: "Please enter password")
        }
        else if passwordTF.text!.count < 6 || passwordTF.text!.count > 20{
            toastMessage(controller: self, message: "Enter characters between 6-20")
        }
        else if conformPwdTF.text!.isEmpty {
            toastMessage(controller: self, message: "Please enter confirm password")
        }
        else if passwordTF.text != conformPwdTF.text {
            toastMessage(controller: self, message: "Please check Passwords doesn't match")
        }
        else if phnCodeTF.text!.isEmpty {
            toastMessage(controller: self, message: "Please enter phone code")
        }
        else if phnNoTF.text!.isEmpty {
            toastMessage(controller: self, message: "Please enter phone number")
        }
        else if phnNoTF.text!.count > 15 || passwordTF.text!.count < 5{
            toastMessage(controller: self, message: "Phone number should be between 5 to 15 digits")
        }
        else if termsCheckBoxBtn.imageView?.image == UIImage.init(named: "tickOff") {
            toastMessage(controller: self, message: "Please select terms and conditions")
        }
        else {
            accountObj.email = emailTF.text!
            accountObj.password = passwordTF.text!
            accountObj.userName = nameTF.text!
            accountObj.contactNumber = phnNoTF.text!
            accountObj.phoneCode = phnCodeTF.text!
            accountObj.phoneCodeID = phoneCodeIDStr
            startLoad()
            accountObj.signUpApiCall(accountParams: accountObj, success: { (response) in
                stopLoad()
                self.apiResponse(response: response)
            }) { error in
                stopLoad()
            }
        }
    }
    
    func apiResponse(response: JSON) {
        if response["status"].stringValue == apiSuccesskey {
            let userdetails = response.rawString();
            print("registration User Details: ",userdetails as Any)
            //saveDefaults(value: true, Key: isSignInkey);
            saveDefaults(value: userdetails, Key: userDetailkey);
            let login = self.storyboard?.instantiateViewController(withIdentifier: "LoginVC") as! LoginViewController
            self.navigationController?.pushViewController(login, animated: true)
            AlertMessage.ShowApiAlert(title: "", message: response["message"].stringValue, in: self, completion: nil)
        }
    }
    
    

}
