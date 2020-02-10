//
//  Network.swift
//  MedicalHub
//
//  Created by Sridatta Nallamilli on 23/01/20.
//  Copyright © 2020 Sridatta Nallamilli. All rights reserved.
//

import Foundation
import UIKit
import Alamofire
import Reachability
import SVProgressHUD

class Network {
    
    static func process(_ request: HTTPMethod, url: String, headers: [String:String]?, params: Parameters?, success: @escaping (_ JSON: JSON) -> (), failure: @escaping (_ error: apiFailureEnum) -> ()) {
        print("\(baseURL)\(url)");
        print(params!)

        do {
            let reacher = try Reachability()
            var responseData =  JSON()
            if reacher.connection == .unavailable
            {
                failure(.isnetworkError)
            }
            else
            {
                Alamofire.request("\(baseURL)\(url)", method: request, parameters: params, headers: headers) .responseJSON { response in
                    switch response.result {
                    case .success(let json):
                        print("handleresponse", json)
                        print(response.response?.statusCode as Any);
                        if let statusCode = response.response?.statusCode, statusCode == 200 {
                            responseData = JSON(response.result.value!);
                            success(responseData)
//                            if responseData["status"].stringValue == "error"
//                            {
//                                success(responseData)
//                            }
//                            else
//                            {
//                                success(responseData)
//                            }
                        }
                        else if let statusCode = response.response?.statusCode, statusCode == 401
                        {
//                            stopLoad();
                            DispatchQueue.main.async {
                                SVProgressHUD.dismiss()
                            }
                            
                            let appDelegate = UIApplication.shared.delegate as! AppDelegate
                            appDelegate.logout()
                        }
                        else{
                            failure(.isApiError)
                        }
                    case .failure(let error):
                        print(error);
                        failure(.isApiError);
                    }
                }
            }
        }
        catch _ as NSError {
            // error
        }
    }
    
    
    static func processBasicURL(request: HTTPMethod, url: String, headers: [String:String]?, params: Parameters?, success: @escaping (_ JSON: JSON) -> (), failure: @escaping (_ error: apiFailureEnum) -> ()) {
        print("\(baseURL)\(url)");
        print(params!)
        do {
            let reacher = try Reachability()
            var responseData =  JSON()
            if reacher.connection == .unavailable
            {
                failure(.isnetworkError)
            }
            else
            {
                
                Alamofire.request(url, method: request, parameters: params, headers: headers) .responseJSON { response in
                    switch response.result {
                    case .success(let json):
                        print("handleresponse", json)
                        print(response.response?.statusCode as Any);
                        if let statusCode = response.response?.statusCode, statusCode == 200 {
                            responseData = JSON(response.result.value!);
                            success(responseData)
                        }
                        else{
                            failure(.isApiError)
                        }
                    case .failure(let error):
                        print(error);
                        failure(.isApiError);
                    }
                }
            }
        }
        catch _ as NSError {
            // error
        }
    }
    
    
    // MARK:Global imageuploader
   static func uploadImageWithParams(request : HTTPMethod,  url : String, headers: [String:String]?, params: JSON?,imgedata : [JSON], success: @escaping (_ JSON: JSON) -> (), failure: @escaping (_ error: apiFailureEnum) -> ())
    {
        print("\(baseURL)\(url)");
        print("API Params as \(String(describing: params))");
        print("API Headers  as \(String(describing: headers))");
        do {
            let reacher = try Reachability()
            if reacher.connection == .unavailable
            {
                failure(.isnetworkError)
            }
            else
            {
                Alamofire.upload(multipartFormData: { (multiformdata) in
                    var convertiondata : Data?
                    for jdata in imgedata
                    {
                        convertiondata = Data.init(base64Encoded: jdata["imgdata"].stringValue, options: .ignoreUnknownCharacters);
                        if convertiondata != nil
                        {
                            multiformdata.append( convertiondata!, withName: jdata["picname"].stringValue, fileName: jdata["picname"].stringValue, mimeType: "image/jpeg")
                            print("got image");
                        }
                    }
                    if params != nil
                    {
                        for (key, _ ) in params! {
                            multiformdata.append(params![key].stringValue.data(using: .utf8)!, withName: key);
                        }
                    }
                    
                },  to: "\(baseURL)\(url)", method: request, headers: headers) { (sessionresult) in
                    print("got resutl");
                    print(sessionresult)
                    switch sessionresult {
                    case .success(let req, _, _):
                        req.responseJSON {
                            response in
                            if let uploadresult = response.result.value {
                                print("handleresponse", uploadresult)
                                let responseData = JSON(uploadresult);
                                success(responseData)
                            }
                            else
                            {
                                failure(.isApiError)
                                
                            }
                        }
                    case .failure(let error):
                        print(error);
                        failure(.isApiError)
                    }
                }
                
            }
        }
        catch let error as NSError {
            print(error);
        }
    }

    
}
