//
//  newViewController.swift
//  MedicalHub
//
//  Created by Sridatta Nallamilli on 25/01/20.
//  Copyright © 2020 Sridatta Nallamilli. All rights reserved.
//

import UIKit
import DScrollView

class newViewController: UIViewController {

    @IBOutlet weak var containerView: UIView!
    @IBOutlet weak var mainView: UIView!
    
    let scrollView = DScrollView()
    let scrollViewContainer = DScrollViewContainer(axis: .vertical, spacing: 8)
    let scrollViewElement = DScrollViewElement(height: 800, backgroundColor: UIColor.clear)
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        containerView.addSubview(scrollView)
        
//        view.addScrollView(scrollView, withSafeArea: .vertical, hasStatusBarCover: true, statusBarBackgroundColor: UIColor.clear, container: scrollViewContainer, elements: scrollViewElement)
        
        containerView.addScrollView(scrollView, withSafeArea: .vertical, hasStatusBarCover: true, statusBarBackgroundColor: UIColor.clear, container: scrollViewContainer, elements: scrollViewElement)
        
        scrollViewElement.addSubview(mainView)
        
    }

}
