//
//  EventsTableViewCell.swift
//  FMAC
//
//  Created by MicroExcel on 3/26/21.
//  Copyright © 2021 Fujairah. All rights reserved.
//

import UIKit

class EventsTableViewCell: UITableViewCell {
    @IBOutlet var eventdateArLbl: UILabel!
    @IBOutlet var eventdateLbl: UILabel!
    @IBOutlet var eventNameArLbl: UILabel!
    @IBOutlet var viewAllArBtn: UIButton!
    @IBOutlet var ArabicView: UIView!
    @IBOutlet var englishView: UIView!
    @IBOutlet var viewAllBtn: UIButton!
    @IBOutlet var eventNameLbl: UILabel!
    @IBOutlet var eventImgVw: UIImageView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
