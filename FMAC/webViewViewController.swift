//
//  webViewViewController.swift
//  Alain
//
//  Created by MicroExcel on 7/16/20.
//  Copyright © 2020 Microexcel. All rights reserved.
//

import UIKit
import WebKit

class webViewViewController: UIViewController , WKUIDelegate{

    var webView: WKWebView!

    var fileUrlStr : String = ""

    var salarySlipId : String = ""
    
    override func loadView() {
          super.loadView()
          let webConfiguration = WKWebViewConfiguration()
          webView = WKWebView(frame: .zero, configuration: webConfiguration)
          webView.uiDelegate = self
          view = webView
      }
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let lang_code = UserDefaults.standard.value(forKey: "lang_code")as? String
        if lang_code == "ar" {
            fileUrlStr = MyStrings().BASEURL1 + "ar/pages/contact-us.aspx"
        }else{
            fileUrlStr = MyStrings().BASEURL1 + "en/pages/contact-us.aspx"
        }
        if let url = URL(string: fileUrlStr) {
            print(url)
            let request = URLRequest(url: url)
            DispatchQueue.main.async {
                self.webView.load(request)
            }
          
        }else{
            print("Nil")
        }
        }
        // Do any additional setup after loading the view.
    
    }
   
          
    


