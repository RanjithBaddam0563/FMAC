//
//  NewsViewController.swift
//  FMAC
//
//  Created by MicroExcel on 3/17/21.
//  Copyright © 2021 Fujairah. All rights reserved.
//

import UIKit
import LGSideMenuController
import LGSideMenuController.LGSideMenuController
import LGSideMenuController.UIViewController_LGSideMenuController
import Alamofire
import SwiftyJSON
import MBProgressHUD

class NewsViewController: LGSideMenuController,UIGestureRecognizerDelegate {
    var NewsModelDetails : [NewsModel] = []

    var NewsModelFileDetails : [NewsModelFile] = []
    
    @IBOutlet weak var AlphaView: UIView!
    var txtArray = [String]()
    var NewdateArray = [String]()
    var navTitleName : String = ""
    var NewApiNamee : String = ""
    var DecodedUrlPaths = [String]()
    var SendDecodedUrlPaths = [String]()

    var globalJson = JSON()
    var IndexID = Int()


    @IBOutlet var searchTF: UITextField!
    @IBOutlet var TBV: UITableView!
    var imgArray = ["news1","news2","news3","news4","news5","news6","news7"]
   
    
    override func viewWillAppear(_ animated: Bool) {
        print("navTitleName is : \(navTitleName)")
        GetLocalNewsDetails()
        self.title = navTitleName

        self.navigationController?.navigationBar.tintColor = .white

        hideLeftView(animated: false, completionHandler: nil)
        self.AlphaView.isHidden = true
        txtArray.removeAll()
        NewdateArray.removeAll()

        searchTF.resignFirstResponder()
        let lang_code = UserDefaults.standard.value(forKey: "lang_code")as? String
        if lang_code == "ar" {
            self.langChange(strLan: "ar")
            searchTF.textAlignment = .right
            searchTF.setRightPaddingPoints(10)
            self.TBV.reloadData()
        }else{
            self.langChange(strLan: "en")
            searchTF.textAlignment = .left
            searchTF.setLeftPaddingPoints(10)
            self.TBV.reloadData()

        }
    }
    func langChange(strLan : String)
    {
        txtArray.append("Newtitle".localizableString(loc: strLan))
        txtArray.append("Newtitle1".localizableString(loc: strLan))
        txtArray.append("Newtitle2".localizableString(loc: strLan))
        txtArray.append("Newtitle3".localizableString(loc: strLan))
        txtArray.append("Newtitle4".localizableString(loc: strLan))
        txtArray.append("Newtitle5".localizableString(loc: strLan))
        txtArray.append("Newtitle6".localizableString(loc: strLan))


        NewdateArray.append("NewsDate".localizableString(loc: strLan))
        NewdateArray.append("NewsDate".localizableString(loc: strLan))
        NewdateArray.append("NewsDate".localizableString(loc: strLan))
        NewdateArray.append("NewsDate".localizableString(loc: strLan))
        NewdateArray.append("NewsDate".localizableString(loc: strLan))
        NewdateArray.append("NewsDate".localizableString(loc: strLan))
        NewdateArray.append("NewsDate".localizableString(loc: strLan))
        
        searchTF.attributedPlaceholder = NSAttributedString(string: "searchnews".localizableString(loc: strLan),
                                                            attributes: [NSAttributedString.Key.foregroundColor: UIColor.white.withAlphaComponent(0.4)])
        


    }
    func GetLocalNewsDetails()
    {
        DispatchQueue.main.async {
            MBProgressHUD.showAdded(to: self.view, animated: true)
        }
        if IndexID == 0 {
            self.NewApiNamee = MyStrings().News_API
        }else{
            self.NewApiNamee = MyStrings().Internation_News_API
        }
        NewsModelDetails.removeAll()
        DecodedUrlPaths.removeAll()
        let urlString = URL(string:self.NewApiNamee)!
        print(urlString)
        let networkProcessor = NetworkProcessor(url: urlString)
        networkProcessor.downloadJSONFromURL { (passdata) in
            DispatchQueue.main.async {
                MBProgressHUD.hide(for: self.view, animated: true)
            }
            let json1 = JSON(passdata)
            let d = json1["d"]
            self.globalJson = d["results"]
            print("Newsjson1: \(self.globalJson)")
            for (index,subJson):(String, JSON) in self.globalJson {
                print(index)
                print(subJson)
                let details = NewsModel.init(json: subJson)
                self.NewsModelDetails.append(details)
                let AttachmentFiles = subJson["AttachmentFiles"]
                let results = AttachmentFiles["results"]
                for (index1,subJson1):(String, JSON) in results {
                    let ServerRelativePath = subJson1["ServerRelativePath"]
                    let details = NewsModelFile.init(json: ServerRelativePath)
                    self.NewsModelFileDetails.append(details)
                }
                for (index1,subJson1):(String, JSON) in results {
                    let ServerRelativePath = subJson1["ServerRelativePath"]
                    let DecodedUrl = ServerRelativePath["DecodedUrl"].stringValue
                    self.DecodedUrlPaths.append(DecodedUrl)
                    break
                }
            }
            print("NewsModelFileDetails: \(self.NewsModelFileDetails)")
            print("DecodedUrlPathsArray: \(self.DecodedUrlPaths)")
            DispatchQueue.main.async {
                self.TBV.reloadData()
            }
        }
        
        
    }
    override func viewDidLoad() {
        super.viewDidLoad()

        searchTF.setLeftPaddingPoints(10)
        // Do any additional setup after loading the view.
        let lang_code = UserDefaults.standard.value(forKey: "lang_code")as? String
        if lang_code == "ar" {
            self.TBV.register(UINib.init(nibName: "NewsTableViewCellAr", bundle: nil), forCellReuseIdentifier: "NewsTableViewCellAr")
        }else{
        self.TBV.register(UINib.init(nibName: "NewsTableViewCell", bundle: nil), forCellReuseIdentifier: "NewsTableViewCell")
        }
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
 

}
extension NewsViewController: UITableViewDataSource,UITableViewDelegate {
    
