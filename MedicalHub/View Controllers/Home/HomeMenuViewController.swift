//
//  HomeMenuViewController.swift
//  MedicalHub
//
//  Created by Sridatta Nallamilli on 08/01/20.
//  Copyright © 2020 Sridatta Nallamilli. All rights reserved.
//

import UIKit
import DScrollView

class HomeMenuViewController: UIViewController {

    let scrollView = DScrollView()
    let scrollViewContainer = DScrollViewContainer(axis: .vertical, spacing: 0)
    let scrollViewElement = DScrollViewElement(height: 530, backgroundColor: UIColor.clear)
    
    @IBOutlet weak var menuButton: UIButton!
    
    @IBOutlet weak var bodyView: UIView!
    @IBOutlet weak var bodyContainerView: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        let reveal: SWRevealViewController = revealViewController()
            reveal.tapGestureRecognizer()
             menuButton.addTarget(revealViewController(), action: #selector(SWRevealViewController.revealToggle(_:)), for: UIControl.Event.touchUpInside)
        
        revealViewController()?.rearViewRevealWidth = 360
        
        bodyView.addSubview(scrollView)
        
        bodyView.addScrollView(scrollView, withSafeArea: .vertical, hasStatusBarCover: true, statusBarBackgroundColor: UIColor.clear, container: scrollViewContainer, elements: scrollViewElement)
        
        scrollViewElement.addSubview(bodyContainerView)
        
    }


}
