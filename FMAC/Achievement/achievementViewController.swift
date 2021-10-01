//
//  achievementViewController.swift
//  FMAC
//
//  Created by MicroExcel on 3/25/21.
//  Copyright © 2021 Fujairah. All rights reserved.
//

import UIKit
import LGSideMenuController
import LGSideMenuController.LGSideMenuController
import LGSideMenuController.UIViewController_LGSideMenuController
import Alamofire
import SwiftyJSON
import MBProgressHUD
import DropDown

class achievementViewController: LGSideMenuController,UIGestureRecognizerDelegate,UITextFieldDelegate {
    @IBOutlet var searchTF: FormTextField!
    var globalJson = JSON()
    @IBOutlet var selectGameArTF: FormTextField!
    @IBOutlet var searchArTF: FormTextField!
    @IBOutlet var ArStackView: UIStackView!
    @IBOutlet var EngStackView: UIStackView!
    @IBOutlet var selectGameTF: FormTextField!
    var AchievementsListModelDetails : [AchievementsListModel] = []
    var AchievementsFileModelDetails : [AchievementsFileModel] = []
    var TypeOfSportnameArray = [String]()
    var TypeOfSportARnameArray = [String]()

    var typechecking : String = ""
    let dropDown = DropDown()

    @IBOutlet var TBV: UITableView!
    var imgArray = ["achiv","achiv4","achiv","achiv4","achiv"]
    var txtArray = [String]()
    var dateArray = [String]()
    @IBOutlet weak var AlphaView: UIView!

