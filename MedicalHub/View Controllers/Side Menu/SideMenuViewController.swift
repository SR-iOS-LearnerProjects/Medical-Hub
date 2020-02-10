//
//  SideMenuViewController.swift
//  MedicalHub
//
//  Created by Sridatta Nallamilli on 08/01/20.
//  Copyright © 2020 Sridatta Nallamilli. All rights reserved.
//

import UIKit
import GoogleSignIn
import SDWebImage

class SideMenuViewController: UIViewController {

    // MARK:- Outlets
    
    @IBOutlet weak var profileImg           : UIImageView!
    @IBOutlet weak var profileName          : UILabel!
    @IBOutlet weak var profileEmail         : UILabel!

    @IBOutlet var menuTableView             : UITableView!
    
    @IBOutlet var langSettingsBtn           : UIButton!
    @IBOutlet var logoutBtn                 : UIButton!

//    var userModel: UserModel?
    
    // MARK: - variables
    
//    var menuObject                                  : SideMenuStruct?
//    var menuArr                                     : [SideMenuStruct] = []
    var ud                                          : UserDefaults?
    
    var menuArr = ["Home","My Profile","Patient","Inquiry","Magazine","About Us","Contact Us"]
    var menuImgArr = [#imageLiteral(resourceName: "homeblack"), #imageLiteral(resourceName: "myprofileblack"), #imageLiteral(resourceName: "patientblack"), #imageLiteral(resourceName: "inquiryblack"), #imageLiteral(resourceName: "magazineblack"), #imageLiteral(resourceName: "aboutusblack"), #imageLiteral(resourceName: "contactblack")]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        profileImg.layer.cornerRadius = profileImg.frame.height / 2.0
        
        ud = UserDefaults.standard
//        menuArr.append(SideMenuStruct(selectionStatus: 0, menuName: "Home"))
//        menuArr.append(SideMenuStruct(selectionStatus: 0, menuName: "My Profile"))
//        menuArr.append(SideMenuStruct(selectionStatus: 0, menuName: "Patient"))
//        menuArr.append(SideMenuStruct(selectionStatus: 0, menuName: "Inquiry"))
//        menuArr.append(SideMenuStruct(selectionStatus: 0, menuName: "Magazine"))
//        menuArr.append(SideMenuStruct(selectionStatus: 0, menuName: "About Us"))
//        menuArr.append(SideMenuStruct(selectionStatus: 0, menuName: "Contact Us"))
        
        
        
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        let userDic = getJSON(userDetailkey)["user_details"].dictionaryValue
        print(userDic)
        profileName.text = userDic["user_name"]?.stringValue
        profileEmail.text = userDic["email"]?.stringValue
        var urlStr = userDic["profile_pic"]!.stringValue
        urlStr = urlStr.replacingOccurrences(of: " ", with: "%20")
        let imageURL = URL(string: urlStr)
        profileImg.sd_setImage(with: imageURL, completed: nil)
//        setLanguage()
    }
    
    // Set Language
//    func setLanguage() {
//        languageBtn.setTitle("Language Settings".localized(), for: UIControl.State.normal)
//        logoutBtn.setTitle("Logout".localized(), for: UIControl.State.normal)
//
//        if self.view.frame.size.height == 568 {
//            languageBtn.setTitle("Language\nSettings".localized(), for: UIControl.State.normal)
//            languageBtn.titleLabel?.lineBreakMode = .byWordWrapping
//        }
//
//        if ud?.integer(forKey: "menuSelect") != nil {
//            for i in 0..<menuArr.count {
//                if ud?.integer(forKey: "menuSelect") == i {
//                    menuArr[i].selectionStatus = 1
//                }
//                else {
//                    menuArr[i].selectionStatus = 0
//                }
//            }
//        }
//        sideTable.reloadData()
//
//    }
    
