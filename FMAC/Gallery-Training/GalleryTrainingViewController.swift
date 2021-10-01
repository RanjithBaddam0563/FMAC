//
//  GalleryTrainingViewController.swift
//  FMAC
//
//  Created by MicroExcel on 3/18/21.
//  Copyright © 2021 Fujairah. All rights reserved.
//

import UIKit
import DropDown
import LGSideMenuController
import LGSideMenuController.LGSideMenuController
import LGSideMenuController.UIViewController_LGSideMenuController
import Alamofire
import SwiftyJSON
import MBProgressHUD
import Kingfisher
//import SDWebImage


class GalleryTrainingViewController: LGSideMenuController,UIGestureRecognizerDelegate,UITextFieldDelegate {
    var GalleryModelDetails : [GalleryModel] = []
    var GalleryModelFileDetails : [GalleryModelFile] = []
    var TypeOfGamesListModelDetails : [TypeOfGamesListModel] = []
    
    var mainurlString : String = ""

    var urlString1 : String = ""
    var URLString : String = ""
    var BASEURLPATH : String = ""

    var navTitleName : String = ""
    var typechecking : String = ""
    @IBOutlet var englishFieldsView: UIView!
    @IBOutlet var ArabicFieldsView: UIView!
    var TypeOfSportnameArray = [String]()
    var TypeOfSportnameArrayPass = [String]()

    var SelectedGamePassStr : String = ""
    var SelectedYearPassStr : String = ""

    var SelectYearArray = [String]()
    var SelectYearArrayPass = [String]()

    var TypeOfGameUrl : String = ""
    var ChamFilterFrom : String = ""
    
    
    @IBOutlet var engSportView: UIView!
    @IBOutlet var engYearView: UIView!
    
    @IBOutlet var arSportView: UIView!
    @IBOutlet var arYearView: UIView!
    let dropDown = DropDown()
    let dropDown1 = DropDown()
    var fromIndex : String = ""

    let dropDownValues = ["Boxing", "Archery", "Fence","Judo", "Taekwondo","Karate","Wrestling"]
    let dropDownValues1 = ["2021", "2020", "2019","2018", "2017"]

    @IBOutlet var selectYearArTF: UITextField!
    @IBOutlet var selectGameArTF: UITextField!

    @IBOutlet var fullImgView: UIImageView!
    @IBOutlet var popUpView: UIView!
    @IBOutlet var AlphaView: UIView!
    @IBOutlet var forwardBtn: UIButton!
    @IBOutlet var backBtn: UIButton!
    @IBOutlet var selectYearTF: UITextField!
    @IBOutlet var selectGameTF: UITextField!
    var imgArray = ["news1","news2","news3","news4","news5","news6","news7","news1","news2"]
    var IndexID = Int()

    @IBOutlet var collectionVw: UICollectionView!
    
