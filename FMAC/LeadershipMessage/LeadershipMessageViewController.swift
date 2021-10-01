//
//  LeadershipMessageViewController.swift
//  FMAC
//
//  Created by MicroExcel on 3/16/21.
//  Copyright © 2021 Fujairah. All rights reserved.
//

import UIKit
import LGSideMenuController
import LGSideMenuController.LGSideMenuController
import LGSideMenuController.UIViewController_LGSideMenuController
import Alamofire
import SwiftyJSON
import MBProgressHUD

class LeadershipMessageViewController: LGSideMenuController,UIGestureRecognizerDelegate {
    
    var LeadershipMessageModelDetails : [LeadershipModel] = []

    @IBOutlet weak var AlphaView: UIView!
    @IBOutlet var TBV: UITableView!
    var txtArray = [String]()

    var DecodedUrlPaths = [String]()

    var DetailtxtArray = [String]()
   

    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.navigationBar.tintColor = .white

        hideLeftView(animated: false, completionHandler: nil)
        txtArray.removeAll()
        DetailtxtArray.removeAll()

        self.AlphaView.isHidden = true
        let lang_code = UserDefaults.standard.value(forKey: "lang_code")as? String
        if lang_code == "ar" {
            self.langChange(strLan: "ar")
            self.TBV.reloadData()
        }else{
            self.langChange(strLan: "en")
            self.TBV.reloadData()
        }
    }
    func langChange(strLan : String)
    {
        self.title = "LeadershipMessage".localizableString(loc: strLan)
        txtArray.append("LeadershipMsg".localizableString(loc: strLan))
        txtArray.append("LeadershipMsg1".localizableString(loc: strLan))
        txtArray.append("LeadershipMsg2".localizableString(loc: strLan))
        
        DetailtxtArray.append("LeadershipMsgDetailed".localizableString(loc: strLan))
        DetailtxtArray.append("LeadershipMsgDetailed1".localizableString(loc: strLan))
        DetailtxtArray.append("LeadershipMsgDetailed2".localizableString(loc: strLan))
        GetLeaderShipMsgs()

    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.TBV.register(UINib.init(nibName: "LeadershipmsgTableViewCell", bundle: nil), forCellReuseIdentifier: "LeadershipmsgTableViewCell")
        TBV.rowHeight = UITableView.automaticDimension
        TBV.estimatedRowHeight =  UITableView.automaticDimension
        TBV.tableFooterView = UIView(frame: .zero)
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
    

    func GetLeaderShipMsgs()
    {
        DispatchQueue.main.async {
            MBProgressHUD.showAdded(to: self.view, animated: true)
        }
        LeadershipMessageModelDetails.removeAll()
        let urlString = URL(string:MyStrings().LeadershipMessage_API)!
        print(urlString)
        let networkProcessor = NetworkProcessor(url: urlString)
        networkProcessor.downloadJSONFromURL { (passdata) in
            DispatchQueue.main.async {
                MBProgressHUD.hide(for: self.view, animated: true)
            }
            let json1 = JSON(passdata)
            let d = json1["d"]
            let json = d["results"]
            print("Ldsjson: \(json)")
            for (index,subJson):(String, JSON) in json {
                print(index)
                print(subJson)
                let details = LeadershipModel.init(json: subJson)
                self.LeadershipMessageModelDetails.append(details)
                let AttachmentFiles = subJson["AttachmentFiles"]
                let results = AttachmentFiles["results"]
                for (index1,subJson1):(String, JSON) in results {
                    let ServerRelativePath = subJson1["ServerRelativePath"]
                    let DecodedUrl = ServerRelativePath["DecodedUrl"].stringValue
                    self.DecodedUrlPaths.append(DecodedUrl)
                    break
                }
            }
            print("count is\(self.LeadershipMessageModelDetails.count)")
            DispatchQueue.main.async {
                self.TBV.dataSource = self
                self.TBV.delegate = self
                self.TBV.reloadData()
            }
        }
        
        
    }
   

}
extension LeadershipMessageViewController: UITableViewDataSource,UITableViewDelegate {
    
    func numberOfSections(in tableView: UITableView) -> Int
    {
        if LeadershipMessageModelDetails.count == 0 {
            return 0
        }else{
            return LeadershipMessageModelDetails.count
        }
        
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
        
        let cell = self.TBV.dequeueReusableCell(withIdentifier: "LeadershipmsgTableViewCell", for: indexPath)as! LeadershipmsgTableViewCell
        
        cell.LdrshpImgView.layer.masksToBounds = true
        cell.LdrshpImgView.layer.cornerRadius = cell.LdrshpImgView.frame.height/2
        let lang_code = UserDefaults.standard.value(forKey: "lang_code")as? String
        if lang_code == "ar" {
            cell.LdrshpContentLbl.textAlignment = .right
            cell.LdrshpDetailContentLbl.textAlignment = .right
            cell.LdrshpContentLbl.text = self.LeadershipMessageModelDetails[indexPath.section].TitleAr
            cell.LdrshpDetailContentLbl.text = self.LeadershipMessageModelDetails[indexPath.section].DescriptionAr

        }else{
            if indexPath.section == 0 || indexPath.section == 1 {
                cell.LdrshpDetailContentLbl.textAlignment = .center
                cell.LdrshpContentLbl.textAlignment = .center
                cell.LdrshpContentLbl.lineBreakMode = .byWordWrapping
            }else{
                cell.LdrshpContentLbl.textAlignment = .center
                cell.LdrshpContentLbl.lineBreakMode = .byWordWrapping
                cell.LdrshpDetailContentLbl.textAlignment = .left
            }
            print("title data\(self.LeadershipMessageModelDetails[indexPath.section].Title)")
            print("Description data\(self.LeadershipMessageModelDetails[indexPath.section].Description)")
            
            
            cell.LdrshpContentLbl.text = self.LeadershipMessageModelDetails[indexPath.section].Title
            cell.LdrshpDetailContentLbl.text = self.LeadershipMessageModelDetails[indexPath.section].Description

        }
        let imgTxt = self.DecodedUrlPaths[indexPath.section]
        print("imgTxt url \(imgTxt)")
        let combine = MyStrings().BASEURL1 + imgTxt
        print("combine url \(combine)")
        let urlString = combine.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)
        if let urls = URL(string: urlString!)
        {
            DispatchQueue.main.async {
                cell.LdrshpImgView.kf.indicatorType = .activity
                cell.LdrshpImgView.kf.setImage(with: urls, placeholder: UIImage(named: "download1"), options: nil, progressBlock: nil, completionHandler: nil)
            }

        }else{
            
        }
        
        
        
        

        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        
            return 20
        
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
