//
//  AddInquiryTwoViewController.swift
//  MedicalHub
//
//  Created by Sridatta Nallamilli on 13/01/20.
//  Copyright © 2020 Sridatta Nallamilli. All rights reserved.
//

import UIKit

class AddInquiryTwoViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        
    }
    
    @IBAction func backBtnClicked(_ sender: UIButton) {
//        let vc = self.storyboard?.instantiateViewController(withIdentifier: "AddInquiryVC") as! AddInquiryViewController
//        self.navigationController?.pushViewController(vc, animated: true)
        self.navigationController?.popViewController(animated: true)
    }

}