    override func viewWillAppear(_ animated: Bool)
    {
        self.navigationController?.navigationBar.tintColor = .white

        hideLeftView(animated: false, completionHandler: nil)
        self.AlphaView.isHidden = true
        let lang_code = UserDefaults.standard.value(forKey: "lang_code")as? String
        if lang_code == "ar" {
            self.langChange(strLan: "ar")
            self.ArabicFieldsView.isHidden = false
            self.englishFieldsView.isHidden = true
            self.selectYearArTF.textAlignment = .right
            self.selectGameArTF.textAlignment = .right

        }else{
            self.langChange(strLan: "en")
            self.ArabicFieldsView.isHidden = true
            self.englishFieldsView.isHidden = false
            self.selectYearTF.textAlignment = .left
            self.selectGameTF.textAlignment = .left
        }
    }
    func langChange(strLan : String)
    {
        if navTitleName == ""
        {
            self.navigationItem.title = "ChampionShips".localizableString(loc: strLan)
            IndexID = 1
            GalleryDetails()
            if IndexID == 1 {
            TypeOfSportApiMethod()
            }
        }else{
         self.title = navTitleName
            GalleryDetails()
            if IndexID == 0 || IndexID == 1 {
            TypeOfSportApiMethod()
            }else if IndexID == 2
            {
                selectYearApiMethod()
            }
        }

        
        let attributes = [
            NSAttributedString.Key.foregroundColor: UIColor.white.withAlphaComponent(0.4),
            NSAttributedString.Key.font : UIFont(name: "Oswald-Regular", size: 15)!
        ]
        selectYearTF.attributedPlaceholder = NSAttributedString(string: "SelectYear".localizableString(loc: strLan),
                                     attributes: attributes)
        selectGameTF.attributedPlaceholder = NSAttributedString(string: "SelectGame".localizableString(loc: strLan),
                                     attributes: attributes)
        
        selectYearArTF.attributedPlaceholder = NSAttributedString(string: "SelectYear".localizableString(loc: strLan),
                                     attributes: attributes)
        selectGameArTF.attributedPlaceholder = NSAttributedString(string: "SelectGame".localizableString(loc: strLan),
                                     attributes: attributes)
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        
        selectYearApiMethod()
//        selectGameTypeChampionshipMethod()
        
        self.selectGameTF.delegate = self
        self.selectYearTF.delegate = self
        selectGameTF.setLeftPaddingPoints(10)
        selectYearTF.setLeftPaddingPoints(10)
        
        selectGameArTF.setRightPaddingPoints(10)
        selectYearArTF.setRightPaddingPoints(10)
        
        selectYearTF.textColor = .white
        selectYearTF.font = UIFont.init(name: ("Oswald-Regular"), size: 15.0);

        selectGameTF.textColor = .white
        selectGameTF.font = UIFont.init(name: ("Oswald-Regular"), size: 15.0);
        
        selectYearArTF.textColor = .white
        selectYearArTF.font = UIFont.init(name: ("Oswald-Regular"), size: 15.0);

        selectGameArTF.textColor = .white
        selectGameArTF.font = UIFont.init(name: ("Oswald-Regular"), size: 15.0);

        self.fullImgView.enableZoom()
        backBtn.layer.cornerRadius = backBtn.frame.size.width/2
        backBtn.layer.borderColor = UIColor.white.cgColor
        backBtn.layer.borderWidth = 1.0
        forwardBtn.layer.cornerRadius = forwardBtn.frame.size.width/2
        forwardBtn.layer.borderColor = UIColor.white.cgColor
        forwardBtn.layer.borderWidth = 1.0

        
        
       
        //TapGestureCode
        let mytapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(myTapAction))
        mytapGestureRecognizer.numberOfTapsRequired = 1
        self.AlphaView.addGestureRecognizer(mytapGestureRecognizer)
        mytapGestureRecognizer.delegate = self as UIGestureRecognizerDelegate
        
