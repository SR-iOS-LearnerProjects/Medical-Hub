//
//  AppDelegate.swift
//  MedicalHub
//
//  Created by Sridatta Nallamilli on 07/01/20.
//  Copyright © 2020 Sridatta Nallamilli. All rights reserved.
//

import UIKit
import UserNotifications
import GoogleSignIn
import FBSDKCoreKit
import FBSDKLoginKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate, UNUserNotificationCenterDelegate {

var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        
        Thread.sleep(forTimeInterval: 1.5)
        
        IQKeyboardManager.shared.enable = true
        
        // Facebook
        ApplicationDelegate.shared.application(application, didFinishLaunchingWithOptions: launchOptions)
        
        // Initialize sign-in
         GIDSignIn.sharedInstance().clientID = "620475058514-imi92hkcb17ft39veuh594std3po9jqo.apps.googleusercontent.com"
        
        return true
    }
    
    @available(iOS 9.0, *)
    func application(_ app: UIApplication, open url: URL, options: [UIApplication.OpenURLOptionsKey : Any]) -> Bool {
        
        // Facebook
          let handled: Bool = ApplicationDelegate.shared.application(app, open: url, sourceApplication: options[.sourceApplication] as? String, annotation: options[.annotation])

          // Google
          @available(iOS 9.0, *)
          func application(_ app: UIApplication, open url: URL, options: [UIApplication.OpenURLOptionsKey : Any]) -> Bool {
            return GIDSignIn.sharedInstance().handle(url)
          }

        return handled
        
//        return GIDSignIn.sharedInstance().handle(url)
        
    }
    
    // get device token
    func application(_ application: UIApplication, didRegisterForRemoteNotificationsWithDeviceToken deviceToken: Data)
    {
        let token = deviceToken.map { String(format: "%02.2hhx", $0) }.joined()
        print(token);
        saveDefaults(value: token, Key: deviceTokenKey);
    }

    // MARK: UISceneSession Lifecycle

    func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
        // Called when a new scene session is being created.
        // Use this method to select a configuration to create the new scene with.
        return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
    }

    func application(_ application: UIApplication, didDiscardSceneSessions sceneSessions: Set<UISceneSession>) {
        // Called when the user discards a scene session.
        // If any sessions were discarded while the application was not running, this will be called shortly after application:didFinishLaunchingWithOptions.
        // Use this method to release any resources that were specific to the discarded scenes, as they will not return.
    }

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
    
    func logout() {
        if cache.bool(forKey: isSignInkey)
        {
            saveDefaults(value: false, Key: isSignInkey);
            DispatchQueue.main.async {
//                let storyboard = UIStoryboard(name: "Main", bundle: nil)
                
            }
        }
    }
    
     // MARK: - Custom methods
        func loadingDefaultApplication(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?)
        {
            //Fabric.with([Crashlytics.self])
            //Facebook Launching options
            ApplicationDelegate.shared.application(application, didFinishLaunchingWithOptions: launchOptions)
            saveDefaults(value: "Token", Key: deviceTokenKey);
            //Google Launching options
            GIDSignIn.sharedInstance().clientID = "620475058514-imi92hkcb17ft39veuh594std3po9jqo.apps.googleusercontent.com"
            //"com.googleusercontent.apps.981072458679-cnp6tjd29urj4e9h43vmqjtvqtspmt2p"
            if #available(iOS 10.0, *) {
                UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .sound, .badge]) { (isGranted, error) in
                    
                    print("granted");
                }
            } else {
                // Fallback on earlier versions
            }
            if #available(iOS 10.0, *) {
                UNUserNotificationCenter.current().delegate = self
            } else {
                // Fallback on earlier versions
            };
            application.registerForRemoteNotifications()
    //        GMSServices.provideAPIKey("AIzaSyAP81q9Vn5DJFq5Q9a0ki1_OK240fUrypA");
//            let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
//            let isSignIn =  cache.bool(forKey:isSignInkey);
//            var swViewController:SWRevealViewController!
//            var frontViewController = UIViewController()
//            var rearViewController = UIViewController()
//            var frontNavigationController:UINavigationController?
//            var rearNavigationController:UINavigationController?
//            if isSignIn
//            {
//                frontViewController = storyBoard.instantiateViewController(withIdentifier: "HomeVC") as! HomeVC
//            }
//            else
//            {
//                frontViewController = storyBoard.instantiateViewController(withIdentifier: "WelcomeScreenVC") as! WelcomeScreenVC
//            }
//            rearViewController = storyBoard.instantiateViewController(withIdentifier: "SideMenuVC") as! SideMenuVC
//            frontNavigationController = UINavigationController(rootViewController: frontViewController)
//            rearNavigationController = UINavigationController(rootViewController: rearViewController)
//            frontNavigationController?.setNavigationBarHidden(true, animated: false)
//            rearNavigationController?.setNavigationBarHidden(true, animated: false)
//            let mainRevealController:SWRevealViewController = SWRevealViewController(rearViewController: rearNavigationController, frontViewController: frontNavigationController)
//            mainRevealController.delegate = self
//            swViewController = mainRevealController
//            self.window?.rootViewController = swViewController
            self.window?.makeKeyAndVisible()
        }

    

}

