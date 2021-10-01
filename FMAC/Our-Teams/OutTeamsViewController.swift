//
//  OutTeamsViewController.swift
//  FMAC
//
//  Created by MicroExcel on 3/22/21.
//  Copyright © 2021 Fujairah. All rights reserved.
//

import UIKit
import LGSideMenuController
import LGSideMenuController.LGSideMenuController
import LGSideMenuController.UIViewController_LGSideMenuController
import Alamofire
import SwiftyJSON
import MBProgressHUD

class OutTeamsViewController: LGSideMenuController,UIGestureRecognizerDelegate {
    var OutTeamsModelDetails : [OurTeamModel] = []
    var globalJson = JSON()
    var SendDecodedUrlPaths = [String]()
    var DecodedUrlPaths = [String]()

    @IBOutlet var TBV: UITableView!
    var navTitleName : String = ""

    //255 82 98, 3,98,4 166 15 0, 255 165 6 1 10 159, 48 202 0, 44 44 255, 255 201 6, 254 29 0.
    //UIColor(red: 254/255.0, green: 29/255.0, blue: 0/255.0, alpha: 1.0)
    var listColors = [
        UIColor(red: 255/255.0, green: 82/255.0, blue: 98/255.0, alpha: 1.0),
        UIColor(red: 3/255.0, green: 98/255.0, blue: 4/255.0, alpha: 1.0),
        UIColor(red: 166/255.0, green: 15/255.0, blue: 0/255.0, alpha: 1.0),
        UIColor(red: 255/255.0, green: 165/255.0, blue: 6/255.0, alpha: 1.0),
        UIColor(red: 1/255.0, green: 10/255.0, blue: 159/255.0, alpha: 1.0),
        UIColor(red: 48/255.0, green: 202/255.0, blue: 0/255.0, alpha: 1.0),
        UIColor(red: 44/255.0, green: 44/255.0, blue: 255/255.0, alpha: 1.0),
        UIColor(red: 255/255.0, green: 201/255.0, blue: 6/255.0, alpha: 1.0),
        UIColor(red: 254/255.0, green: 29/255.0, blue: 0/255.0, alpha: 1.0)
    ]
    
    

    var imgArray = ["news1","news2","news3","news4","news5","news6","news7","news1","news2"]
    
    @IBOutlet weak var AlphaView: UIView!