        let left = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "sideMenuViewController") as? sideMenuViewController
        leftViewController = left
        leftViewWidth = view.frame.size.width - 110
        leftViewPresentationStyle = .slideAbove
        
        
        
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
    
    func GalleryDetails()
    {
        DispatchQueue.main.async {
            MBProgressHUD.showAdded(to: self.view, animated: true)
        }
        GalleryModelDetails.removeAll()
        GalleryModelFileDetails.removeAll()
        if IndexID == 0 {
            self.URLString = MyStrings().TrainingsGallery_API
            DispatchQueue.main.async {
                let lang_code = UserDefaults.standard.value(forKey: "lang_code")as? String
                if lang_code == "ar" {
                    self.arYearView.isHidden = true
                    self.engSportView.isHidden = false

                }else{
                self.engYearView.isHidden = true
                    self.engSportView.isHidden = false

                }
            }
        }else if IndexID == 1 {
            self.URLString = MyStrings().ChampionshipsGallery_API
            DispatchQueue.main.async {
                let lang_code = UserDefaults.standard.value(forKey: "lang_code")as? String
                if lang_code == "ar" {
                    self.arYearView.isHidden = false
                    self.engSportView.isHidden = false
                }else{
                self.engYearView.isHidden = false
                    self.engSportView.isHidden = false

                }
            }
        }else if IndexID == 2 {
            self.URLString = MyStrings().CampsGallery_API
            DispatchQueue.main.async {
                let lang_code = UserDefaults.standard.value(forKey: "lang_code")as? String
                if lang_code == "ar" {
                    self.arSportView.isHidden = true

                }else{
                self.engSportView.isHidden = true
                }
            }
        }else if IndexID == 3 {
            self.URLString = MyStrings().ConferencesGallery_API
            DispatchQueue.main.async {
                let lang_code = UserDefaults.standard.value(forKey: "lang_code")as? String
                if lang_code == "ar" {
                    self.arYearView.isHidden = true
                    self.engSportView.isHidden = false

                }else{
                self.engYearView.isHidden = true
                    self.engSportView.isHidden = false
                }
            }
        }
        let urlString = URL(string:self.URLString)!
        print(urlString)
        let networkProcessor = NetworkProcessor(url: urlString)
        networkProcessor.downloadJSONFromURL { (passdata) in
            DispatchQueue.main.async {
                MBProgressHUD.hide(for: self.view, animated: true)
            }
            let json1 = JSON(passdata)
            print("json1: \(json1)")
            let d = json1["d"]
            let json = d["results"]
            for (index,subJson):(String, JSON) in json {
                print(index)
                print("subJson: \(subJson)")

                let details = GalleryModel.init(json: subJson)
                self.GalleryModelDetails.append(details)
                let AttachmentFiles = subJson["AttachmentFiles"]
                let results = AttachmentFiles["results"]
                for (index1,subJson1):(String, JSON) in results {
                    let ServerRelativePath = subJson1["ServerRelativePath"]
                    let details1 = GalleryModelFile.init(json: ServerRelativePath)
                    self.GalleryModelFileDetails.append(details1)
                }
            }
            print("GalleryModelDetails \(self.GalleryModelDetails.count)")
            DispatchQueue.main.async {
                self.collectionVw.reloadData()
            }
        }
        
    }
    func FilterTypeOfSportTrainingList()  {
        GalleryModelDetails.removeAll()
        GalleryModelFileDetails.removeAll()
        DispatchQueue.main.async {
            MBProgressHUD.showAdded(to: self.view, animated: true)
        }
        
        self.urlString1 = self.SelectedGamePassStr.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)!
        
        
        if let urls = URL(string: self.urlString1)
        {
            if IndexID == 1 {
                if self.ChamFilterFrom == "GameYear"
                {
                    let lang_code = UserDefaults.standard.value(forKey: "lang_code")as? String
                    if lang_code == "ar" {
                        let ur = urls.absoluteString
                        self.mainurlString = MyStrings().ChampionshipsGallerySelectGameByCategoryAndYearAPI + ur + "%27%20and%20GalleryYear/Title%20eq%20%27" + self.selectYearArTF.text! + "%27"
                        }else{
                    let ur = urls.absoluteString
                    self.mainurlString = MyStrings().ChampionshipsGallerySelectGameByCategoryAndYearAPI + ur + "%27%20and%20GalleryYear/Title%20eq%20%27" + self.selectYearTF.text! + "%27"
                    }
                }else if self.ChamFilterFrom == "Game"
                {
                    let ur = urls.absoluteString
                    self.mainurlString = MyStrings().ChampionshipsGallerySelectGameAPI + ur + "%27&$expand=AttachmentFiles"
                }else if self.ChamFilterFrom == "Year"
                {
                    let ur = urls.absoluteString
                    self.mainurlString = MyStrings().ChampionshipsGallerySelectGameByYearAPI + ur + "%27&$expand=AttachmentFiles"
                }else{
                    let ur = urls.absoluteString
                    self.mainurlString = MyStrings().ChampionshipsGallerySelectGameAPI + ur + "%27&$expand=AttachmentFiles"
                }
                
            }else if IndexID == 0{
            let ur = urls.absoluteString
            self.mainurlString = MyStrings().TrainingsGallerySelectGameAPI + ur + "%27&$expand=AttachmentFiles"
            }else if IndexID == 2{
                let ur = urls.absoluteString
                self.mainurlString = MyStrings().CampsGallerySelectGameAPI + ur + "%27&$expand=AttachmentFiles"
                }
        }else{
            
        }
        print("self.mainurlString:\(mainurlString)")
        let networkProcessor = NetworkProcessor(url: URL(string: self.mainurlString)!)
        networkProcessor.downloadJSONFromURL { (passdata) in
            DispatchQueue.main.async {
                MBProgressHUD.hide(for: self.view, animated: true)
            }
            let json1 = JSON(passdata)
            print("json1: \(json1)")
            let d = json1["d"]
            let json = d["results"]
            for (index,subJson):(String, JSON) in json {
                print(index)
                print("subJson: \(subJson)")

                let details = GalleryModel.init(json: subJson)
                self.GalleryModelDetails.append(details)
                let AttachmentFiles = subJson["AttachmentFiles"]
                let results = AttachmentFiles["results"]
                for (index1,subJson1):(String, JSON) in results {
                    let ServerRelativePath = subJson1["ServerRelativePath"]
                    let details1 = GalleryModelFile.init(json: ServerRelativePath)
                    self.GalleryModelFileDetails.append(details1)
                }
            }
            print("GalleryModelDetails \(self.GalleryModelDetails.count)")
            DispatchQueue.main.async {
                self.collectionVw.reloadData()
            }
        }
        
    }
    @objc func myTapAction(recognizer: UITapGestureRecognizer)
    {
        hideLeftView(animated: true, completionHandler: nil)
        DispatchQueue.main.async {
            self.popUpView.isHidden = true
            self.AlphaView.isHidden = true
        }
        
    }
    func textFieldDidBeginEditing(_ textField: UITextField) {
        if textField == selectGameTF {
            
            typechecking = "typeOfGameTF"
            selectGameTF.resignFirstResponder()
            BranchesDropDownShow()
            dropDown.show()
            
        }else if textField == selectYearTF{
            typechecking = "selectYearTF"
            selectYearTF.resignFirstResponder()
            BranchesDropDownShow()
            dropDown.show()
        }else if textField == selectGameArTF {
            typechecking = "selectGameArTF"
            selectGameArTF.resignFirstResponder()
            BranchesDropDownShow()
            dropDown.show()
        }else if textField == selectYearArTF{
            typechecking = "selectYearArTF"
            selectYearArTF.resignFirstResponder()
            BranchesDropDownShow()
           dropDown.show()
        }
    }
    func BranchesDropDownShow()
    {
        if typechecking == "typeOfGameTF" {
            self.dropDown.anchorView = self.selectGameTF
            self.dropDown.dataSource = self.TypeOfSportnameArray
        }else if typechecking == "selectGameArTF" {
            self.dropDown.anchorView = self.selectGameArTF
            self.dropDown.dataSource = self.TypeOfSportnameArray
        }else if typechecking == "selectYearTF"
        {
            self.dropDown.anchorView = self.selectYearTF
            self.dropDown.dataSource = self.SelectYearArray
        }else if typechecking == "selectYearArTF"
        {
            self.dropDown.anchorView = self.selectYearArTF
            self.dropDown.dataSource = self.SelectYearArray
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
                if typechecking == "typeOfGameTF" {
                    self.SelectedGamePassStr = TypeOfSportnameArrayPass[index]
                    self.selectGameTF.text = TypeOfSportnameArray[index]
                    if IndexID == 1 {
                        if self.selectGameTF.text == "" && self.selectYearTF.text == ""
                        {
                           print("AlertMessgaeOneEmpty")
                        }else if self.selectGameTF.text != "" && self.selectYearTF.text != ""
                        {
                            self.ChamFilterFrom = "GameYear"
                            FilterTypeOfSportTrainingList()
                        }else if self.selectGameTF.text != "" && self.selectYearTF.text == ""
                        {
                            self.ChamFilterFrom = "Game"
                            FilterTypeOfSportTrainingList()
                        }else if self.selectYearTF.text != "" && self.selectGameTF.text == ""
                        {
                            self.ChamFilterFrom = "Year"
                            FilterTypeOfSportTrainingList()
                        }else{
                            FilterTypeOfSportTrainingList()
                        }
                        }else{
                    if self.selectGameTF.text == ""
                    {
                    }else{
                    FilterTypeOfSportTrainingList()
                    }
                    }
                }else if typechecking == "selectGameArTF" {
                    self.SelectedGamePassStr = TypeOfSportnameArrayPass[index]
                    self.selectGameArTF.text = TypeOfSportnameArray[index]
                    if IndexID == 1 {
                        if self.selectGameArTF.text == "" && self.selectYearArTF.text == ""
                        {
                           print("AlertMessgaeOneEmpty")
                        }else if self.selectGameArTF.text != "" && self.selectYearArTF.text != ""
                        {
                            self.ChamFilterFrom = "GameYear"
                            FilterTypeOfSportTrainingList()
                        }else if self.selectGameArTF.text != "" && self.selectYearArTF.text == ""
                        {
                            self.ChamFilterFrom = "Game"
                            FilterTypeOfSportTrainingList()
                        }else if self.selectYearArTF.text != "" && self.selectGameArTF.text == ""
                        {
                            self.ChamFilterFrom = "Year"
                            FilterTypeOfSportTrainingList()
                        }else{
                            FilterTypeOfSportTrainingList()
                        }
                        }else{
                    if self.selectGameArTF.text == ""
                    {
                    }else{
                    FilterTypeOfSportTrainingList()
                    }
                    }
                }else if typechecking == "selectYearTF" {
                    self.SelectedYearPassStr = SelectYearArray[index]
                    self.selectYearTF.text = SelectYearArray[index]
                    if IndexID == 1 {
                        if self.selectGameTF.text == "" && self.selectYearTF.text == ""
                        {
                           print("AlertMessgaeOneEmpty")
                        }else if self.selectGameTF.text != "" && self.selectYearTF.text != ""
                        {
                            self.ChamFilterFrom = "GameYear"
                            FilterTypeOfSportTrainingList()
                        }else if self.selectGameTF.text != "" && self.selectYearTF.text == ""
                        {
                            self.ChamFilterFrom = "Game"
                            FilterTypeOfSportTrainingList()
                        }else if self.selectYearTF.text != "" && self.selectGameTF.text == ""
                        {
                            self.ChamFilterFrom = "Year"
                            FilterTypeOfSportTrainingList()
                        }else{
                            FilterTypeOfSportTrainingList()
                        }
                    }else{
                        FilterTypeOfSportTrainingList()
                    }
                }else if typechecking == "selectYearArTF"
                {
                    self.SelectedYearPassStr = SelectYearArray[index]
                    self.selectYearArTF.text = SelectYearArray[index]
                    if IndexID == 1 {
                        if self.selectGameTF.text == "" && self.selectYearArTF.text == ""
                        {
                           print("AlertMessgaeOneEmpty")
                        }else if self.selectYearArTF.text != "" && self.selectYearArTF.text != ""
                        {
                            self.ChamFilterFrom = "GameYear"
                            FilterTypeOfSportTrainingList()
                        }else if self.selectYearArTF.text != "" && self.selectYearArTF.text == ""
                        {
                            self.ChamFilterFrom = "Game"
                            FilterTypeOfSportTrainingList()
                        }else if self.selectYearArTF.text != "" && self.selectGameTF.text == ""
                        {
                            self.ChamFilterFrom = "Year"
                            FilterTypeOfSportTrainingList()
                        }else{
                            FilterTypeOfSportTrainingList()
                        }
                    }else{
                        
                    }
                }
            }
        }
    }

    
    func TypeOfSportApiMethod()  {
        self.TypeOfSportnameArray.removeAll()
        self.TypeOfSportnameArrayPass.removeAll()
        DispatchQueue.main.async {
            MBProgressHUD.showAdded(to: self.view, animated: true)
        }
        if self.IndexID == 0 {
            self.TypeOfGameUrl = MyStrings().TypeOfGame_API
        }else if self.IndexID == 1 {
            self.TypeOfGameUrl = MyStrings().GalleryGameTypesCham_API
        }else if self.IndexID == 2 {
            self.TypeOfGameUrl = MyStrings().GalleryGameTypesCamp_API
        }
        
        let urlString = URL(string:self.TypeOfGameUrl)!
        print(urlString)
        let networkProcessor = NetworkProcessor(url: urlString)
        networkProcessor.downloadJSONFromURL { (passdata) in
            DispatchQueue.main.async {
                MBProgressHUD.hide(for: self.view, animated: true)
            }
            let json = JSON(passdata)
            print("jsonForGameTypes: \(json)")
            let d = json["d"]
            let lang_code = UserDefaults.standard.value(forKey: "lang_code")as? String
            if lang_code == "ar" {
                if self.IndexID == 1 {
                    let arrayNames =  d["results"].arrayValue.map {$0["GalleryTypeAr"].stringValue}
                    let arrayNames2 =  d["results"].arrayValue.map {$0["GalleryType"].stringValue}

                    self.TypeOfSportnameArray = arrayNames
                    self.TypeOfSportnameArrayPass = arrayNames2
                    }else if self.IndexID == 0{
                let arrayNames =  d["results"].arrayValue.map {$0["SportNameArabic"].stringValue}
                let arrayNames1 =  d["results"].arrayValue.map {$0["SportNameAr"].stringValue}
                let arrayNames2 =  d["results"].arrayValue.map {$0["SportName"].stringValue}

                self.TypeOfSportnameArray = arrayNames
                self.TypeOfSportnameArray = arrayNames1
                self.TypeOfSportnameArrayPass = arrayNames2
                }else if self.IndexID == 2{
                    let arrayNames1 =  d["results"].arrayValue.map {$0["TitleAr"].stringValue}
                    let arrayNames2 =  d["results"].arrayValue.map {$0["Title"].stringValue}

                    self.TypeOfSportnameArray = arrayNames1
                    self.TypeOfSportnameArrayPass = arrayNames2
                    }
            }else{
                if self.IndexID == 1 {
                    let arrayNames =  d["results"].arrayValue.map {$0["GalleryType"].stringValue}
                    self.TypeOfSportnameArray = arrayNames
                    self.TypeOfSportnameArrayPass = arrayNames
                    }else if self.IndexID == 0{
                let arrayNames =  d["results"].arrayValue.map {$0["SportName"].stringValue}
                self.TypeOfSportnameArray = arrayNames
                self.TypeOfSportnameArrayPass = arrayNames
                }else if self.IndexID == 2{
                    let arrayNames =  d["results"].arrayValue.map {$0["Title"].stringValue}
                    self.TypeOfSportnameArray = arrayNames
                    self.TypeOfSportnameArrayPass = arrayNames
                    }


            }
            print(self.TypeOfSportnameArray)
        }
        
    }
    func selectYearApiMethod()  {
        DispatchQueue.main.async {
            MBProgressHUD.showAdded(to: self.view, animated: true)
        }
        let urlString = URL(string:MyStrings().GalleryYears_API)!
        print(urlString)
        let networkProcessor = NetworkProcessor(url: urlString)
        networkProcessor.downloadJSONFromURL { (passdata) in
            DispatchQueue.main.async {
                MBProgressHUD.hide(for: self.view, animated: true)
            }
            let json = JSON(passdata)
            print("YearJson : \(json)")
            let d = json["d"]
            let arrayNames =  d["results"].arrayValue.map {$0["Title"].stringValue}
            self.SelectYearArray = arrayNames
            print(self.SelectYearArray)
        }
        
    }
    func selectGameTypeChampionshipMethod()  {
        DispatchQueue.main.async {
            MBProgressHUD.showAdded(to: self.view, animated: true)
        }
        let urlString = URL(string:MyStrings().GalleryGameTypesCham_API)!
        print(urlString)
        let networkProcessor = NetworkProcessor(url: urlString)
        networkProcessor.downloadJSONFromURL { (passdata) in
            DispatchQueue.main.async {
                MBProgressHUD.hide(for: self.view, animated: true)
            }
            let json = JSON(passdata)
            print(json)
            let d = json["d"]
            let arrayNames =  d["results"].arrayValue.map {$0["Title"].stringValue}
            self.SelectYearArray = arrayNames
            print(self.SelectYearArray)
        }
        
    }
    @objc func viewAllBtnAction(sender: UIButton!)
    {
        
        print("title:\(self.GalleryModelDetails[sender.tag].Title)")
            if #available(iOS 13.0, *) {
                let vc = self.storyboard?.instantiateViewController(identifier: "ImagesOfGallaryViewController")as! ImagesOfGallaryViewController
                vc.navTitleName = self.navTitleName
                vc.IndexID = self.IndexID
                let lang_code = UserDefaults.standard.value(forKey: "lang_code")as? String
                if lang_code == "ar" {
                    vc.typeOFSportName = self.GalleryModelDetails[sender.tag].Title
                }else{
                    vc.typeOFSportName = self.GalleryModelDetails[sender.tag].Title
                }
                self.navigationController?.pushViewController(vc, animated: true)

            } else {
                let vc = self.storyboard?.instantiateViewController(withIdentifier: "ImagesOfGallaryViewController")as! ImagesOfGallaryViewController
                vc.navTitleName = self.navTitleName
                vc.IndexID = self.IndexID
                let lang_code = UserDefaults.standard.value(forKey: "lang_code")as? String

                if lang_code == "ar" {
                    vc.typeOFSportName = self.GalleryModelDetails[sender.tag].Title
                }else{
                    vc.typeOFSportName = self.GalleryModelDetails[sender.tag].Title
                }
                self.navigationController?.pushViewController(vc, animated: true)
                
            }
        
       
    }

}
extension GalleryTrainingViewController : UICollectionViewDataSource,UICollectionViewDelegate,UICollectionViewDelegateFlowLayout
{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if GalleryModelDetails.count == 0 {
            return 0
        }else{
            print("GalleryModelDetailsCount \(self.GalleryModelDetails.count)")
            return GalleryModelDetails.count
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "galleryTrainingCollectionViewCell", for: indexPath)as! galleryTrainingCollectionViewCell
        
