//
//  CustomTableViewCell.swift
//  Alain
//
//  Created by MicroExcel on 5/19/20.
//  Copyright © 2020 Microexcel. All rights reserved.
//

import UIKit
import Material

class CustomTableViewCell: UITableViewCell {
    
    @IBOutlet var timelbl: UILabel!
    @IBOutlet var sportNameLbl: UILabel!
    @IBOutlet var coachNameLbl: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
