//
//  ViewController.swift
//  MedicalHub
//
//  Created by Sridatta Nallamilli on 07/01/20.
//  Copyright © 2020 Sridatta Nallamilli. All rights reserved.
//

import UIKit
import GoogleSignIn
import FBSDKCoreKit
import FBSDKLoginKit
import SVProgressHUD

class ViewController: UIViewController {
    
    @IBOutlet weak var signUpLaterBtn: UIButton!
    @IBOutlet weak var fbBtn: UIButton!
    @IBOutlet weak var googleBtn: UIButton!
    @IBOutlet weak var emailBtn: UIButton!
    
    //MARK:- Variables
    var accountObj : Account?                               = Account()
    var socialData : JSON                                   = JSON()
    
    
    // MARK:- Life Cycle Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Button Styles
        fbBtn.layer.cornerRadius = fbBtn.frame.height / 2.0
        googleBtn.layer.cornerRadius = googleBtn.frame.height / 2.0
        emailBtn.layer.cornerRadius = emailBtn.frame.height / 2.0
        
        changeLanguage(value: "1")
        
        let userDStr = getUserDefaultsValue(for: countryResponseKey)
        if userDStr == "" {
            callCountriesApi()
        }
        else {
            let countryDetails = getJSON(countryResponseKey)
            CountryCodeJsonSome = countryDetails["countries_nationalities"].arrayObject as! [[String : Any]]
        }
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
//        setLanguage()
    }

    // Call Countries API
    func callCountriesApi() {
        startLoad()
        accountObj?.getCountriesApiCall(paramValues: ["",""], success: { (response) in
            stopLoad()
            //print(response)
            let userdetails = response.rawString();
            saveDefaults(value: userdetails, Key: countryResponseKey);
            CountryCodeJsonSome = response["countries_nationalities"].arrayObject! as! [[String : Any]]
        }) { error in
            stopLoad()
        }
    }
    
    // Set Language
    
    // MARK:- Button Actions
    
    @IBAction func signUpLaterBtnClick(_ sender: UIButton) {
         let vc = self.storyboard?.instantiateViewController(identifier: "SWRevealVC") as! SWRevealViewController
         self.navigationController?.pushViewController(vc, animated: true)
    }
    
    @IBAction func facebookLogin(_ sender: UIButton) {
         let fbmanager = LoginManager()
         fbmanager.logOut();
         fbmanager.logIn(permissions: [], from: self) { (fbresult, fberror) in
             if fberror != nil
             {
                 print("got facebook error \(fberror!)");
             }
             if fbresult != nil
             {
                 if((AccessToken.current) != nil){
                     GraphRequest(graphPath: "me", parameters: ["fields": "id, name, first_name, last_name, picture.type(large), email"]).start(completionHandler: { (connection, result, error) -> Void in
                         if (error == nil && result != nil){
                             var fbJSON = JSON(result!);
                             fbJSON["first_name"].stringValue = fbJSON["name"].stringValue
                             fbJSON["socialType"].stringValue =  "fb";
                             fbJSON["socialProfilePic"].stringValue =  fbJSON["picture"]["data"]["url"].stringValue
                             print(fbJSON["socialProfilePic"].stringValue)
                             if  !fbJSON["email"].stringValue.isEmpty
                             {
                                 fbJSON["mailExist"].intValue = 1
                             }
                             print(fbJSON["socialProfilePic"].stringValue.isEmpty)
                             self.socialData = fbJSON;
                             print(fbJSON);
//                             self.callSocialLogin();
                         }
                     })
                    let vc = self.storyboard?.instantiateViewController(identifier: "SWRevealVC") as! SWRevealViewController
                    self.navigationController?.pushViewController(vc, animated: true)
                 }
             }
            
         }
    }
    
    @IBAction func googleLogin(_ sender: UIButton) {
         GIDSignIn.sharedInstance()?.presentingViewController = self
         GIDSignIn.sharedInstance()?.delegate = self
         GIDSignIn.sharedInstance()?.signIn()
    }
    
    @IBAction func emailBtnClick(_ sender: UIButton) {
         let vc = self.storyboard?.instantiateViewController(identifier: "RegisterVC") as! RegisterViewController
         self.navigationController?.pushViewController(vc, animated: true)
    }
    
    @IBAction func logInHere(_ sender: UIButton) {
        let vc = self.storyboard?.instantiateViewController(identifier: "LoginVC") as! LoginViewController
         self.navigationController?.pushViewController(vc, animated: true)
    }
    
    
    // MARK: - API Calls
    func callSocialLogin() {
        let params = [socialData["email"].stringValue, socialData["first_name"].stringValue, socialData["socialType"].stringValue, socialData["id"].stringValue, socialData["socialProfilePic"].stringValue]
        startLoad()
        accountObj?.socialLoginApiCall(paramValues: params, success: { (response) in
            stopLoad()
            if response["user_details"]["contact_number"].stringValue == "" {
                self.socialData["user_id"].stringValue = response["user_details"]["user_id"].stringValue
                saveDefaults(value: response["user_details"]["user_id"].stringValue, Key: appUserIDKey);
                saveDefaults(value: response["user_details"]["api_key"].stringValue, Key: loginAuthKey);
                let signUp = self.storyboard?.instantiateViewController(withIdentifier: "RegisterVC") as! RegisterViewController
                signUp.regType = "social"
                signUp.socialData = self.socialData
                self.navigationController?.pushViewController(signUp, animated: true)
            }
            else {
                let userdetails = response.rawString();
                print("social login User Details: ",userdetails as Any)
                saveDefaults(value: true, Key: isSignInkey);
                saveDefaults(value: userdetails, Key: userDetailkey);
                saveDefaults(value: response["user_details"]["user_id"].stringValue, Key: appUserIDKey);
                saveDefaults(value: response["user_details"]["api_key"].stringValue, Key: loginAuthKey);
                if response["profile_setup"].stringValue == "0" {
                    let storyboard = UIStoryboard(name: "Main", bundle: nil)
                    let vc = storyboard.instantiateViewController(withIdentifier: "MyProfile") as! MyProfileViewController
//                    vc.addOrEdit = false
                    let rvc:SWRevealViewController = self.revealViewController() as SWRevealViewController
                    rvc.pushFrontViewController(vc, animated: true)
                }
                else {
                    self.performSegue(withIdentifier: "reveal", sender: nil)
                }
            }
        }, failure: { (error) in
            stopLoad()
        })
    }
    
}