    override func viewWillAppear(_ animated: Bool) {
        searchTF.resignFirstResponder()
        
        self.navigationController?.navigationBar.tintColor = .white
        TBV.rowHeight = UITableView.automaticDimension
        TBV.estimatedRowHeight =  UITableView.automaticDimension
        TBV.tableFooterView = UIView(frame: .zero)
        TBV.backgroundColor = .black
        txtArray.removeAll()
        dateArray.removeAll()

        hideLeftView(animated: false, completionHandler: nil)
        self.AlphaView.isHidden = true
        let lang_code = UserDefaults.standard.value(forKey: "lang_code")as? String
        if lang_code == "ar" {
            self.langChange(strLan: "ar")
            searchTF.setRightPaddingPoints(10)
            searchTF.textAlignment = .right
            self.TBV.register(UINib.init(nibName: "achivementTableViewCellAr", bundle: nil), forCellReuseIdentifier: "achivementTableViewCellAr")

            self.selectGameArTF.textAlignment = .right
            self.searchArTF.textAlignment = .right

            self.ArStackView.isHidden = false
            self.EngStackView.isHidden = true
            self.TBV.dataSource = self
            self.TBV.delegate = self
        }else{
            self.langChange(strLan: "en")
            searchTF.setLeftPaddingPoints(10)
            searchTF.textAlignment = .left
            self.TBV.register(UINib.init(nibName: "achivementTableViewCell", bundle: nil), forCellReuseIdentifier: "achivementTableViewCell")
            self.selectGameArTF.textAlignment = .left
            self.searchTF.textAlignment = .left


            self.ArStackView.isHidden = true
            self.EngStackView.isHidden = false
            self.TBV.dataSource = self
            self.TBV.delegate = self
        }
    }
    func langChange(strLan : String)
    {
        TypeOfSportApiMethod()

        GetAchievementsDetails()
        self.navigationItem.title = "Achievements".localizableString(loc: strLan)

        txtArray.append("Newtitle".localizableString(loc: strLan))
        txtArray.append("Newtitle".localizableString(loc: strLan))
        txtArray.append("Newtitle".localizableString(loc: strLan))
        txtArray.append("Newtitle".localizableString(loc: strLan))
        txtArray.append("Newtitle".localizableString(loc: strLan))
        
        dateArray.append("NewsDate".localizableString(loc: strLan))
        dateArray.append("NewsDate".localizableString(loc: strLan))
        dateArray.append("NewsDate".localizableString(loc: strLan))
        dateArray.append("NewsDate".localizableString(loc: strLan))
        dateArray.append("NewsDate".localizableString(loc: strLan))
        
        searchTF.attributedPlaceholder = NSAttributedString(string: "SearchAchievements".localizableString(loc: strLan),
                                                            attributes: [NSAttributedString.Key.foregroundColor: UIColor.white.withAlphaComponent(0.4)])
        searchArTF.attributedPlaceholder = NSAttributedString(string: "SearchAchievements".localizableString(loc: strLan),
                                                            attributes: [NSAttributedString.Key.foregroundColor: UIColor.white.withAlphaComponent(0.4)])
        let attributes = [
            NSAttributedString.Key.foregroundColor: UIColor.white.withAlphaComponent(0.4),
            NSAttributedString.Key.font : UIFont(name: "Oswald-Regular", size: 15)!
        ]
        
        selectGameTF.attributedPlaceholder = NSAttributedString(string: "SelectGame".localizableString(loc: strLan),
                                     attributes: attributes)
        
        
        selectGameArTF.attributedPlaceholder = NSAttributedString(string: "SelectGame".localizableString(loc: strLan),
                                     attributes: attributes)

    }
    func GetAchievementsDetails()
    {
        DispatchQueue.main.async {
            MBProgressHUD.showAdded(to: self.view, animated: true)
        }
        AchievementsListModelDetails.removeAll()
        AchievementsFileModelDetails.removeAll()
        let urlString = URL(string:MyStrings().Achivements_API)!
        print(urlString)
        let networkProcessor = NetworkProcessor(url: urlString)
        networkProcessor.downloadJSONFromURL { (passdata) in
            DispatchQueue.main.async {
                MBProgressHUD.hide(for: self.view, animated: true)
            }
            let json1 = JSON(passdata)
            let d = json1["d"]
            self.globalJson = d["results"]
            print("selfglobalJson : \(self.globalJson)")
            for (index,subJson):(String, JSON) in self.globalJson {
                print(index)
                print(subJson)
                let details = AchievementsListModel.init(json: subJson)
                self.AchievementsListModelDetails.append(details)
                let AttachmentFiles = subJson["AttachmentFiles"]
                let results = AttachmentFiles["results"]
                for (index1,subJson1):(String, JSON) in results {
//                    let ServerRelativePath = subJson1["ServerRelativePath"]
                    let details1 = AchievementsFileModel.init(json: subJson1)
                    self.AchievementsFileModelDetails.append(details1)
                }

            }
            DispatchQueue.main.async {
                self.TBV.reloadData()
            }
        }
        
        
    }
    override func viewDidLoad() {
        super.viewDidLoad()
//        searchTF.setLeftPaddingPoints(10)
       
        selectGameTF.textColor = .white
        selectGameTF.font = UIFont.init(name: ("Oswald-Regular"), size: 15.0);
        
        selectGameArTF.textColor = .white
        selectGameArTF.font = UIFont.init(name: ("Oswald-Regular"), size: 15.0);

        searchTF.textColor = .white
        searchTF.font = UIFont.init(name: ("Oswald-Regular"), size: 15.0);
        searchTF.textColor = .white
        searchTF.font = UIFont.init(name: ("Oswald-Regular"), size: 15.0);

        selectGameTF.setLeftPaddingPoints(10)
        selectGameArTF.setRightPaddingPoints(10)
        
     
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

    @objc func readMoreBtnBtnAction(sender: UIButton!)
    {
        if #available(iOS 13.0, *) {
            let vc = self.storyboard?.instantiateViewController(identifier: "detailAchivementViewController")as! detailAchivementViewController
            let lang_code = UserDefaults.standard.value(forKey: "lang_code")as? String
            if lang_code == "ar" {
                vc.newsTitle = self.AchievementsListModelDetails[sender.tag].TitleAr
                vc.newsDes = self.AchievementsListModelDetails[sender.tag].DescriptionAr
            }else{
                vc.newsTitle = self.AchievementsListModelDetails[sender.tag].Title
                vc.newsDes = self.AchievementsListModelDetails[sender.tag].Description
            }
            let PublishDate = self.AchievementsListModelDetails[sender.tag].PublishDate
            let formatter = DateFormatter()
            formatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZ"
            let yourDate = formatter.date(from: PublishDate)
            formatter.dateFormat = "MMM d, yyyy"
            // again convert your date to string
            let dateStr = formatter.string(from: yourDate!)
            
            vc.from = "Achive"
            vc.fromImg = self.AchievementsFileModelDetails[sender.tag].ServerRelativeUrl
            vc.newsDateTitle = dateStr

            self.navigationController?.pushViewController(vc, animated: true)

        } else {
            let vc = self.storyboard?.instantiateViewController(withIdentifier: "detailAchivementViewController")as! detailAchivementViewController
            let lang_code = UserDefaults.standard.value(forKey: "lang_code")as? String
            if lang_code == "ar" {
                vc.newsTitle = self.AchievementsListModelDetails[sender.tag].TitleAr
                vc.newsDes = self.AchievementsListModelDetails[sender.tag].DescriptionAr

            }else{
                vc.newsTitle = self.AchievementsListModelDetails[sender.tag].Title
                vc.newsDes = self.AchievementsListModelDetails[sender.tag].Description
            }
            let PublishDate = self.AchievementsListModelDetails[sender.tag].PublishDate
            let formatter = DateFormatter()
            formatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZ"
            let yourDate = formatter.date(from: PublishDate)
            formatter.dateFormat = "MMM d, yyyy"
            // again convert your date to string
            let dateStr = formatter.string(from: yourDate!)
            vc.from = "Achive"
            vc.fromImg = self.AchievementsFileModelDetails[sender.tag].ServerRelativeUrl
            vc.newsDateTitle = dateStr

            self.navigationController?.pushViewController(vc, animated: true)
            
        }

    }
    func textFieldDidBeginEditing(_ textField: UITextField) {
        if textField == selectGameTF {
            
            typechecking = "selectGameTF"
            selectGameTF.resignFirstResponder()
            BranchesDropDownShow()
            dropDown.show()
            
        }else if textField == selectGameArTF{
            typechecking = "selectGameArTF"
            selectGameArTF.resignFirstResponder()
            BranchesDropDownShow()
            dropDown.show()
        }else if textField == searchTF {
            
        }else if textField == searchArTF{
            
        }
    }
    func BranchesDropDownShow()
    {
        if typechecking == "selectGameTF" {
            self.dropDown.anchorView = self.selectGameTF
            self.dropDown.dataSource = self.TypeOfSportnameArray
        }else if typechecking == "selectGameArTF"
        {
            self.dropDown.anchorView = self.selectGameArTF
            self.dropDown.dataSource = self.TypeOfSportARnameArray
        }
        DispatchQueue.main.async {
            self.dropDown.bottomOffset = CGPoint(x: 0, y:(self.dropDown.anchorView?.plainView.bounds.height)!)
            self.dropDown.topOffset = CGPoint(x: 0, y:-(self.dropDown.anchorView?.plainView.bounds.height)!)
        self.dropDown.direction = .bottom
        DropDown.appearance().textColor = UIColor.black
        DropDown.appearance().selectedTextColor = UIColor.red
            DropDown.appearance().textFont = UIFont(name: "Oswald-Regular", size: 15)!
        DropDown.appearance().backgroundColor = UIColor.white
        DropDown.appearance().selectionBackgroundColor = UIColor.lightGray
        }
//        DropDown.appearance().cellHeight = 60
        self.dropDown.selectionAction = { [unowned self] (index: Int, item: String) in
          print("Selected item: \(item) at index: \(index)")
            DispatchQueue.main.async {
                if typechecking == "selectGameTF" {
                    self.selectGameTF.text = TypeOfSportnameArray[index]
                }else if typechecking == "selectGameArTF" {
                    self.selectGameArTF.text = TypeOfSportARnameArray[index]
                }
            }
        }
    }
    func TypeOfSportApiMethod()  {
        DispatchQueue.main.async {
            MBProgressHUD.showAdded(to: self.view, animated: true)
        }
        let urlString = URL(string:MyStrings().TypeOfGame_API)!
        print(urlString)
        let networkProcessor = NetworkProcessor(url: urlString)
        networkProcessor.downloadJSONFromURL { (passdata) in
            DispatchQueue.main.async {
                MBProgressHUD.hide(for: self.view, animated: true)
            }
            let json = JSON(passdata)
            print(json)
            let d = json["d"]
            let arrayNames =  d["results"].arrayValue.map {$0["SportName"].stringValue}
            let arrayNames1 =  d["results"].arrayValue.map {$0["SportNameAr"].stringValue}
            self.TypeOfSportARnameArray = arrayNames1
            self.TypeOfSportnameArray = arrayNames
            print(self.TypeOfSportnameArray)
            print(self.TypeOfSportARnameArray)

        }
        
    }

}
extension achievementViewController: UITableViewDataSource,UITableViewDelegate {
    
