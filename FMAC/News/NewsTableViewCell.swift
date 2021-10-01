//
//  NewsTableViewCell.swift
//  FMAC
//
//  Created by MicroExcel on 3/17/21.
//  Copyright © 2021 Fujairah. All rights reserved.
//

import UIKit

class NewsTableViewCell: UITableViewCell {

    @IBOutlet var newsDateLbl: UILabel!
    @IBOutlet var newsContentLbl: UILabel!
    @IBOutlet var newsImg: UIImageView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