    override func viewWillAppear(_ animated: Bool) {
        
        self.navigationController?.navigationBar.tintColor = .white

        hideLeftView(animated: false, completionHandler: nil)
        self.AlphaView.isHidden = true
        
        let lang_code = UserDefaults.standard.value(forKey: "lang_code")as? String
        if lang_code == "ar" {
            self.langChange(strLan: "ar")
            TBV.dataSource = self
            TBV.delegate = self
            TBV.reloadData()
        }else{
            self.langChange(strLan: "en")
            TBV.dataSource = self
            TBV.delegate = self
            TBV.reloadData()
        }
    }
    func langChange(strLan : String)
    {
        if navTitleName == ""
        {
            self.navigationItem.title = "Ourteam".localizableString(loc: strLan)
        }else{
            self.navigationItem.title = navTitleName
        }
        

    }
    func GetOurTeamDetails()
    {
        DispatchQueue.main.async {
            MBProgressHUD.showAdded(to: self.view, animated: true)
        }
        OutTeamsModelDetails.removeAll()
        DecodedUrlPaths.removeAll()
        let urlString = URL(string:MyStrings().OurTeam_API)!
        print(urlString)
        let networkProcessor = NetworkProcessor(url: urlString)
        networkProcessor.downloadJSONFromURL { (passdata) in
            DispatchQueue.main.async {
                MBProgressHUD.hide(for: self.view, animated: true)
            }
            let json1 = JSON(passdata)
            let d = json1["d"]
            self.globalJson = d["results"]
            for (index,subJson):(String, JSON) in self.globalJson {
                print(index)
                print(subJson)
                let details = OurTeamModel.init(json: subJson)
                self.OutTeamsModelDetails.append(details)
                let AttachmentFiles = subJson["AttachmentFiles"]
                let results = AttachmentFiles["results"]
                for (index1,subJson1):(String, JSON) in results {
                    let ServerRelativePath = subJson1["ServerRelativePath"]
                    let DecodedUrl = ServerRelativePath["DecodedUrl"].stringValue
                    self.DecodedUrlPaths.append(DecodedUrl)
                    break
                }
            }
            DispatchQueue.main.async {
                self.TBV.reloadData()
            }
        }
        
        
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        
        GetOurTeamDetails()
        // Do any additional setup after loading the view.
        self.TBV.register(UINib.init(nibName: "ourTeamsTableViewCell", bundle: nil), forCellReuseIdentifier: "ourTeamsTableViewCell")
        TBV.rowHeight = UITableView.automaticDimension
        TBV.estimatedRowHeight =  UITableView.automaticDimension
        TBV.tableFooterView = UIView(frame: .zero)
        TBV.backgroundColor = .black
        
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
extension OutTeamsViewController: UITableViewDataSource,UITableViewDelegate {
    
    func numberOfSections(in tableView: UITableView) -> Int
    {
        if OutTeamsModelDetails.count == 0
        {
            return 0
        }else{
            return OutTeamsModelDetails.count
        }
        
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
        
        let cell = self.TBV.dequeueReusableCell(withIdentifier: "ourTeamsTableViewCell", for: indexPath)as! ourTeamsTableViewCell
        
        let lang_code = UserDefaults.standard.value(forKey: "lang_code")as? String
        if lang_code == "ar" {
            cell.titleLbl.textAlignment = .right
            cell.detailedTxtLbl.textAlignment = .right
            cell.titleLbl.text = self.OutTeamsModelDetails[indexPath.section].TitleAr.withoutHtml
            cell.detailedTxtLbl.text = self.OutTeamsModelDetails[indexPath.section].DescriptionAr.withoutHtml.removeExtraSpaces()
//            cell.imgVw.image = UIImage.init(named: self.imgArray[indexPath.section])
        }else{
            cell.titleLbl.textAlignment = .center
            cell.detailedTxtLbl.textAlignment = .center
            cell.titleLbl.text = self.OutTeamsModelDetails[indexPath.section].Title.withoutHtml
            cell.detailedTxtLbl.text = self.OutTeamsModelDetails[indexPath.section].Description.withoutHtml.removeExtraSpaces()
//            cell.imgVw.image = UIImage.init(named: self.imgArray[indexPath.section])
        }
        let imgTxt = self.DecodedUrlPaths[indexPath.section]
        print("imgTxt url \(imgTxt)")
        let combine = MyStrings().BASEURL1 + imgTxt
        print("combine url \(combine)")
        let urlString = combine.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)
        if let urls = URL(string: urlString!)
        {
            DispatchQueue.main.async {
                cell.imgVw.kf.indicatorType = .activity
                cell.imgVw.kf.setImage(with: urls, placeholder: UIImage(named: "download1"), options: nil, progressBlock: nil, completionHandler: nil)
            }

        }else{
            
        }
        cell.bottomView.backgroundColor =  listColors[indexPath.section]
        cell.titleLbl.textColor = listColors[indexPath.section]



        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath)
    {
        self.SendDecodedUrlPaths.removeAll()
        if self.globalJson.count == 0 {
            
        }else{
        let dict = self.globalJson[indexPath.section]
        let AttachmentFiles = dict["AttachmentFiles"]
        let results = AttachmentFiles["results"]
        for (index1,subJson1):(String, JSON) in results {
            let ServerRelativePath = subJson1["ServerRelativePath"]
            let DecodedUrl = ServerRelativePath["DecodedUrl"].stringValue
            self.SendDecodedUrlPaths.append(DecodedUrl)
        }
        print("selfSendDecodedUrlPaths:\(self.SendDecodedUrlPaths)")
        }
        let lang_code = UserDefaults.standard.value(forKey: "lang_code")as? String
        if lang_code == "ar" {
            if #available(iOS 13.0, *) {
                let vc = self.storyboard?.instantiateViewController(identifier: "DeatiledViewController")as! DeatiledViewController
                vc.SendDecodedUrlPaths = self.SendDecodedUrlPaths
                vc.navTitle = self.OutTeamsModelDetails[indexPath.section].TitleAr.withoutHtml.removeExtraSpaces()
                vc.description1 = self.OutTeamsModelDetails[indexPath.section].DescriptionAr.withoutHtml.removeExtraSpaces()
                vc.Olympiad = self.OutTeamsModelDetails[indexPath.section].OlympiadAr.withoutHtml.removeExtraSpaces()
                vc.GameInFMAC = self.OutTeamsModelDetails[indexPath.section].GameInFMACAr.withoutHtml.removeExtraSpaces()
                vc.LocalAchievements = self.OutTeamsModelDetails[indexPath.section].LocalAchievementsAr.withoutHtml.removeExtraSpaces()
                vc.InternationalAchievements = self.OutTeamsModelDetails[indexPath.section].InternationalAchievementsAr.withoutHtml.removeExtraSpaces()
                vc.fromNav = "OurTeam"

                self.navigationController?.pushViewController(vc, animated: true)

            } else {
                let vc = self.storyboard?.instantiateViewController(withIdentifier: "DeatiledViewController")as! DeatiledViewController
                vc.SendDecodedUrlPaths = self.SendDecodedUrlPaths
                vc.navTitle = self.OutTeamsModelDetails[indexPath.section].TitleAr.withoutHtml.removeExtraSpaces()
                vc.description1 = self.OutTeamsModelDetails[indexPath.section].DescriptionAr.withoutHtml.removeExtraSpaces()
                vc.Olympiad = self.OutTeamsModelDetails[indexPath.section].OlympiadAr.withoutHtml.removeExtraSpaces()
                vc.GameInFMAC = self.OutTeamsModelDetails[indexPath.section].GameInFMACAr.withoutHtml.removeExtraSpaces()
                vc.LocalAchievements = self.OutTeamsModelDetails[indexPath.section].LocalAchievementsAr.withoutHtml.removeExtraSpaces()
                vc.InternationalAchievements = self.OutTeamsModelDetails[indexPath.section].InternationalAchievementsAr.withoutHtml.removeExtraSpaces()
                vc.fromNav = "OurTeam"

                self.navigationController?.pushViewController(vc, animated: true)
                
            }
            }else{
                if #available(iOS 13.0, *) {
                    let vc = self.storyboard?.instantiateViewController(identifier: "DeatiledViewController")as! DeatiledViewController
                    vc.SendDecodedUrlPaths = self.SendDecodedUrlPaths
                    vc.navTitle = self.OutTeamsModelDetails[indexPath.section].Title.withoutHtml.removeExtraSpaces()
                    vc.description1 = self.OutTeamsModelDetails[indexPath.section].Description.withoutHtml.removeExtraSpaces()
                    vc.Olympiad = self.OutTeamsModelDetails[indexPath.section].Olympiad.withoutHtml.removeExtraSpaces()
                    vc.GameInFMAC = self.OutTeamsModelDetails[indexPath.section].GameInFMAC.withoutHtml.removeExtraSpaces()
                    vc.LocalAchievements = self.OutTeamsModelDetails[indexPath.section].LocalAchievements.withoutHtml.removeExtraSpaces()
                    vc.InternationalAchievements = self.OutTeamsModelDetails[indexPath.section].InternationalAchievements.withoutHtml.removeExtraSpaces()
                    vc.fromNav = "OurTeam"

                    self.navigationController?.pushViewController(vc, animated: true)

                } else {
                    let vc = self.storyboard?.instantiateViewController(withIdentifier: "DeatiledViewController")as! DeatiledViewController
                    vc.SendDecodedUrlPaths = self.SendDecodedUrlPaths
                    vc.navTitle = self.OutTeamsModelDetails[indexPath.section].Title.withoutHtml.removeExtraSpaces()
                    vc.description1 = self.OutTeamsModelDetails[indexPath.section].Description.withoutHtml.removeExtraSpaces()
                    vc.Olympiad = self.OutTeamsModelDetails[indexPath.section].Olympiad.withoutHtml.removeExtraSpaces()
                    vc.GameInFMAC = self.OutTeamsModelDetails[indexPath.section].GameInFMAC.withoutHtml.removeExtraSpaces()
                    vc.LocalAchievements = self.OutTeamsModelDetails[indexPath.section].LocalAchievements.withoutHtml.removeExtraSpaces()
                    vc.InternationalAchievements = self.OutTeamsModelDetails[indexPath.section].InternationalAchievements.withoutHtml.removeExtraSpaces()
                    vc.fromNav = "OurTeam"

                    self.navigationController?.pushViewController(vc, animated: true)
                    
                }
                }
    }
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        
        if section == 0 {
            return 0
        }else{
            return 20
        }
        
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return self.TBV.frame.height/1.5
    }
    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView?
    {
        view.backgroundColor = .black
        let headerView = UIView(frame: CGRect(x: 0, y: 0, width: tableView.bounds.size.width, height: 20))
            headerView.backgroundColor = UIColor.black
        return headerView
    }

}
extension String {
    public var withoutHtml: String {
        guard let data = self.data(using: .utf8) else {
            return self
        }

        let options: [NSAttributedString.DocumentReadingOptionKey: Any] = [
            .documentType: NSAttributedString.DocumentType.html,
            .characterEncoding: String.Encoding.utf8.rawValue
        ]

        guard let attributedString = try? NSAttributedString(data: data, options: options, documentAttributes: nil) else {
            return self
        }

        return attributedString.string
    }

        func removeExtraSpaces() -> String {
            return self.replacingOccurrences(of: "[\\s\n]+", with: " ", options: .regularExpression, range: nil)
        }

    
}