    func numberOfSections(in tableView: UITableView) -> Int
    {
        if NewsModelDetails.count == 0
        {
            return 0
        }else{
            return NewsModelDetails.count
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
            let cell = self.TBV.dequeueReusableCell(withIdentifier: "NewsTableViewCellAr", for: indexPath)as! NewsTableViewCellAr
            
            cell.newsContentLbl.text = self.NewsModelDetails[indexPath.section].TitleAr
            cell.newsImg.image = UIImage.init(named: self.imgArray[indexPath.section])
            let PublishDate = self.NewsModelDetails[indexPath.section].PublishDate
            let formatter = DateFormatter()
            formatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZ"
            let yourDate = formatter.date(from: PublishDate)
            formatter.dateFormat = "MMM d, yyyy"
            cell.newsDateLbl.text = formatter.string(from: yourDate!)
            let imgTxt = self.DecodedUrlPaths[indexPath.section]
            print("imgTxt url \(imgTxt)")
           
            let combine = MyStrings().BASEURL1 + imgTxt
            print("combine url \(combine)")
            let urlString = combine.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)
            if let urls = URL(string: urlString!)
            {
                DispatchQueue.main.async {
                    cell.newsImg.kf.indicatorType = .activity
                    cell.newsImg.kf.setImage(with: urls, placeholder: UIImage(named: "download1"), options: nil, progressBlock: nil, completionHandler: nil)
                }

            }else{
                
            }
            return cell
        }else{
        let cell = self.TBV.dequeueReusableCell(withIdentifier: "NewsTableViewCell", for: indexPath)as! NewsTableViewCell
            cell.newsContentLbl.text = self.NewsModelDetails[indexPath.section].Title
            cell.newsImg.image = UIImage.init(named: self.imgArray[indexPath.section])
            let PublishDate = self.NewsModelDetails[indexPath.section].PublishDate
            let formatter = DateFormatter()
            formatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZ"
            let yourDate = formatter.date(from: PublishDate)
            formatter.dateFormat = "MMM d, yyyy"
            cell.newsDateLbl.text = formatter.string(from: yourDate!)
            let imgTxt = self.DecodedUrlPaths[indexPath.section]
            print("imgTxt url \(imgTxt)")
           
            let combine = MyStrings().BASEURL1 + imgTxt
            print("combine url \(combine)")
            let urlString = combine.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)
            if let urls = URL(string: urlString!)
            {
                DispatchQueue.main.async {
                    cell.newsImg.kf.indicatorType = .activity
                    cell.newsImg.kf.setImage(with: urls, placeholder: UIImage(named: "download1"), options: nil, progressBlock: nil, completionHandler: nil)
                }

            }else{
                
            }
            return cell
        }
        
        

//        cell.LdrshpImgView.image = UIImage.init(named: self.imgArray[indexPath.section])
//        cell.LdrshpContentLbl.text = self.txtArray[indexPath.section]
//        cell.LdrshpDetailContentLbl.text = self.DetailtxtArray[indexPath.section]

       
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
            let vc = self.storyboard?.instantiateViewController(identifier: "DetailedNewsViewController")as! DetailedNewsViewController
            vc.newsTitle = self.NewsModelDetails[indexPath.section].TitleAr
            let PublishDate = self.NewsModelDetails[indexPath.section].PublishDate
            let formatter = DateFormatter()
            formatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZ"
            let yourDate = formatter.date(from: PublishDate)
            formatter.dateFormat = "MMM d, yyyy"
            let dateStr = formatter.string(from: yourDate!)
            vc.newsDateTitle = dateStr
            vc.DescriptionText = self.NewsModelDetails[indexPath.section].DescriptionAr
            vc.SendDecodedUrlPaths = self.SendDecodedUrlPaths
            self.navigationController?.pushViewController(vc, animated: true)

        } else {
            let vc = self.storyboard?.instantiateViewController(withIdentifier: "DetailedNewsViewController")as! DetailedNewsViewController
            vc.newsTitle = self.NewsModelDetails[indexPath.section].TitleAr
            let PublishDate = self.NewsModelDetails[indexPath.section].PublishDate
            let formatter = DateFormatter()
            formatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZ"
            let yourDate = formatter.date(from: PublishDate)
            formatter.dateFormat = "MMM d, yyyy"
            let dateStr = formatter.string(from: yourDate!)
            vc.newsDateTitle = dateStr
            vc.DescriptionText = self.NewsModelDetails[indexPath.section].DescriptionAr
            vc.SendDecodedUrlPaths = self.SendDecodedUrlPaths


            self.navigationController?.pushViewController(vc, animated: true)
            
        }
        }else{
            if #available(iOS 13.0, *) {
                let vc = self.storyboard?.instantiateViewController(identifier: "DetailedNewsViewController")as! DetailedNewsViewController
                vc.newsTitle = self.NewsModelDetails[indexPath.section].Title
                let PublishDate = self.NewsModelDetails[indexPath.section].PublishDate
                let formatter = DateFormatter()
                formatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZ"
                let yourDate = formatter.date(from: PublishDate)
                formatter.dateFormat = "MMM d, yyyy"
                let dateStr = formatter.string(from: yourDate!)
                vc.newsDateTitle = dateStr
                vc.DescriptionText = self.NewsModelDetails[indexPath.section].Description
                vc.SendDecodedUrlPaths = self.SendDecodedUrlPaths

                self.navigationController?.pushViewController(vc, animated: true)

            } else {
                let vc = self.storyboard?.instantiateViewController(withIdentifier: "DetailedNewsViewController")as! DetailedNewsViewController
                vc.newsTitle = self.NewsModelDetails[indexPath.section].Title
                let PublishDate = self.NewsModelDetails[indexPath.section].PublishDate
                let formatter = DateFormatter()
                formatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZ"
                let yourDate = formatter.date(from: PublishDate)
                formatter.dateFormat = "MMM d, yyyy"
                let dateStr = formatter.string(from: yourDate!)
                vc.newsDateTitle = dateStr
                vc.DescriptionText = self.NewsModelDetails[indexPath.section].Description
                vc.SendDecodedUrlPaths = self.SendDecodedUrlPaths

                self.navigationController?.pushViewController(vc, animated: true)
                
            }
            }

    }
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        
        if section == 0 {
            return 5
        }else{
            return 20
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