    func numberOfSections(in tableView: UITableView) -> Int
    {
        if AchievementsListModelDetails.count == 0
        {
            return 0
        }else{
            return AchievementsListModelDetails.count
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
            let cell = self.TBV.dequeueReusableCell(withIdentifier: "achivementTableViewCellAr", for: indexPath)as! achivementTableViewCellAr
            cell.achivTxtLbl.textAlignment = .right
            cell.achivDateLbl.textAlignment = .right
            cell.achivTxtLbl.text = self.AchievementsListModelDetails[indexPath.section].TitleAr
            cell.readMoreBtn.tag = indexPath.section
            cell.readMoreBtn.addTarget(self, action: #selector(self.readMoreBtnBtnAction), for: .touchUpInside)

            let PublishDate = self.AchievementsListModelDetails[indexPath.section].PublishDate
            let formatter = DateFormatter()
            formatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZ"
            let yourDate = formatter.date(from: PublishDate)
            formatter.dateFormat = "MMM d, yyyy"
            // again convert your date to string
            cell.achivDateLbl.text = formatter.string(from: yourDate!)
            let imgTxt = self.AchievementsFileModelDetails[indexPath.section].ServerRelativeUrl
            print("imgTxt url \(imgTxt)")
            let combine =  MyStrings().BASEURL1 + imgTxt
            print("combine url \(combine)")
            let urlString = combine.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)
            if let urls = URL(string: urlString!)
            {
                DispatchQueue.main.async {
                    cell.achivImg.kf.indicatorType = .activity
                    cell.achivImg.kf.setImage(with: urls, placeholder: UIImage(named: "download1"), options: nil, progressBlock: nil, completionHandler: nil)
                }

            }else{
                
            }

            return cell

        }else{
            let cell = self.TBV.dequeueReusableCell(withIdentifier: "achivementTableViewCell", for: indexPath)as! achivementTableViewCell
            cell.achivTxtLbl.textAlignment = .left
            cell.achivDateLbl.textAlignment = .left
            cell.achivTxtLbl.text = self.AchievementsListModelDetails[indexPath.section].Title
            cell.readMoreBtn.tag = indexPath.section
            cell.readMoreBtn.addTarget(self, action: #selector(self.readMoreBtnBtnAction), for: .touchUpInside)
            let PublishDate = self.AchievementsListModelDetails[indexPath.section].PublishDate
            let formatter = DateFormatter()
            formatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZ"
            let yourDate = formatter.date(from: PublishDate)
            formatter.dateFormat = "MMM d, yyyy"
            // again convert your date to string
            cell.achivDateLbl.text = formatter.string(from: yourDate!)
            let imgTxt = self.AchievementsFileModelDetails[indexPath.section].ServerRelativeUrl
            print("imgTxt url \(imgTxt)")
            let combine =  MyStrings().BASEURL1 + imgTxt
            print("combine url \(combine)")
            let urlString = combine.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)
            if let urls = URL(string: urlString!)
            {
                DispatchQueue.main.async {
                    cell.achivImg.kf.indicatorType = .activity
                    cell.achivImg.kf.setImage(with: urls, placeholder: UIImage(named: "download1"), options: nil, progressBlock: nil, completionHandler: nil)
                }

            }else{
                
            }

            return cell

        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath)
    {
        if #available(iOS 13.0, *) {
            let vc = self.storyboard?.instantiateViewController(identifier: "detailAchivementViewController")as! detailAchivementViewController
            let lang_code = UserDefaults.standard.value(forKey: "lang_code")as? String
            if lang_code == "ar" {
                vc.newsTitle = self.AchievementsListModelDetails[indexPath.section].TitleAr
                vc.newsDes = self.AchievementsListModelDetails[indexPath.section].DescriptionAr
            }else{
                vc.newsTitle = self.AchievementsListModelDetails[indexPath.section].Title
                vc.newsDes = self.AchievementsListModelDetails[indexPath.section].Description
            }
            vc.from = "Achive"
            vc.fromImg = self.AchievementsFileModelDetails[indexPath.section].ServerRelativeUrl
            vc.newsDateTitle = self.AchievementsListModelDetails[indexPath.section].PublishDate

            self.navigationController?.pushViewController(vc, animated: true)

        } else {
            let vc = self.storyboard?.instantiateViewController(withIdentifier: "detailAchivementViewController")as! detailAchivementViewController
            let lang_code = UserDefaults.standard.value(forKey: "lang_code")as? String
            if lang_code == "ar" {
                vc.newsTitle = self.AchievementsListModelDetails[indexPath.section].TitleAr
                vc.newsDes = self.AchievementsListModelDetails[indexPath.section].DescriptionAr

            }else{
                vc.newsTitle = self.AchievementsListModelDetails[indexPath.section].Title
                vc.newsDes = self.AchievementsListModelDetails[indexPath.section].Description
            }
            vc.from = "Achive"
            vc.fromImg = self.AchievementsFileModelDetails[indexPath.section].ServerRelativeUrl
            vc.newsDateTitle = self.AchievementsListModelDetails[indexPath.section].PublishDate

            self.navigationController?.pushViewController(vc, animated: true)
            
        }

    }
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        
        if section == 0 {
            return 0
        }else{
            return 15
        }
        
    }
   
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return self.TBV.frame.height/2.1
    }
    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView?
    {
        view.backgroundColor = .black
        let headerView = UIView(frame: CGRect(x: 0, y: 0, width: tableView.bounds.size.width, height: 15))
            headerView.backgroundColor = UIColor.black
        return headerView
    }

}

