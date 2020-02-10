//
//  Account.swift
//  MedicalHub
//
//  Created by Sridatta Nallamilli on 23/01/20.
//  Copyright © 2020 Sridatta Nallamilli. All rights reserved.
//

import Foundation
import Alamofire

class Account {
    
    var email: String?           = ""
    var password: String?        = ""
    var userName: String?        = ""
    var contactNumber: String?   = ""
    var phoneCode: String?       = ""
    var phoneCodeID: String?     = ""
    var userID: String?          = ""
    var age: String?             = ""
    var gender: String?          = ""
    var dobStr: String?          = ""
    var bloodGroup: String?      = ""
    var remarks: String?         = ""
    var nationality: String?     = ""
    var nationalityID: String?   = ""
    var maritialStatus: String?  = ""
    var respectWord: String?     = ""
    var countryID: String?       = ""
    var profile_pic              = [JSON]()
    
    
    func signUpApiCall(accountParams: Account, success: @escaping (_ responseJSON: JSON) -> (), failure: @escaping (apiFailureEnum) -> ()) {
//        let params: [String: Any] = ["email": accountParams.email!, "password": accountParams.password!, "user_name": accountParams.userName!, "contact_number": accountParams.contactNumber!, "platform": platform, "device_id": getUserDefaultsValue(for: deviceTokenKey), "language": getUserDefaultsValue(for: languageKey), "phone_code": accountParams.phoneCode!, "phone_code_id": accountParams.phoneCodeID!]
        
        let params: [String: Any] = ["email": accountParams.email!, "password": accountParams.password!, "user_name": accountParams.userName!, "contact_number": accountParams.contactNumber!, "platform": platform, "device_id": deviceTokenKey, "language": getUserDefaultsValue(for: languageKey), "phone_code": accountParams.phoneCode!, "phone_code_id": accountParams.phoneCodeID!]
        
        Network.process(.post, url: "registration", headers: defaultHeader, params: params, success: { (response) in
            var responseJson = response
            if response["status"].stringValue == "success" {
                responseJson["status"].stringValue = apiSuccesskey
            }
            else if response["status"].stringValue == "error" {
                responseJson["status"].stringValue = apiErrorKey
            }
            success(responseJson)
        }) { error in
            failure(error)
        }
    }
    
    
    
    func loginApiCall(paramValues : [String], success: @escaping (_ responseJSON: JSON) -> (), failure: @escaping (apiFailureEnum) -> ()) {
//        let params: [String: Any] = ["email": paramValues[0], "password": paramValues[1], "platform": platform, "device_id": getUserDefaultsValue(for: deviceTokenKey), "language": getUserDefaultsValue(for: languageKey)]
        
         let params: [String: Any] = ["email": paramValues[0],
                                      "password": paramValues[1],
                                      "platform": platform,
                                      "device_id": deviceTokenKey,
                                      "language": 1
        ]
        
        Network.process(.post, url: "login", headers: defaultHeader, params: params, success: { (response) in
            var responseJson = response
            if response["status"].stringValue == "success" {
                responseJson["status"].stringValue = apiSuccesskey
            }
            else if response["status"].stringValue == "error" {
                responseJson["status"].stringValue = apiErrorKey
            }
            success(responseJson)
        }) { error in
            failure(error)
        }
    }
    
    
    
    func socialLoginApiCall(paramValues : [String], success: @escaping (_ responseJSON: JSON) -> (), failure: @escaping (apiFailureEnum) -> ()) {
        let params: [String: Any] = ["email": paramValues[0], "user_name": paramValues[1], "social_type": paramValues[2], "social_id": paramValues[3], "profile_pic": paramValues[4], "platform": platform, "device_id": getUserDefaultsValue(for: deviceTokenKey), "language": getUserDefaultsValue(for: languageKey)]
        Network.process(.post, url: "socialLogin", headers: defaultHeader, params: params, success: { (response) in
            var responseJson = response
            if response["status"].stringValue == "success" {
                responseJson["status"].stringValue = apiSuccesskey
            }
            else if response["status"].stringValue == "error" {
                responseJson["status"].stringValue = apiErrorKey
            }
            success(responseJson)
        }) { error in
            failure(error)
        }
    }
    
    
    
    func socialProfileSetupApiCall(paramValues : [String], success: @escaping (_ responseJSON: JSON) -> (), failure: @escaping (apiFailureEnum) -> ()) {
        let params: [String: Any] = ["email": paramValues[0], "user_name": paramValues[1], "social_type": paramValues[2], "social_id": paramValues[3], "contact_number": paramValues[4], "phone_code": paramValues[4], "phone_code_id": paramValues[4], "user_id": paramValues[4], "profile_pic": paramValues[4], "platform": platform, "device_id": getUserDefaultsValue(for: deviceTokenKey), "language": getUserDefaultsValue(for: languageKey)]
        Network.process(.post, url: "social_profile_setup", headers: ["Authorization": getUserDefaultsValue(for: loginAuthKey)], params: params, success: { (response) in
            var responseJson = response
            if response["status"].stringValue == "success" {
                responseJson["status"].stringValue = apiSuccesskey
            }
            else if response["status"].stringValue == "error" {
                responseJson["status"].stringValue = apiErrorKey
            }
            success(responseJson)
        }) { error in
            failure(error)
        }
    }
    
    
    