        let PublishDate = self.GalleryModelDetails[indexPath.item].PublishDate
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZ"
        let yourDate = formatter.date(from: PublishDate)
        formatter.dateFormat = "MMM d, yyyy"
        // again convert your date to string
        cell.dateLbl.text = formatter.string(from: yourDate!)
        
        let lang_code = UserDefaults.standard.value(forKey: "lang_code")as? String
        if lang_code == "ar" {
            cell.viewAllBtn.titleLabel?.textAlignment = .center
            cell.viewAllBtn.setTitle("   مشاهدة الكل   ", for: .normal)
            cell.titleNameLbl.text = self.GalleryModelDetails[indexPath.item].TitleAr
        }else{
            cell.viewAllBtn.titleLabel?.textAlignment = .center
            cell.viewAllBtn.setTitle("   View All   ", for: .normal)
            cell.titleNameLbl.text = self.GalleryModelDetails[indexPath.item].Title
        }
        cell.viewAllBtn.tag = indexPath.item
        cell.viewAllBtn.addTarget(self, action: #selector(self.viewAllBtnAction), for: .touchUpInside)

        let imgTxt = self.GalleryModelFileDetails[indexPath.item].DecodedUrl
        print("imgTxt url \(imgTxt)")
        if IndexID == 0 {
            self.BASEURLPATH = MyStrings().BASEURL1
        }else if IndexID == 1 {
            self.BASEURLPATH = MyStrings().BASEURL1
        }else if IndexID == 2 {
            self.BASEURLPATH = MyStrings().BASEURL1
        }else if IndexID == 3{
            self.BASEURLPATH = MyStrings().BASEURL1
        }
        let combine = self.BASEURLPATH + imgTxt
        print("combine url \(combine)")
        let urlString = combine.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)
        if let urls = URL(string: urlString!)
        {
            DispatchQueue.main.async {
                cell.galleryImgview.kf.indicatorType = .activity
                cell.galleryImgview.kf.setImage(with: urls, placeholder: UIImage(named: "download1"), options: nil, progressBlock: nil, completionHandler: nil)
            }

        }else{
            
        }
        return cell
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: self.collectionVw.frame.width/2.3, height: self.collectionVw.frame.height/2.5)
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath)
    {
        
//        DispatchQueue.main.async {
//            self.popUpView.isHidden = false
//            self.AlphaView.isHidden = false
//
//            let id = "\(self.GalleryModelDetails[indexPath.item].ID)"
//            let imgTxt = self.GalleryModelFileDetails[indexPath.item].DecodedUrl
//            if self.IndexID == 0 {
//                self.BASEURLPATH = MyStrings().BASEURL1
//            }else if self.IndexID == 1 {
//                self.BASEURLPATH = MyStrings().BASEURL1
//            }else if self.IndexID == 2 {
//                self.BASEURLPATH = MyStrings().BASEURL1
//            }else if self.IndexID == 3{
//                self.BASEURLPATH = MyStrings().BASEURL1
//            }
//            let combine = self.BASEURLPATH + imgTxt
////            let combine = MyStrings().BaseUrlGallery + imgTxt
//            let urlString = combine.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)
//            if let urls = URL(string: urlString!)
//            {
//                self.fullImgView.kf.setImage(with: urls, placeholder: UIImage(named: "placeholder"), options: nil, progressBlock: nil, completionHandler: nil)
//
//            }else{
//
//            }
//        }
    }
    
    
}



