//
//  MagazineViewController.swift
//  MedicalHub
//
//  Created by Sridatta Nallamilli on 27/01/20.
//  Copyright © 2020 Sridatta Nallamilli. All rights reserved.
//

import UIKit

class MagazineViewController: UIViewController {

    @IBOutlet weak var menuButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        let reveal: SWRevealViewController = revealViewController()
            reveal.tapGestureRecognizer()
             menuButton.addTarget(revealViewController(), action: #selector(SWRevealViewController.revealToggle(_:)), for: UIControl.Event.touchUpInside)
        
        revealViewController()?.rearViewRevealWidth = 360
        
    }
    


}
