//
//  BriefViewController.swift
//  FMAC
//
//  Created by MicroExcel on 3/18/21.
//  Copyright © 2021 Fujairah. All rights reserved.
//

import UIKit
import FSPagerView
import LGSideMenuController
import LGSideMenuController.LGSideMenuController
import LGSideMenuController.UIViewController_LGSideMenuController
class BriefViewController: LGSideMenuController,UIGestureRecognizerDelegate {

    @IBOutlet var bottomTxtLbl: UILabel!
    @IBOutlet var missionDetailedLbl: UILabel!
    @IBOutlet var missionLbl: UILabel!
    @IBOutlet var visionDetailedLbl: UILabel!
    @IBOutlet var visionLbl: UILabel!
    @IBOutlet var startingContentLbl: UILabel!
    @IBOutlet weak var AlphaView: UIView!

    override func viewWillAppear(_ animated: Bool) {
        hideLeftView(animated: false, completionHandler: nil)
        self.navigationController?.navigationBar.tintColor = .white

        self.AlphaView.isHidden = true
        let lang_code = UserDefaults.standard.value(forKey: "lang_code")as? String
        if lang_code == "ar" {
            
            self.langChange(strLan: "ar")
            self.startingContentLbl.textAlignment = .right
            self.visionLbl.textAlignment = .right
            self.visionDetailedLbl.textAlignment = .right
            self.missionLbl.textAlignment = .right
            self.missionDetailedLbl.textAlignment = .right
            self.bottomTxtLbl.textAlignment = .right

        }else{
            self.langChange(strLan: "en")
            self.startingContentLbl.textAlignment = .left
            self.visionLbl.textAlignment = .center
            self.visionDetailedLbl.textAlignment = .center
            self.missionLbl.textAlignment = .center
            self.missionDetailedLbl.textAlignment = .center
            self.bottomTxtLbl.textAlignment = .left
        }
    }
    func langChange(strLan : String)
    {
        self.title = "Brief".localizableString(loc: strLan)
        startingContentLbl.text = "BriefContent".localizableString(loc: strLan)
        visionLbl.text = "Vision".localizableString(loc: strLan)
        visionDetailedLbl.text = "VisionContent".localizableString(loc: strLan)
        missionLbl.text = "Mission".localizableString(loc: strLan)
        missionDetailedLbl.text = "MissionContent".localizableString(loc: strLan)
        bottomTxtLbl.text = ""
    }
   

    override func viewDidLoad() {
        super.viewDidLoad()

        //SideMenuCode
        let left = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "sideMenuViewController") as? sideMenuViewController
        leftViewController = left
        leftViewWidth = view.frame.size.width - 110
        leftViewPresentationStyle = .slideAbove
        
        //TapGestureCode
        let mytapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(myTapAction))
        mytapGestureRecognizer.numberOfTapsRequired = 1
        self.AlphaView.addGestureRecognizer(mytapGestureRecognizer)
        mytapGestureRecognizer.delegate = self as UIGestureRecognizerDelegate
        
        //Left & Right SwipeCode
        let SwipeLeft = UISwipeGestureRecognizer(target: self, action: #selector(MySwipeLeft))
        SwipeLeft.direction = UISwipeGestureRecognizer.Direction.left
        self.view.addGestureRecognizer(SwipeLeft)
        SwipeLeft.delegate = self
        let SwipeRight = UISwipeGestureRecognizer(target: self, action: #selector(MySwipeRight))
        SwipeRight.direction = UISwipeGestureRecognizer.Direction.right
        self.view.addGestureRecognizer(SwipeRight)
        SwipeRight.delegate = self

    }
    @objc func myTapAction(recognizer: UITapGestureRecognizer)
    {
        hideLeftView(animated: true, completionHandler: nil)
        AlphaView.isHidden = true
        
    }
    @objc func MySwipeLeft(recognizer: UITapGestureRecognizer)
    {
        hideLeftView(animated: true, completionHandler: nil)
        AlphaView.isHidden = true
    }
    @objc func MySwipeRight(recognizer: UITapGestureRecognizer)
    {
        AlphaView.isHidden = false
        showLeftView(animated: true, completionHandler: nil)
        
    }
    @IBAction func ClickOnSideMenuBtn(_ sender: UIBarButtonItem)
          {
              if isLeftViewShowing
              {
                  hideLeftView(animated: true, completionHandler: nil)
                  AlphaView.isHidden = true
              }
              else
              {
                  AlphaView.isHidden = false
                  showLeftView(animated: true, completionHandler: nil)
              }
          }
    @IBAction func ClickOnEditProfileBtn(_ sender: UIBarButtonItem)
    {
        
        let lang_code = UserDefaults.standard.value(forKey: "lang_code")as? String
        if lang_code == "ar" {
            if #available(iOS 13.0, *) {
                let vc = self.storyboard?.instantiateViewController(identifier: "RegViewControllerAr")as! RegViewControllerAr
                self.navigationController?.pushViewController(vc, animated: true)

            } else {
                let vc = self.storyboard?.instantiateViewController(withIdentifier: "RegViewControllerAr")as! RegViewControllerAr
                self.navigationController?.pushViewController(vc, animated: true)
                
            }
        }else{
            if #available(iOS 13.0, *) {
                let vc = self.storyboard?.instantiateViewController(identifier: "RegViewController")as! RegViewController
                self.navigationController?.pushViewController(vc, animated: true)

            } else {
                let vc = self.storyboard?.instantiateViewController(withIdentifier: "RegViewController")as! RegViewController
                self.navigationController?.pushViewController(vc, animated: true)
                
            }
        }
       
    }
}
