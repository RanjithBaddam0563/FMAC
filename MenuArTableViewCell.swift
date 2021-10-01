//
//  MenuArTableViewCell.swift
//  FMAC
//
//  Created by MicroExcel on 6/6/21.
//  Copyright © 2021 Fujairah. All rights reserved.
//

import UIKit

class MenuArTableViewCell: UITableViewCell {

    @IBOutlet var menuArrowView: UIImageView!
    @IBOutlet var menuTitleLbl: UILabel!
    @IBOutlet var menuImgView: UIImageView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
