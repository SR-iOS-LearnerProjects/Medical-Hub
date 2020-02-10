//
//  InquiryMenuViewController.swift
//  MedicalHub
//
//  Created by Sridatta Nallamilli on 13/01/20.
//  Copyright © 2020 Sridatta Nallamilli. All rights reserved.
//

import UIKit

class InquiryMenuViewController: UIViewController {

    @IBOutlet var inquiryTableView: UITableView!
    
    let inquiryRelationArr = ["Relation 1","Relation 2","Relation 3","Relation 4","Relation 5","Relation 6","Relation 7","Relation 8","Relation 9","Relation 10"]
    let inquiryNameArr = ["Name 1","Name 2","Name 3","Name 4","Name 5","Name 6","Name 7","Name 8","Name 9","Name 10"]
    let inquiryDescArr = ["Description 1","Description 2","Description 3","Description 4","Description 5","Description 6","Description 7","Description 8","Description 9","Description 10"]
    
    @IBOutlet var menuButton: UIButton!
    
    @IBOutlet var addInquiryBtn: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        let reveal: SWRevealViewController = revealViewController()
        reveal.tapGestureRecognizer()
         menuButton.addTarget(revealViewController(), action: #selector(SWRevealViewController.revealToggle(_:)), for: UIControl.Event.touchUpInside)
        
    }
    
    @IBAction func addInquiryBtnClicked(_ sender: UIButton) {
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "AddInquiryVC") as! AddInquiryViewController
        self.navigationController?.pushViewController(vc, animated: true)
    }

}

extension InquiryMenuViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return inquiryRelationArr.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = inquiryTableView.dequeueReusableCell(withIdentifier: "cell") as! InquiryMenuTableViewCell
        cell.relationName.text = inquiryRelationArr[indexPath.row]
        cell.Name.text = inquiryNameArr[indexPath.row]
        cell.Desc.text = inquiryDescArr[indexPath.row]
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "InquiryDetailsVC") as! InquiryDetailsViewController
        vc.relName = inquiryRelationArr[indexPath.row]
        vc.Name = inquiryNameArr[indexPath.row]
        vc.Desc = inquiryDescArr[indexPath.row]
        self.navigationController?.pushViewController(vc, animated: true)
    }
        
}
