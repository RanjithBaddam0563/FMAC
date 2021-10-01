//
//  TrainingScheduleTableViewCell.swift
//  FMAC
//
//  Created by MicroExcel on 4/1/21.
//  Copyright © 2021 Fujairah. All rights reserved.
//

import UIKit

class TrainingScheduleTableViewCell: UITableViewCell {

    @IBOutlet var trainingTimeLbl: UILabel!
    @IBOutlet var trainingSportNameLbl: UILabel!
    @IBOutlet var trainingCoachNameLbl: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
