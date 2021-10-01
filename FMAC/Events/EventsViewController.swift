//
//  EventsViewController.swift
//  FMAC
//
//  Created by MicroExcel on 3/26/21.
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

class EventsViewController: LGSideMenuController,UIGestureRecognizerDelegate,UITextFieldDelegate {
    var EventModelDetails : [EventModel] = []
    var DecodedUrlPaths = [String]()
    var IndexID = Int()
    var NewApiNamee : String = ""
    var SendDecodedUrlPaths = [String]()
    var globalJson = JSON()

    var navTitleName : String = ""
    var typechecking : String = ""
    var TypeOfSportnameArray = [String]()
    var TypeOfSportARnameArray = [String]()

    var SelectYearArray = [String]()
    let dropDown = DropDown()

    @IBOutlet var ArabicFieldsView: UIStackView!
    @IBOutlet var englishFieldsView: UIStackView!
    @IBOutlet var TBV: UITableView!
    @IBOutlet var selectYearTF: UITextField!
    @IBOutlet var selectGameTF: UITextField!
    var imgArray = ["news1","news2","news3","news4","news5"]
    var txtArray = [String]()
    @IBOutlet var selectYearArTF: UITextField!
    @IBOutlet var selectGameArTF: UITextField!
    
    @IBOutlet weak var AlphaView: UIView!

