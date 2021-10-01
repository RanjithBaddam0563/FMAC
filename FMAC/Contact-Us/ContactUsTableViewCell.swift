//
//  ContactUsTableViewCell.swift
//  FMAC
//
//  Created by MicroExcel on 5/2/21.
//  Copyright © 2021 Fujairah. All rights reserved.
//

import UIKit

class ContactUsTableViewCell: UITableViewCell {

    @IBOutlet var itemOrderLbl: UILabel!
    @IBOutlet var iconClassLbl: UILabel!
    @IBOutlet var valueLbl: UILabel!
    @IBOutlet var titleLbl: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
