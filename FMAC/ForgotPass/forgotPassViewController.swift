//
//  forgotPassViewController.swift
//  FMAC
//
//  Created by MicroExcel on 1/8/21.
//  Copyright © 2021 Fujairah. All rights reserved.
//

import UIKit
import FSPagerView
import LGSideMenuController
import LGSideMenuController.LGSideMenuController
import LGSideMenuController.UIViewController_LGSideMenuController
import Alamofire
import SwiftyJSON
import MBProgressHUD
import DropDown
import Foundation

class forgotPassViewController: LGSideMenuController,UIGestureRecognizerDelegate,FSPagerViewDataSource,FSPagerViewDelegate {
    //
    var OutTeamsModelDetails : [OurTeamModel] = []
    var globalJson = JSON()
    var SendDecodedUrlPaths = [String]()
    var DecodedUrlPaths = [String]()
    
    
    @IBOutlet var popUpTitleLbl: UILabel!
    @IBOutlet var popUpDesLbl: UILabel!
    @IBOutlet var PopUpView: UIView!
    var txtArray = [String]()
    var NewdateArray = [String]()
    @IBOutlet weak var employeeNameTextField: UITextField!
    var GetIndexID = Int()

    @IBOutlet var loginBtn: UIButton!
    
//    var imgArray = ["karate7","karate3","karate6","karate9","karate4"]
    var imgArray = ["Taekwondo","ARCHERY","BOXING","FENCE","JIU-JITSU","JUDO","KARATE","TRIATHLON","WRESTLING"]
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
    @IBOutlet weak var AlphaView: UIView!

    @IBOutlet weak var pagerView: FSPagerView! {
        didSet {
            self.pagerView.register(FSPagerViewCell.self, forCellWithReuseIdentifier: "cell")
        }
    }
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        navigationController?.setNavigationBarHidden(false, animated: false)
    }
    @IBAction func ClickOnLoginBtn(_ sender: UIButton)
    {
        if #available(iOS 13.0, *) {
            let vc = self.storyboard?.instantiateViewController(identifier: "ViewController")as! ViewController
            self.navigationController?.pushViewController(vc, animated: true)

        } else {
            let vc = self.storyboard?.instantiateViewController(withIdentifier: "ViewController")as! ViewController
            self.navigationController?.pushViewController(vc, animated: true)
            
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        hideLeftView(animated: false, completionHandler: nil)
        self.tabBarController?.tabBar.isHidden = false
        navigationController?.setNavigationBarHidden(true, animated: false)
        self.AlphaView.isHidden = true
        self.txtArray.removeAll()
        self.NewdateArray.removeAll()

        let lang_code = UserDefaults.standard.value(forKey: "lang_code")as? String
        if lang_code == "ar" {
            
            self.langChange(strLan: "ar")
//            pagerView.dataSource = self
//            pagerView.delegate = self
            pagerView.reloadData()

        }else{
            self.langChange(strLan: "en")
//            pagerView.dataSource = self
//            pagerView.delegate = self
            pagerView.reloadData()
        }
    }
    func langChange(strLan : String)
    {
        loginBtn.setTitle("Login".localizableString(loc: strLan), for: .normal)
        
        txtArray.append("Taekwondo".localizableString(loc: strLan))
        txtArray.append("ARCHERY".localizableString(loc: strLan))
        txtArray.append("BOXING".localizableString(loc: strLan))
        txtArray.append("FENCE".localizableString(loc: strLan))
        txtArray.append("JIU-JITSU".localizableString(loc: strLan))
        txtArray.append("JUDO".localizableString(loc: strLan))
        txtArray.append("KARATE".localizableString(loc: strLan))
        txtArray.append("TRIATHLON".localizableString(loc: strLan))
        txtArray.append("WRESTLING".localizableString(loc: strLan))

        
        
        NewdateArray.append("TaekwondoShortInfo".localizableString(loc: strLan))
        NewdateArray.append("ArcheryShortInfo".localizableString(loc: strLan))
        NewdateArray.append("BoxingShortInfo".localizableString(loc: strLan))
        NewdateArray.append("FenceShortInfo".localizableString(loc: strLan))
        NewdateArray.append("JiuJitsuShortInfo".localizableString(loc: strLan))
        NewdateArray.append("JudoShortInfo".localizableString(loc: strLan))
        NewdateArray.append("KarateShortInfo".localizableString(loc: strLan))
        NewdateArray.append("TriathlonShortInfo".localizableString(loc: strLan))
        NewdateArray.append("WRESTLINGShortInfo".localizableString(loc: strLan))

        FormDigestValue()
       
    }
    
    
    @IBAction func ClickOnSideMenuBtn(_ sender: UIButton)
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
    override func viewDidLoad() {
        super.viewDidLoad()
        GetOurTeamDetails()
        UserDefaults.standard.setValue(self.employeeNameTextField.text, forKey: "UserName")
        UserDefaults.standard.setValue("FmaC@#2021", forKey: "Password")
        UserDefaults.standard.synchronize()

//        let logo = UIImage(named: "FMAC")
//        let imageView = UIImageView(image:logo)
//        self.navigationItem.titleView = imageView
        
        PopUpView.roundCorners([ .bottomRight, .topLeft], radius: 80)
        PopUpView.layer.borderWidth = 5
        PopUpView.layer.borderColor = UIColor.black.cgColor
        

        
        pagerView.dataSource = self
        pagerView.delegate = self
        pagerView.register(FSPagerViewCell.self, forCellWithReuseIdentifier: "cell")
        pagerView.transformer = FSPagerViewTransformer(type: .linear)
//        let transform = CGAffineTransform(scaleX: 0.6, y: 0.75)
//        print(transform.a)
//        print(transform.b)
//        print(transform.c)
//        print(transform.d)
//        self.pagerView.itemSize = self.pagerView.frame.size.applying(transform)
//        self.pagerView.decelerationDistance = FSPagerView.automaticDistance
        pagerView.automaticSlidingInterval = 3.0

        
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
    func FormDigestValue()
    {
        let urlString = URL(string:MyStrings().BASEURL1 + "_api/contextinfo")!
        print(urlString)
        let networkProcessor = NetworkProcessor(url: urlString)
        networkProcessor.downloadJSONFromURL1 { (passdata) in
            let json = JSON(passdata)
            print("Digestjson: \(json)")
            let d = json["d"]
            let GetContextWebInformation = d["GetContextWebInformation"]
            let FormDigestValue = GetContextWebInformation["FormDigestValue"].stringValue
//            let fullNameArr = FormDigestValue.components(separatedBy: ",")
//            let firstName: String = fullNameArr[0]
            print("FormDigestValue: \(FormDigestValue)")
            UserDefaults.standard.set(FormDigestValue, forKey: "FormDigestValue")
            UserDefaults.standard.synchronize()

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
//                self.TBV.reloadData()
            }
        }
        
        
    }
    
    
