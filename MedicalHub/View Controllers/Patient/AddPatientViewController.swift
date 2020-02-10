//
//  AddPatientViewController.swift
//  MedicalHub
//
//  Created by Sridatta Nallamilli on 13/01/20.
//  Copyright © 2020 Sridatta Nallamilli. All rights reserved.
//

import UIKit

class AddPatientViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        
    }
    
    @IBAction func backBtnClicked(_ sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
    }

}