extension ViewController: GIDSignInDelegate {
    
    func sign(_ signIn: GIDSignIn!, didSignInFor user: GIDGoogleUser!, withError error: Error!) {

        if let error = error {
            if (error as NSError).code == GIDSignInErrorCode.hasNoAuthInKeychain.rawValue {
                print("The user has not signed in before or they have since signed out.")
            } else {
                print("\(error.localizedDescription)")
            }
            return
        }
            
        var googleJSOn = JSON();
        googleJSOn["email"].stringValue =  user.profile.email
        googleJSOn["first_name"].stringValue = user.profile.name
        googleJSOn["id"].stringValue =  user.authentication.idToken
        googleJSOn["socialType"].stringValue =  "gplus"
        if let picURL = user.profile.imageURL(withDimension: 200)
        {
            googleJSOn["socialProfilePic"].stringValue =  picURL.absoluteString;
            print(picURL.absoluteString);
        }
        if !googleJSOn["email"].stringValue.isEmpty
        {
            googleJSOn["mailExist"].intValue = 1
            
        }
        self.socialData = googleJSOn;
        print(googleJSOn)
        callSocialLogin()
        
//        let vc = self.storyboard?.instantiateViewController(identifier: "SWRevealVC") as! SWRevealViewController
//        self.navigationController?.pushViewController(vc, animated: true)
    
    }
}

