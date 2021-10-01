//
//  LeaveViewController.swift
//  FMAC
//
//  Created by MicroExcel on 2/11/21.
//  Copyright © 2021 Fujairah. All rights reserved.
//

import UIKit

class LeaveViewController: UIViewController {
    @IBOutlet var saveBtn: UIButton!

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        saveBtn.roundCorners([ .bottomRight, .topLeft], radius: 30)

    }
  

}
