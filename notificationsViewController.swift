//
//  notificationsViewController.swift
//  FMAC
//
//  Created by MicroExcel on 4/11/21.
//  Copyright © 2021 Fujairah. All rights reserved.
//

import UIKit

class notificationsViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

    }
    override func viewWillAppear(_ animated: Bool) {
        let lang_code = UserDefaults.standard.value(forKey: "lang_code")as? String
        if lang_code == "ar" {
            self.langChange(strLan: "ar")
        }else{
            self.langChange(strLan: "en")
        }
    }
    func langChange(strLan : String)
    {
        self.navigationItem.title = "Notifications".localizableString(loc: strLan)
    }
    
}
