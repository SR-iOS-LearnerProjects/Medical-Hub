//
//  InquiryMenuTableViewCell.swift
//  MedicalHub
//
//  Created by Sridatta Nallamilli on 13/01/20.
//  Copyright © 2020 Sridatta Nallamilli. All rights reserved.
//

import UIKit

class InquiryMenuTableViewCell: UITableViewCell {
    
    @IBOutlet weak var relationName: UILabel!
    @IBOutlet weak var Name: UILabel!
    @IBOutlet weak var Desc: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
