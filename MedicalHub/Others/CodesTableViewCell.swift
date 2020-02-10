//
//  CodesTableViewCell.swift
//  MedicalHub
//
//  Created by Sridatta Nallamilli on 10/01/20.
//  Copyright © 2020 Sridatta Nallamilli. All rights reserved.
//

import UIKit

class CodesTableViewCell: UITableViewCell {
    
    @IBOutlet weak var codeLbl: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
