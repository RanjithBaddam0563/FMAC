//
//  LeadershipmsgTableViewCell.swift
//  FMAC
//
//  Created by MicroExcel on 3/16/21.
//  Copyright © 2021 Fujairah. All rights reserved.
//

import UIKit

class LeadershipmsgTableViewCell: UITableViewCell {

    @IBOutlet var LdrshpDetailContentLbl: UILabel!
    @IBOutlet var LdrshpContentLbl: UILabel!
    @IBOutlet var LdrshpImgView: UIImageView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
