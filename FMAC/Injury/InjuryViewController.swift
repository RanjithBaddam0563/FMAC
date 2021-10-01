//
//  InjuryViewController.swift
//  FMAC
//
//  Created by MicroExcel on 2/12/21.
//  Copyright © 2021 Fujairah. All rights reserved.
//

import UIKit

class InjuryViewController: UIViewController {
    @IBOutlet var saveBtn: UIButton!

    override func viewDidLoad() {
        super.viewDidLoad()
        saveBtn.roundCorners([ .bottomRight, .topLeft], radius: 30)

        // Do any additional setup after loading the view.
    }
    

    

}
