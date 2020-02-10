//
//  LoginViewController.swift
//  MedicalHub
//
//  Created by Sridatta Nallamilli on 07/01/20.
//  Copyright © 2020 Sridatta Nallamilli. All rights reserved.
//

import UIKit
import Toast_Swift
import SVProgressHUD
import NVActivityIndicatorView

class LoginViewController: UIViewController {

    //MARK:- Outlets
    @IBOutlet weak var emailTF: UITextField!
    @IBOutlet weak var mailTF: UITextField!
    @IBOutlet weak var passwordTF: UITextField!
    @IBOutlet weak var eyeBtn: UIButton!
    @IBOutlet weak var forgotBtn: UIButton!
    @IBOutlet weak var loginBtn: UIButton!
    @IBOutlet weak var signUpBtn: UIButton!
    
    @IBOutlet weak var mainView                         : UIView!
    @IBOutlet weak var forgotView                   : UIView!
    @IBOutlet weak var forgotRoundView              : UIView!
    @IBOutlet weak var forgotSubmitBtn              : UIButton!
    @IBOutlet weak var forgotEmailTxt               : UITextField!
    @IBOutlet weak var forgotBgImg: UIImageView!
    
    // MARK: - Variables
    let accountObj: Account                         = Account()

    
    // MARK: - Life cycle methods
    override func viewDidLoad() {
        super.viewDidLoad()

        emailTF.text = ""
        passwordTF.text = ""
        
        eyeBtn.setImage(UIImage.init(named: "viewoff"), for: UIControl.State.normal)
        passwordTF.isSecureTextEntry = true
        
        setCornerRadius([forgotRoundView, forgotSubmitBtn], 5.0)
        
        let tapGesture = UITapGestureRecognizer()
        tapGesture.addTarget(self, action: #selector(closeForgotView))
        tapGesture.numberOfTapsRequired = 1
        forgotBgImg.addGestureRecognizer(tapGesture)
        forgotView.addGestureRecognizer(tapGesture)
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        closeForgotView()
        emailTF.text = "sridattareddy13@gmail.com"
        passwordTF.text = "qwerty"
    }
    
    //MARK:- Functions
    
    @objc func closeForgotView() {
        forgotView.isHidden = true
        forgotEmailTxt.isUserInteractionEnabled = false
    }
    
    
    //MARK:- Button Actions
    
    @IBAction func signUpAction(_ sender: UIButton) {
        let vc = self.storyboard?.instantiateViewController(identifier: "RegisterVC") as! RegisterViewController
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
//    func setLanguage() {
//        PlaceHolder.holdString(textField: emailTxt, placingString: "Email", color: .darkGray)
//        PlaceHolder.holdString(textField: passwordTxt, placingString: "Password", color: .darkGray)
//
//        PlaceHolder.holdString(textField: forgotEmailTxt, placingString: "Email", color: .darkGray)
//
//        signupBtn.setTitle("Sign up".localized(), for: UIControl.State.normal)
//        loginBtn.setTitle("Login".localized(), for: UIControl.State.normal)
//        forgotBtn.setTitle("Forgot Password?".localized(), for: UIControl.State.normal)
//        loginLbl.text = "Login".localized()
//        inforgotLbl.text = "Forgot Password?".localized()
//
//    }
    
    @IBAction func eyeBtnToggle(_ sender: UIButton) {
        if eyeBtn.imageView?.image == UIImage.init(named: "viewoff") {
            eyeBtn.setImage(UIImage.init(named: "viewon"), for: UIControl.State.normal)
            passwordTF.isSecureTextEntry = false
        }
        else {
            eyeBtn.setImage(UIImage.init(named: "viewoff"), for: UIControl.State.normal)
            passwordTF.isSecureTextEntry = true
        }
    }
    
    @IBAction func loginAction(_ sender: UIButton) {
        if emailTF.text!.isEmpty {
            self.view.makeToast("Please enter email")
        }
        else if !isValidEmail(emailTF.text!) {
            self.view.makeToast("Please enter valid email")
        }
        else if passwordTF.text!.isEmpty {
            self.view.makeToast("Please enter password")
        }
        else {
            startLoad()
            accountObj.loginApiCall(paramValues: [emailTF.text!,passwordTF.text!], success: { (response) in
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
            print("login User Details: ",userdetails as Any)
            saveDefaults(value: true, Key: isSignInkey);
            saveDefaults(value: userdetails, Key: userDetailkey);
            saveDefaults(value: response["user_details"]["user_id"].stringValue, Key: appUserIDKey);
            saveDefaults(value: response["user_details"]["api_key"].stringValue, Key: loginAuthKey);

            if response["user_details"]["profile_setup"].stringValue == "0" {
//                let storyboard = UIStoryboard(name: "Main", bundle: nil)
//                let vc = storyboard.instantiateViewController(withIdentifier: "MyProfileVC") as! MyProfileVC
//                vc.addOrEdit = false
//                let rvc:SWRevealViewController = self.revealViewController() as SWRevealViewController
//                rvc.pushFrontViewController(vc, animated: true)
                
//                var view: UIViewController?
//                let sidemenuStoryBoard = UIStoryboard(name: "Side Menu", bundle: nil)
//                view = sidemenuStoryBoard.instantiateViewController(withIdentifier: "MyProfileVC") as? MyProfileViewController
                
                 let rvc = self.storyboard?.instantiateViewController(identifier: "LoginToRVC") as! SWRevealViewController
                 self.navigationController?.pushViewController(rvc, animated: true)

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
        else {
            apiToastMessage(controller: self, message: response["message"].stringValue)
        }
    }
    
    
    @IBAction func forgotPasswordAction(_ sender: UIButton) {
        forgotView.isHidden = false
        forgotEmailTxt.isUserInteractionEnabled = true
        forgotEmailTxt.text = ""
    }
    
    @IBAction func forgotSubmitAction(_ sender: UIButton) {
        if forgotEmailTxt.text!.isEmpty {
            toastMessage(controller: self, message: "Please enter email")
        }
        else if !isValidEmail(forgotEmailTxt.text!) {
            toastMessage(controller: self, message: "Please enter valid email")
        }
        else {
            startLoad()
            accountObj.forgotPasswordApiCall(paramValues: [forgotEmailTxt.text!], success:{ (response) in
                stopLoad()
                self.forgotView.isHidden = true
                self.forgotEmailTxt.isUserInteractionEnabled = false
                apiToastMessage(controller: self, message: response["message"].stringValue)
            }) { error in
                stopLoad()
            }
        }
    }
    
    

}