    func moveToWelcomeScreen() {
        saveDefaults(value: false, Key: isSignInkey)
        
        let view:ViewController = self.storyboard?.instantiateViewController(withIdentifier: "ViewController") as! ViewController
        let frontNavigationController:UINavigationController = UINavigationController(rootViewController: view)
        frontNavigationController.setNavigationBarHidden(true, animated: false)
        self.revealViewController().pushFrontViewController(frontNavigationController, animated: true)
    }
    
    @IBAction func langSettingBtnClicked(_ sender: UIButton) {
       
    }
    
    @IBAction func logoutBtnClicked(_ sender: UIButton) {
        let alert = UIAlertController(title: "Logout", message: "Are you sure you want to logout?", preferredStyle: UIAlertController.Style.alert)
        
        alert.addAction(UIAlertAction(title: "Cancel", style: UIAlertAction.Style.destructive, handler: { _ in
            //Cancel Action
        }))
        
        alert.addAction(UIAlertAction(title: "Ok", style: UIAlertAction.Style.default, handler: {(_: UIAlertAction!) in
            //Sign out action
//            self.navigationController?.popViewController(animated: true)
//            self.moveToWelcomeScreen()
            self.performSegue(withIdentifier: "backToVC", sender: nil)
        }))
        self.present(alert, animated: true, completion: nil)
    
//        GIDSignIn.sharedInstance()?.signOut()
//        self.navigationController?.popViewController(animated: true)
//        self.performSegue(withIdentifier: "backToVC", sender: nil)
//        let vc = self.storyboard?.instantiateViewController(identifier: "ViewController") as! ViewController
//        self.navigationController?.pushViewController(vc, animated: false)
    }

}


// MARK:- Extensions
//
//
//
// MARK: Side Menu Table Delegates

extension SideMenuViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 50
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return menuArr.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = menuTableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! SideMenuTableViewCell
        let bg = UIView()
        bg.backgroundColor = #colorLiteral(red: 0.2666666667, green: 0.5960784314, blue: 0.8235294118, alpha: 1)
        cell.selectedBackgroundView = bg
        cell.menuImg.image = menuImgArr[indexPath.row]
        cell.menuLabel.text = menuArr[indexPath.row]
//        cell.textLabel?.textColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
            if indexPath.row == 0 {
                let vc0 = self.storyboard?.instantiateViewController(identifier: "HomeMenuVC") as! HomeMenuViewController
                self.revealViewController()?.pushFrontViewController(vc0, animated: true)
            }
            else if indexPath.row == 1 {
                let vc0 = self.storyboard?.instantiateViewController(identifier: "MyProfileVC") as! MyProfileViewController
                self.revealViewController()?.pushFrontViewController(vc0, animated: true)
            }
            else if indexPath.row == 2 {
                let vc0 = self.storyboard?.instantiateViewController(identifier: "PatientMenuVC") as! PatientMenuViewController
                self.revealViewController()?.pushFrontViewController(vc0, animated: true)
            }
            else if indexPath.row == 3 {
                let vc0 = self.storyboard?.instantiateViewController(identifier: "InquiryMenuVC") as! InquiryMenuViewController
                self.revealViewController()?.pushFrontViewController(vc0, animated: true)
            }
            else if indexPath.row == 4 {
                let vc0 = self.storyboard?.instantiateViewController(identifier: "MagazineVC") as! MagazineViewController
                self.revealViewController()?.pushFrontViewController(vc0, animated: true)
            }
            else if indexPath.row == 5 {
                let vc0 = self.storyboard?.instantiateViewController(identifier: "AboutUsVC") as! AboutUsViewController
                self.revealViewController()?.pushFrontViewController(vc0, animated: true)
            }
            else if indexPath.row == 6 {
                let vc0 = self.storyboard?.instantiateViewController(identifier: "ContactUsVC") as! ContactUsViewController
                self.revealViewController()?.pushFrontViewController(vc0, animated: true)
            }

            
        }
    
    
}
