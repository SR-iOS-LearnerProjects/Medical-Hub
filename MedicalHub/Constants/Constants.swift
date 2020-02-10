//
//  Constants.swift
//  MedicalHub
//
//  Created by Sridatta Nallamilli on 26/01/20.
//  Copyright © 2020 Sridatta Nallamilli. All rights reserved.
//

import Foundation
import UIKit
import Alamofire
import SVProgressHUD
import Toast_Swift
import ANLoader
import NVActivityIndicatorView


public enum apiFailureEnum : String {
    case isApiError
    case isnetworkError
    case isSessionExpired
}

// MARK: Default Values
let selectionColor                          = UIColor.init(red: 0, green: 144/255, blue: 1, alpha: 1.0)
var cache                                   = UserDefaults.standard
let dateFormatter                           = DateFormatter()
var searchParams                            = Parameters()
let platform                                = "1"; // ios
let defaultHeader                           =  ["Authorization": defaultAuthKey]
let googlePlacesAPI                         = "AIzaSyBNii-vqbmrPLukoC5qF-gSxWOyFZktx7c"

// MARK: API URLS
public let devBaseURL                = "http://bu3dev.krify.com/medicalhub_web/mobapp/v1/"
public let liveBaseURL               = "http://bu3dev.krify.com/medicalhub_web/mobapp/v1/"
public let defaultAuthKey            = "a2b17f5605d91f49bcb01b72ba6fda61"

public let baseURL                   = devBaseURL


// MARK: User Default Keys
let deviceTokenKey                          = "deviceToken"
let countryResponseKey                      = "countryResponse"
let languageKey                             = "1"// "language"
let latitudekey                             = "latitude"
let longitutdekey                           = "longitude"
let isSignInkey                             = "isLoggedIn"
let userDetailkey                           = "userDetails"
let appUserIDKey                            = "appUserID"
let loginAuthKey                            = "loginAuth"
// MARK: Defaults
let apiSuccesskey                           = "Success";
let OTPVerificationKey                      = "OTPVefrification"
let apiErrorKey                             = "Error"
let gotoSocialSignupKey                     = "SocialSignUp"

// MARK:- Validation Functions

// Change Language Value
func changeLanguage(value: String) { // 1 english, 2. arabic
    saveDefaults(value: value, Key: languageKey);
}

// Set Corner Radius
func setCornerRadius( _ allview : [UIView], _ radius : CGFloat) {
   for vw in allview
   {
       vw.layer.cornerRadius = radius
       vw.clipsToBounds = true;
       vw.layer.masksToBounds = true;
   }
}

func setCornerRadiuesBlue( _ allview : [UIView], _ radius : CGFloat)
    {
        for vw in allview
        {
            vw.layer.cornerRadius = radius
            vw.clipsToBounds = true;
            vw.layer.masksToBounds = false;
            
            vw.layer.shadowColor = #colorLiteral(red: 0.2588235438, green: 0.7568627596, blue: 0.9686274529, alpha: 1)
            vw.layer.shadowOpacity = 1.0
            vw.layer.shadowRadius = 2
            vw.layer.shadowOffset = CGSize(width: 0, height: 0)
            
//            vw.dropShadow(color: UIColor(red: 0, green: 56/255, blue: 110/255, alpha: 1), opacity: 1, offSet: CGSize(width: 0, height: 0), radius: 3, scale: true)
        }
    }

func setBlueShadow ( _ allview : [UIView])
    {
        for vw in allview
        {
//            vw.layer.cornerRadius = radius
            vw.clipsToBounds = true;
            vw.layer.masksToBounds = false;
            
            vw.layer.shadowColor = #colorLiteral(red: 0.2588235438, green: 0.7568627596, blue: 0.9686274529, alpha: 1)
            vw.layer.shadowOpacity = 1.0
            vw.layer.shadowRadius = 2
            vw.layer.shadowOffset = CGSize(width: 0, height: 0)
            
//            vw.dropShadow(color: UIColor(red: 0, green: 56/255, blue: 110/255, alpha: 1), opacity: 1, offSet: CGSize(width: 0, height: 0), radius: 3, scale: true)
        }
    }
   
