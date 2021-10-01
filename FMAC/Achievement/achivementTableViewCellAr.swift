//
//  achivementTableViewCellAr.swift
//  FMAC
//
//  Created by MicroExcel on 5/28/21.
//  Copyright © 2021 Fujairah. All rights reserved.
//

import UIKit

class achivementTableViewCellAr: UITableViewCell {
    @IBOutlet var readMoreBtn: UIButton!
    @IBOutlet var achivDateLbl: UILabel!
    @IBOutlet var achivTxtLbl: UILabel!
    @IBOutlet var achivImg: UIImageView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