    func getUserProfileApiCall(paramValues : [String], success: @escaping (_ responseJSON: JSON) -> (), failure: @escaping (apiFailureEnum) -> ()) {
        let params: [String: Any] = ["user_id": paramValues[0], "language": getUserDefaultsValue(for: languageKey)]
        Network.process(.post, url: "get_user_profile", headers: ["Authorization": getUserDefaultsValue(for: loginAuthKey)], params: params, success: { (response) in
            var responseJson = response
            if response["status"].stringValue == "success" {
                responseJson["status"].stringValue = apiSuccesskey
            }
            else if response["status"].stringValue == "error" {
                responseJson["status"].stringValue = apiErrorKey
            }
            success(responseJson)
        }) { error in
            failure(error)
        }
    }
    
    
    
    func forgotPasswordApiCall(paramValues : [String], success: @escaping (_ responseJSON: JSON) -> (), failure: @escaping (apiFailureEnum) -> ()) {
        let params: [String: Any] = ["email": paramValues[0], "language": getUserDefaultsValue(for: languageKey)]
        Network.process(.post, url: "forgotpassword", headers: defaultHeader, params: params, success: { (response) in
            var responseJson = response
            if response["status"].stringValue == "success" {
                responseJson["status"].stringValue = apiSuccesskey
            }
            else if response["status"].stringValue == "error" {
                responseJson["status"].stringValue = apiErrorKey
            }
            success(responseJson)
        }) { error in
            failure(error)
        }
    }
    
    
    
    func logOutApiCall(paramValues : [String], success: @escaping (_ responseJSON: JSON) -> (), failure: @escaping (apiFailureEnum) -> ()) {
        let params: [String: Any] = ["user_id": paramValues[0], "device_id": getUserDefaultsValue(for: deviceTokenKey)]
        Network.process(.post, url: "logout", headers: ["Authorization": getUserDefaultsValue(for: loginAuthKey)], params: params, success: { (response) in
            var responseJson = response
            if response["status"].stringValue == "success" {
                responseJson["status"].stringValue = apiSuccesskey
            }
            else if response["status"].stringValue == "error" {
                responseJson["status"].stringValue = apiErrorKey
            }
            success(responseJson)
        }) { error in
            failure(error)
        }
    }
    
    
    
    func profileSetUpApiCall(accountParams: Account, success: @escaping (_ responseJSON: JSON) -> (), failure: @escaping (apiFailureEnum) -> ()) {

        let params: [String: Any] = ["user_id": accountParams.userID!, "user_name": accountParams.userName!, "email": accountParams.email!, "password": accountParams.password!, "gender": accountParams.gender!, "dob": accountParams.dobStr!, "blood_group": accountParams.bloodGroup!, "age": accountParams.age!, "remarks": accountParams.remarks!, "nationality": accountParams.nationalityID!, "country_id": accountParams.countryID!, "contact_number": accountParams.contactNumber!, "phone_code": accountParams.phoneCode!, "phone_code_id": accountParams.phoneCodeID!, "marital_status": accountParams.maritialStatus!, "respect_word": accountParams.respectWord!, "platform": platform, "device_id": getUserDefaultsValue(for: deviceTokenKey), "language": getUserDefaultsValue(for: languageKey)]
        let jsonParams  = JSON(params);
        
        Network.uploadImageWithParams(request: .post, url: "profile_setup", headers: ["Authorization": getUserDefaultsValue(for: loginAuthKey)], params: jsonParams, imgedata: accountParams.profile_pic, success: { (response) in
            var responseJson = response
            if response["status"].stringValue == "success" {
                responseJson["status"].stringValue = apiSuccesskey
            }
            else if response["status"].stringValue == "error" {
                responseJson["status"].stringValue = apiErrorKey
            }
            success(responseJson)
        }) { error in
            failure(error)
        }
    }

    
    func getCountriesApiCall(paramValues : [String], success: @escaping (_ responseJSON: JSON) -> (), failure: @escaping (apiFailureEnum) -> ()) {
        let params: [String: Any] = ["user_id": "1", "language": getUserDefaultsValue(for: languageKey)]
        Network.process(.post, url: "countries_nationalities", headers: defaultHeader, params: params, success: { (response) in
            var responseJson = response
            if response["status"].stringValue == "success" {
                responseJson["status"].stringValue = apiSuccesskey
            }
            else if response["status"].stringValue == "error" {
                responseJson["status"].stringValue = apiErrorKey
            }
            success(responseJson)
        }) { error in
            failure(error)
        }
    }
    
}