    override func viewWillAppear(_ animated: Bool) {
        self.title = navTitleName
        hideLeftView(animated: false, completionHandler: nil)
        self.navigationController?.navigationBar.tintColor = .white
        self.AlphaView.isHidden = true
        txtArray.removeAll()
        let lang_code = UserDefaults.standard.value(forKey: "lang_code")as? String
        if lang_code == "ar" {
            self.langChange(strLan: "ar")
            self.ArabicFieldsView.isHidden = false
            self.englishFieldsView.isHidden = true
            self.selectYearArTF.textAlignment = .right
            self.selectGameArTF.textAlignment = .right
            self.TBV.reloadData()

        }else{
            self.langChange(strLan: "en")
            self.ArabicFieldsView.isHidden = true
            self.englishFieldsView.isHidden = false
            self.selectYearTF.textAlignment = .left
            self.selectGameTF.textAlignment = .left
            self.TBV.reloadData()
        }
    }
    func langChange(strLan : String)
    {
        txtArray.append("event01".localizableString(loc: strLan))
        txtArray.append("event02".localizableString(loc: strLan))
        txtArray.append("event03".localizableString(loc: strLan))
        txtArray.append("event04".localizableString(loc: strLan))
        txtArray.append("event05".localizableString(loc: strLan))
        
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

        EventsApiMethod()
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        
        TypeOfSportApiMethod()
        selectYearApiMethod()
        self.selectGameTF.delegate = self
        self.selectYearTF.delegate = self
        TBV.tableFooterView = UIView()
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

        
        
       
        self.TBV.register(UINib.init(nibName: "EventsTableViewCell", bundle: nil), forCellReuseIdentifier: "EventsTableViewCell")
        TBV.rowHeight = self.TBV.frame.height/2.2
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
    
    @objc func viewAllBtnAction(sender: UIButton!)
    {
        self.SendDecodedUrlPaths.removeAll()
        if self.globalJson.count == 0 {
            
        }else{
        let dict = self.globalJson[sender.tag]
        let AttachmentFiles = dict["AttachmentFiles"]
        let results = AttachmentFiles["results"]
        for (index1,subJson1):(String, JSON) in results {
            let ServerRelativePath = subJson1["ServerRelativePath"]
            let DecodedUrl = ServerRelativePath["DecodedUrl"].stringValue
            self.SendDecodedUrlPaths.append(DecodedUrl)
        }
        print("selfSendDecodedUrlPaths:\(self.SendDecodedUrlPaths)")
        }
        
        if #available(iOS 13.0, *) {
            let vc = self.storyboard?.instantiateViewController(identifier: "detailEventsViewController")as! detailEventsViewController
            vc.SendDecodedUrlPaths = self.SendDecodedUrlPaths
            self.navigationController?.pushViewController(vc, animated: true)

        } else {
            let vc = self.storyboard?.instantiateViewController(withIdentifier: "detailEventsViewController")as! detailEventsViewController
            vc.SendDecodedUrlPaths = self.SendDecodedUrlPaths
            self.navigationController?.pushViewController(vc, animated: true)
            
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
            typechecking = "typeOfGameArTF"
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
        }else if typechecking == "selectYearTF"
        {
            self.dropDown.anchorView = self.selectYearTF
            self.dropDown.dataSource = self.SelectYearArray
        }else if typechecking == "typeOfGameArTF"
        {
            self.dropDown.anchorView = self.selectGameArTF
            self.dropDown.dataSource = self.TypeOfSportARnameArray
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
                    self.selectGameTF.text = TypeOfSportnameArray[index]
                }else if typechecking == "selectYearTF" {
                    self.selectYearTF.text = SelectYearArray[index]
                }else if typechecking == "typeOfGameArTF" {
                    self.selectGameArTF.text = TypeOfSportARnameArray[index]
                }else if typechecking == "selectYearArTF" {
                    self.selectYearArTF.text = SelectYearArray[index]
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
    func selectYearApiMethod()  {
        DispatchQueue.main.async {
            MBProgressHUD.showAdded(to: self.view, animated: true)
        }
        let urlString = URL(string:MyStrings().SelectYear_API)!
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
    
    func EventsApiMethod()  {
        DecodedUrlPaths.removeAll()
        EventModelDetails.removeAll()
        DispatchQueue.main.async {
            MBProgressHUD.showAdded(to: self.view, animated: true)
        }
        if IndexID == 0 {
            self.NewApiNamee = MyStrings().Event_API
        }else{
            self.NewApiNamee = MyStrings().International_Event_API
        }
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
            print("json1 :\(json1)")
            for (index,subJson):(String, JSON) in self.globalJson {
                print(index)
                print(subJson)
                let details = EventModel.init(json: subJson)
                self.EventModelDetails.append(details)
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

}
extension EventsViewController: UITableViewDataSource,UITableViewDelegate {
    
    func numberOfSections(in tableView: UITableView) -> Int
    {
        if EventModelDetails.count == 0
        {
            return 0
        }else{
            return EventModelDetails.count
        }
        
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
        
        let cell = self.TBV.dequeueReusableCell(withIdentifier: "EventsTableViewCell", for: indexPath)as! EventsTableViewCell
        let lang_code = UserDefaults.standard.value(forKey: "lang_code")as? String
        if lang_code == "ar" {
            cell.ArabicView.isHidden = false
            cell.englishView.isHidden = true
        }else{
            cell.ArabicView.isHidden = true
            cell.englishView.isHidden = false
        }
        cell.eventImgVw.image = UIImage.init(named: self.imgArray[indexPath.section])
        cell.eventNameLbl.text = self.EventModelDetails[indexPath.section].Title
        cell.eventNameArLbl.text = self.EventModelDetails[indexPath.section].TitleAr
        let PublishDate = self.EventModelDetails[indexPath.item].PublishDate
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZ"
        let yourDate = formatter.date(from: PublishDate)
        formatter.dateFormat = "MMM d, yyyy"
        // again convert your date to string
        cell.eventdateLbl.text = formatter.string(from: yourDate!)
        cell.eventdateArLbl.text = formatter.string(from: yourDate!)
        cell.viewAllBtn.tag = indexPath.section
        cell.viewAllBtn.addTarget(self, action: #selector(self.viewAllBtnAction), for: .touchUpInside)
        cell.viewAllArBtn.tag = indexPath.section
        cell.viewAllArBtn.addTarget(self, action: #selector(self.viewAllBtnAction), for: .touchUpInside)
        
        let imgTxt = self.DecodedUrlPaths[indexPath.section]
        print("imgTxt url \(imgTxt)")
        let combine = MyStrings().BASEURL1 + imgTxt
        print("combine url \(combine)")
        let urlString = combine.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)
        if let urls = URL(string: urlString!)
        {
            DispatchQueue.main.async {
                cell.eventImgVw.kf.indicatorType = .activity
                cell.eventImgVw.kf.setImage(with: urls, placeholder: UIImage(named: "download1"), options: nil, progressBlock: nil, completionHandler: nil)
            }

        }else{
            
        }
        
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
        
        if #available(iOS 13.0, *) {
            let vc = self.storyboard?.instantiateViewController(identifier: "detailEventsViewController")as! detailEventsViewController
            vc.SendDecodedUrlPaths = self.SendDecodedUrlPaths
            self.navigationController?.pushViewController(vc, animated: true)

        } else {
            let vc = self.storyboard?.instantiateViewController(withIdentifier: "detailEventsViewController")as! detailEventsViewController
            vc.SendDecodedUrlPaths = self.SendDecodedUrlPaths
            self.navigationController?.pushViewController(vc, animated: true)
            
        }

    }
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        
        if section == 0 {
            return 0
        }else{
            return 20
        }
        
    }
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        if section == EventModelDetails.count - 1
        {
          return 20
        }else{
            return 0
        }
    }
   
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return self.TBV.frame.height/2.2
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
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        view.backgroundColor = .black
        let headerView = UIView(frame: CGRect(x: 0, y: 0, width: tableView.bounds.size.width, height: 20))
            headerView.backgroundColor = UIColor.black
        return headerView
    }

}
extension UITextField {
    func setLeftPaddingPoints(_ amount:CGFloat){
        let paddingView = UIView(frame: CGRect(x: 0, y: 0, width: amount, height: self.frame.size.height))
        self.leftView = paddingView
        self.leftViewMode = .always
    }
    func setRightPaddingPoints(_ amount:CGFloat) {
        let paddingView = UIView(frame: CGRect(x: 0, y: 0, width: amount, height: self.frame.size.height))
        self.rightView = paddingView
        self.rightViewMode = .always
    }
}

