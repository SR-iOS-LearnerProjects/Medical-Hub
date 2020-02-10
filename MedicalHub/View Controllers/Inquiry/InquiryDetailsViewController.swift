//
//  InquiryDetailsViewController.swift
//  MedicalHub
//
//  Created by Sridatta Nallamilli on 13/01/20.
//  Copyright © 2020 Sridatta Nallamilli. All rights reserved.
//

import UIKit

class InquiryDetailsViewController: UIViewController {
    
    @IBOutlet var backBtn: UIButton!

    @IBOutlet weak var patientName: UILabel!
    @IBOutlet weak var relationName: UILabel!
    @IBOutlet weak var patientNameTF: UITextField!
    @IBOutlet weak var descTV: UITextView!
    
    var relName = ""
    var Name = ""
    var Desc = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()

        patientName.text = Name
        relationName.text = relName
        patientNameTF.text = Name
        descTV.text = Desc
        
        
    }
    
    @IBAction func backBtnClicked(_ sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
    }
    


}
