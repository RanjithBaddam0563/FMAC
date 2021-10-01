//
//  ContactUsViewController.swift
//  FMAC
//
//  Created by MicroExcel on 5/1/21.
//  Copyright © 2021 Fujairah. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON
import MBProgressHUD
import LGSideMenuController
import LGSideMenuController.LGSideMenuController
import LGSideMenuController.UIViewController_LGSideMenuController
import MapKit

class ContactUsViewController: LGSideMenuController,UIGestureRecognizerDelegate {
    var ContactUsModelDetails : [ContactUsModel] = []
    @IBOutlet var TBV: UITableView!
    @IBOutlet weak var AlphaView: UIView!

    @IBOutlet var BranchLbl1: UILabel!
    @IBOutlet var BranchLbl: UILabel!
    @IBOutlet var headerItemOrderLbl: UILabel!
    @IBOutlet var headerIconClassLbl: UILabel!
    @IBOutlet var headerValueLbl: UILabel!
    @IBOutlet var headerTitleLbl: UILabel!
    @IBOutlet var map1: MKMapView!
    @IBOutlet var map: MKMapView!

    func demoMap() {
        var c = CLLocationCoordinate2D()
        c.latitude = 45.733333
        c.longitude = 9.133333
        
        let a = MKPointAnnotation()
        a.coordinate = c
        a.title = "Al Fujairah Branch"
        map.addAnnotation(a)
    }
    func demoMap1() {
        var c = CLLocationCoordinate2D()
        c.latitude = 45.733333
        c.longitude = 9.133333
        
        let a = MKPointAnnotation()
        a.coordinate = c
        a.title = "Dibba Branch"
        map1.addAnnotation(a)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        demoMap()
        demoMap1()
        
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
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.navigationBar.tintColor = .white

        hideLeftView(animated: false, completionHandler: nil)
        self.AlphaView.isHidden = true
        
        GetContactUsDetails()
        let lang_code = UserDefaults.standard.value(forKey: "lang_code")as? String
        if lang_code == "ar" {
            
            
            self.langChange(strLan: "ar")
            self.headerTitleLbl.text = "Item Order"
            self.headerValueLbl.text = "Icon Class"
            self.headerIconClassLbl.text = "Value"
            self.headerItemOrderLbl.text = "Title"
            self.TBV.register(UINib.init(nibName: "ContactUsArTableViewCell", bundle: nil), forCellReuseIdentifier: "ContactUsArTableViewCell")
            TBV.dataSource = self
            TBV.delegate = self
            TBV.reloadData()
           


        }else{
            self.langChange(strLan: "en")
            self.headerTitleLbl.text = "Title"
            self.headerValueLbl.text = "Value"
            self.headerIconClassLbl.text = "Icon Class"
            self.headerItemOrderLbl.text = "Item Order"
            self.TBV.register(UINib.init(nibName: "ContactUsTableViewCell", bundle: nil), forCellReuseIdentifier: "ContactUsTableViewCell")
            TBV.dataSource = self
            TBV.delegate = self
            TBV.reloadData()
        }
    }
    func langChange(strLan : String)
    {
        self.navigationItem.title = "Contactus".localizableString(loc: strLan)
        self.BranchLbl.text  = "AlFujairahBranch".localizableString(loc: strLan)
        self.BranchLbl1.text  = "DibbaBranch".localizableString(loc: strLan)

    }
    
    func GetContactUsDetails()
    {
        DispatchQueue.main.async {
            MBProgressHUD.showAdded(to: self.view, animated: true)
        }
        ContactUsModelDetails.removeAll()
        let urlString = URL(string:MyStrings().ContactUs_API)!
        print(urlString)
        let networkProcessor = NetworkProcessor(url: urlString)
        networkProcessor.downloadJSONFromURL { (passdata) in
            DispatchQueue.main.async {
                MBProgressHUD.hide(for: self.view, animated: true)
            }
            let json1 = JSON(passdata)
            let d = json1["d"]
            let json = d["results"]
            print(json)
            for (index,subJson):(String, JSON) in json {
                print(index)
                print(subJson)
                let details = ContactUsModel.init(json: subJson)
                self.ContactUsModelDetails.append(details)
            }
            DispatchQueue.main.async {
                self.TBV.reloadData()
            }
        }
        
        
    }
}
extension ContactUsViewController: UITableViewDataSource,UITableViewDelegate {
    
    func numberOfSections(in tableView: UITableView) -> Int
    {
        if ContactUsModelDetails.count == 0
        {
            return 0
        }else{
        return ContactUsModelDetails.count
        }
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
        
        let lang_code = UserDefaults.standard.value(forKey: "lang_code")as? String
        if lang_code == "ar" {
            let cell = self.TBV.dequeueReusableCell(withIdentifier: "ContactUsArTableViewCell", for: indexPath)as! ContactUsArTableViewCell
            cell.titleLbl.text = self.ContactUsModelDetails[indexPath.section].TitleAr
            cell.valueLbl.text = self.ContactUsModelDetails[indexPath.section].Value
            cell.iconClassLbl.text = self.ContactUsModelDetails[indexPath.section].IconClass
            cell.itemOrderLbl.text = String(self.ContactUsModelDetails[indexPath.section].ID)

            
            return cell
        }else{
            let cell = self.TBV.dequeueReusableCell(withIdentifier: "ContactUsTableViewCell", for: indexPath)as! ContactUsTableViewCell
            cell.titleLbl.text = self.ContactUsModelDetails[indexPath.section].Title
            cell.valueLbl.text = self.ContactUsModelDetails[indexPath.section].Value
            cell.iconClassLbl.text = self.ContactUsModelDetails[indexPath.section].IconClass
            cell.itemOrderLbl.text = String(self.ContactUsModelDetails[indexPath.section].ID)
            return cell
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath)
    {
        
    }
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        
        if section == 0 {
            return 5
        }else{
            return 12
        }
        
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView?
    {
        view.backgroundColor = .black
        let headerView = UIView(frame: CGRect(x: 0, y: 0, width: tableView.bounds.size.width, height: 20))
            headerView.backgroundColor = UIColor.clear
        return headerView
    }

}
