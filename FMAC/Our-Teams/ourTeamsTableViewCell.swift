//
//  ourTeamsTableViewCell.swift
//  FMAC
//
//  Created by MicroExcel on 3/22/21.
//  Copyright © 2021 Fujairah. All rights reserved.
//

import UIKit

class ourTeamsTableViewCell: UITableViewCell {

    @IBOutlet var bottomView: UIView!
    @IBOutlet var detailedTxtLbl: UILabel!
    @IBOutlet var imgVw: UIImageView!
    @IBOutlet var titleLbl: UILabel!
    @IBOutlet var mainView: UIView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