//        let url = "https://fmac.fujairah.ae/_api/web/lists/GetByTitle(%27Branches%27)/items"
//                let manager = NetworkConnection.sharedManager.manager
//
//                func updateUser(_ token: String, tokenType: String, expiresIn: Int, params: [String : String]) {
//                    let headers = NetworkConnection.addAuthorizationHeader(token, tokenType: tokenType)
//
//                    manager?.request(url, method: .put, parameters: params, encoding: JSONEncoding.default, headers: headers).responseJSON { response in
//                        print(response.description)
//                        print(response.debugDescription)
//                        print(response.request)  // original URL request
//                        print(response.response) // URL response
//                        print(response.data)     // server data
//                        print(response.result)   // result of response serialization
//                    }
//                }
    
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
    
    public func numberOfItems(in pagerView: FSPagerView) -> Int {
        print("txtArrayCount : \(txtArray.count)")
        return txtArray.count
    }
        
    public func pagerView(_ pagerView: FSPagerView, cellForItemAt index: Int) -> FSPagerViewCell
    {
        
        let cell = pagerView.dequeueReusableCell(withReuseIdentifier: "cell", at: index)
        print("Index : \(index)")
        self.GetIndexID = index
//        print("IndexVal : \(self.txtArray[index])")
        popUpTitleLbl.font = UIFont(name: "Oswald-Bold", size: 24)
        popUpDesLbl.font = UIFont(name: "Oswald-Regular", size: 15)
        popUpTitleLbl.text = self.txtArray[index]
        popUpDesLbl.text = self.NewdateArray[index]
        cell.imageView?.layer.cornerRadius = 14
        cell.imageView?.layer.borderWidth = 0.5
        cell.imageView?.layer.borderColor = UIColor.black.cgColor
        cell.imageView?.clipsToBounds = true
        cell.imageView?.image = UIImage.init(named: self.imgArray[index])
        cell.imageView?.sizeToFit()


        self.PopUpView.backgroundColor = listColors[index]
        return cell
    }
    func pagerView(_ pagerView: FSPagerView, didSelectItemAt index: Int) {
        
    }
   
    @IBAction func clickOnForwardBtn(_ sender: UIButton)
    {
        self.SendDecodedUrlPaths.removeAll()
        if self.globalJson.count == 0 {
            
        }else{
        let dict = self.globalJson[self.GetIndexID]
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
                vc.navTitle = self.OutTeamsModelDetails[self.GetIndexID].TitleAr.withoutHtml.removeExtraSpaces()
                vc.description1 = self.OutTeamsModelDetails[self.GetIndexID].DescriptionAr.withoutHtml.removeExtraSpaces()
                vc.Olympiad = self.OutTeamsModelDetails[self.GetIndexID].OlympiadAr.withoutHtml.removeExtraSpaces()
                vc.GameInFMAC = self.OutTeamsModelDetails[self.GetIndexID].GameInFMACAr.withoutHtml.removeExtraSpaces()
                vc.LocalAchievements = self.OutTeamsModelDetails[self.GetIndexID].LocalAchievementsAr.withoutHtml.removeExtraSpaces()
                vc.InternationalAchievements = self.OutTeamsModelDetails[self.GetIndexID].InternationalAchievementsAr.withoutHtml.removeExtraSpaces()
                vc.fromNav = "OurTeam"

                self.navigationController?.pushViewController(vc, animated: true)

            } else {
                let vc = self.storyboard?.instantiateViewController(withIdentifier: "DeatiledViewController")as! DeatiledViewController
                vc.SendDecodedUrlPaths = self.SendDecodedUrlPaths
                vc.navTitle = self.OutTeamsModelDetails[self.GetIndexID].TitleAr.withoutHtml.removeExtraSpaces()
                vc.description1 = self.OutTeamsModelDetails[self.GetIndexID].DescriptionAr.withoutHtml.removeExtraSpaces()
                vc.Olympiad = self.OutTeamsModelDetails[self.GetIndexID].OlympiadAr.withoutHtml.removeExtraSpaces()
                vc.GameInFMAC = self.OutTeamsModelDetails[self.GetIndexID].GameInFMACAr.withoutHtml.removeExtraSpaces()
                vc.LocalAchievements = self.OutTeamsModelDetails[self.GetIndexID].LocalAchievementsAr.withoutHtml.removeExtraSpaces()
                vc.InternationalAchievements = self.OutTeamsModelDetails[self.GetIndexID].InternationalAchievementsAr.withoutHtml.removeExtraSpaces()
                vc.fromNav = "OurTeam"

                self.navigationController?.pushViewController(vc, animated: true)
                
            }
            }else{
                if #available(iOS 13.0, *) {
                    let vc = self.storyboard?.instantiateViewController(identifier: "DeatiledViewController")as! DeatiledViewController
                    vc.SendDecodedUrlPaths = self.SendDecodedUrlPaths
                    vc.navTitle = self.OutTeamsModelDetails[self.GetIndexID].Title.withoutHtml.removeExtraSpaces()
                    vc.description1 = self.OutTeamsModelDetails[self.GetIndexID].Description.withoutHtml.removeExtraSpaces()
                    vc.Olympiad = self.OutTeamsModelDetails[self.GetIndexID].Olympiad.withoutHtml.removeExtraSpaces()
                    vc.GameInFMAC = self.OutTeamsModelDetails[self.GetIndexID].GameInFMAC.withoutHtml.removeExtraSpaces()
                    vc.LocalAchievements = self.OutTeamsModelDetails[self.GetIndexID].LocalAchievements.withoutHtml.removeExtraSpaces()
                    vc.InternationalAchievements = self.OutTeamsModelDetails[self.GetIndexID].InternationalAchievements.withoutHtml.removeExtraSpaces()
                    vc.fromNav = "OurTeam"

                    self.navigationController?.pushViewController(vc, animated: true)

                } else {
                    let vc = self.storyboard?.instantiateViewController(withIdentifier: "DeatiledViewController")as! DeatiledViewController
                    vc.SendDecodedUrlPaths = self.SendDecodedUrlPaths
                    vc.navTitle = self.OutTeamsModelDetails[self.GetIndexID].Title.withoutHtml.removeExtraSpaces()
                    vc.description1 = self.OutTeamsModelDetails[self.GetIndexID].Description.withoutHtml.removeExtraSpaces()
                    vc.Olympiad = self.OutTeamsModelDetails[self.GetIndexID].Olympiad.withoutHtml.removeExtraSpaces()
                    vc.GameInFMAC = self.OutTeamsModelDetails[self.GetIndexID].GameInFMAC.withoutHtml.removeExtraSpaces()
                    vc.LocalAchievements = self.OutTeamsModelDetails[self.GetIndexID].LocalAchievements.withoutHtml.removeExtraSpaces()
                    vc.InternationalAchievements = self.OutTeamsModelDetails[self.GetIndexID].InternationalAchievements.withoutHtml.removeExtraSpaces()
                    vc.fromNav = "OurTeam"

                    self.navigationController?.pushViewController(vc, animated: true)
                    
                }
                }
    }
    

}
extension String
{
    func localizableString(loc: String) -> String {
        let path = Bundle.main.path(forResource: loc, ofType: "lproj")
        let bundle = Bundle(path: path!)
        return NSLocalizedString(self, tableName: nil, bundle: bundle!, value: "", comment: "")
    }
}