//get json from string
func getJSON(_ keyv :  String) -> JSON
{
    var resultJSON = JSON()
    let jsonSTR =  cache.string(forKey: keyv)
    if jsonSTR == nil
    {
        return resultJSON;
    }
    if let data = jsonSTR!.data(using: .utf8) {
        if let jsonObject = try? JSON(data: data) {
            resultJSON = jsonObject;
        }
    }
    return resultJSON
}

// Name Validation
func isValidName(_ fname : String) -> Bool
{
    var isValid = true;
    let fullname = fname.replacingOccurrences(of: " ", with: "");
    let allowedCharacters = "ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz1234567890"
    let allowedCharacterSet = CharacterSet(charactersIn: allowedCharacters)
    let typedCharacterSet = CharacterSet(charactersIn: fullname)
    isValid = allowedCharacterSet.isSuperset(of: typedCharacterSet)
    return isValid
}

//Phone Number Validation
func isValidPhone(_ phone : String) -> Bool
{
    return CharacterSet.decimalDigits.isSuperset(of: CharacterSet(charactersIn: phone))
}

// Email Validation
func isValidEmail(_ email : String) -> Bool
{
    let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
    let emailPred = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
    return emailPred.evaluate(with: email)
}

// Password Validation
func isValidPassword(_ password : String) -> Bool
{
    let passString =  password.trimmingCharacters(in: .whitespacesAndNewlines)
    let passwordRegex = "(?:(?:(?=.*?[0-9])(?=.*?[-!@#$%&*ˆ+=_])|(?:(?=.*?[0-9])|(?=.*?[A-Z])|(?=.*?[-!@#$%&*ˆ+=_])))|(?=.*?[a-z])(?=.*?[0-9])(?=.*?[-!@#$%&*ˆ+=_]))[A-Za-z0-9-!@#$%&*ˆ+=_]{6,15}"
    return NSPredicate(format: "SELF MATCHES %@", passwordRegex).evaluate(with: passString);
}

// Toast Message Functions
func toastMessage(controller : UIViewController, message : String)
{
//    controller.view.makeToast(message.localized());
    controller.view.makeToast(message);
}

func apiToastMessage(controller : UIViewController, message : String)
{
    controller.view.makeToast(message);
}

// Progress Loading View Functions
func startLoad()
{
    
    
    DispatchQueue.main.async {
//        SVProgressHUD.setDefaultStyle(.dark)
//        SVProgressHUD.setDefaultMaskType(.black)
//        SVProgressHUD.show()
        
         ANLoader.showLoading("Loading", disableUI: true)
         ANLoader.pulseAnimation = true //It will animate your Loading
         ANLoader.activityColor = .white
         ANLoader.activityBackgroundColor = .darkGray
         ANLoader.activityTextColor = .white
         ANLoader.showLoading()
    }
}

func stopLoad()
{
    DispatchQueue.main.async {
//        SVProgressHUD.dismiss()
        ANLoader.hide()
    }
}

// User Defaults
func saveDefaults(value : Any?, Key : String)
{
    if value != nil
    {
        cache.set(value!, forKey: Key);
    }
    else
    {
        print("got nil value to save in defautls")
    }
    cache.synchronize()
}

func getUserDefaultsValue(for key: String) -> String
{
    let value = cache.string(forKey: key);
    if value == nil
    {
        return "";
    }
    return value!
}

func getUserDefaultsObject(for key: String) -> Any
{
    let value = cache.string(forKey: key);
    if value == nil
    {
        return "";
    }
    return value!
}

// Alert & API Alert Message
public class AlertMessage {
    class func ShowAlert(title: String, message: String, in vc: UIViewController, completion : ((UIAlertAction) -> Void)?) {
//        let alert = UIAlertController(title: title.localized(), message: message.localized(), preferredStyle: UIAlertController.Style.alert)
//        alert.addAction(UIAlertAction(title: "OK".localized(), style: UIAlertAction.Style.default, handler: completion))
        
        let alert = UIAlertController(title: title, message: message, preferredStyle: UIAlertController.Style.alert)
        alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: completion))
        vc.present(alert, animated: true, completion: nil)
    }
    
    class func ShowApiAlert(title: String, message: String, in vc: UIViewController, completion : ((UIAlertAction) -> Void)?) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: UIAlertController.Style.alert)
//        alert.addAction(UIAlertAction(title: "OK".localized(), style: UIAlertAction.Style.default, handler: completion))
        alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: completion))
        vc.present(alert, animated: true, completion: nil)
    }
}
