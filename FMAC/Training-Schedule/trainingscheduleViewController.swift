//
//  trainingscheduleViewController.swift
//  FMAC
//
//  Created by MicroExcel on 3/25/21.
//  Copyright © 2021 Fujairah. All rights reserved.
//

import UIKit
import Material
import LGSideMenuController
import LGSideMenuController.LGSideMenuController
import LGSideMenuController.UIViewController_LGSideMenuController
import Alamofire
import SwiftyJSON
import MBProgressHUD
import DropDown

class trainingscheduleViewController: LGSideMenuController,UIGestureRecognizerDelegate,UITextFieldDelegate {
    
    var mainurlString : String = ""

    var TrainingScheduleModelDetails : [TrainingScheduleModel] = []
    var CoachTrainingScheduleModelDetails : [CoachTrainingScheduleModel] = []
    var typechecking : String = ""
    let dropDown = DropDown()
    var BranchesnameArray = [String]()
    var BranchesnameARArray = [String]()

    var SportsTrainingScheduleModelDetails : [SportsTrainingScheduleModel] = []
    @IBOutlet var TBV: UITableView!
    var txtArray = [String]()
    var txtArray1 = [String]()
    var NewdateArray = [String]()
    @IBOutlet var ArabicTopPopView: UIView!
    @IBOutlet var EnglishTopPopView: UIView!
    @IBOutlet var dayTf: ErrorTextField!
    @IBOutlet var branchTf: ErrorTextField!
    @IBOutlet weak var AlphaView: UIView!
    @IBOutlet var branchArTF: FormTextField!
    
    var SelectDayTypesArray = ["Saturday/Monday/Wednesday","Sunday/Tuesday/Thursday"]
    var SelectDayTypesArArray = ["السبت / الاثنين / الاربعاء","الاحد / الثلاثاء / الخميس"]

    var branchTfPassStr : String = ""
    var dayTfPassStr : String = ""

    @IBOutlet var dayArTf: FormTextField!
    override func viewWillAppear(_ animated: Bool) {
        hideLeftView(animated: false, completionHandler: nil)
        

        self.AlphaView.isHidden = true
        self.txtArray.removeAll()
        self.txtArray1.removeAll()
        self.NewdateArray.removeAll()
        let lang_code = UserDefaults.standard.value(forKey: "lang_code")as? String
        if lang_code == "ar" {
            self.langChange(strLan: "ar")
            self.ArabicTopPopView.isHidden = false
            self.EnglishTopPopView.isHidden = true
            self.dayArTf.textAlignment = .right
            self.branchArTF.textAlignment = .right
            self.TBV.register(UINib.init(nibName: "TrainingScheduleTableViewArCell", bundle: nil), forCellReuseIdentifier: "TrainingScheduleTableViewArCell")
            TBV.dataSource = self
            TBV.delegate = self
            TBV.reloadData()
            

        }else{
            self.dayTf.textAlignment = .left
            self.branchTf.textAlignment = .left
            self.langChange(strLan: "en")
            self.ArabicTopPopView.isHidden = true
            self.EnglishTopPopView.isHidden = false
            self.TBV.register(UINib.init(nibName: "TrainingScheduleTableViewCell", bundle: nil), forCellReuseIdentifier: "TrainingScheduleTableViewCell")
            TBV.dataSource = self
            TBV.delegate = self
            TBV.reloadData()
        }
    }
    func langChange(strLan : String)
    {
        self.navigationItem.title = "TrainingSchedule".localizableString(loc: strLan)
        txtArray.append("IslamAtwa".localizableString(loc: strLan))
        txtArray.append("IslamAtwa".localizableString(loc: strLan))
        txtArray.append("IslamAtwa".localizableString(loc: strLan))
        txtArray.append("IslamAtwa".localizableString(loc: strLan))
        txtArray.append("IslamAtwa".localizableString(loc: strLan))
        txtArray.append("IslamAtwa".localizableString(loc: strLan))
        txtArray.append("IslamAtwa".localizableString(loc: strLan))
        
        
        txtArray1.append("JudoJuniors".localizableString(loc: strLan))
        txtArray1.append("JudoJuniors".localizableString(loc: strLan))
        txtArray1.append("JudoJuniors".localizableString(loc: strLan))
        txtArray1.append("JudoJuniors".localizableString(loc: strLan))
        txtArray1.append("JudoJuniors".localizableString(loc: strLan))
        txtArray1.append("JudoJuniors".localizableString(loc: strLan))
        txtArray1.append("JudoJuniors".localizableString(loc: strLan))


        NewdateArray.append("TrainingTime".localizableString(loc: strLan))
        NewdateArray.append("TrainingTime".localizableString(loc: strLan))
        NewdateArray.append("TrainingTime".localizableString(loc: strLan))
        NewdateArray.append("TrainingTime".localizableString(loc: strLan))
        NewdateArray.append("TrainingTime".localizableString(loc: strLan))
        NewdateArray.append("TrainingTime".localizableString(loc: strLan))
        NewdateArray.append("TrainingTime".localizableString(loc: strLan))
        
        let attributes = [
            NSAttributedString.Key.foregroundColor: UIColor.white.withAlphaComponent(0.4),
            NSAttributedString.Key.font : UIFont(name: "Oswald-Regular", size: 15)!
        ]
        branchTf.attributedPlaceholder = NSAttributedString(string: "SelectBranch".localizableString(loc: strLan),
                                                            attributes: attributes)
        dayTf.attributedPlaceholder = NSAttributedString(string: "SelectDay".localizableString(loc: strLan),
                                                            attributes: attributes)
        
        
        branchArTF.attributedPlaceholder = NSAttributedString(string: "SelectBranch".localizableString(loc: strLan),
                                                            attributes: attributes)
        dayArTf.attributedPlaceholder = NSAttributedString(string: "SelectDay".localizableString(loc: strLan),
                                                            attributes: attributes)
        BranchesApiMethod()

    }
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationController?.navigationBar.tintColor = .white
        branchArTF.delegate = self
        branchTf.delegate = self
        dayTf.delegate = self
        dayArTf.delegate = self
        
        
        dayTf.textColor = .white
        dayTf.font = UIFont.init(name: ("Oswald-Regular"), size: 15.0);
        
        dayArTf.textColor = .white
        dayArTf.font = UIFont.init(name: ("Oswald-Regular"), size: 15.0);

        branchTf.textColor = .white
        branchTf.font = UIFont.init(name: ("Oswald-Regular"), size: 15.0);
        branchArTF.textColor = .white
        branchArTF.font = UIFont.init(name: ("Oswald-Regular"), size: 15.0);

        dayTf.setLeftPaddingPoints(10)
        branchTf.setLeftPaddingPoints(10)
        
        dayArTf.setRightPaddingPoints(10)
        branchArTF.setRightPaddingPoints(10)
        // Do any additional setup after loading the view.
       


        
      
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
    func textFieldDidBeginEditing(_ textField: UITextField) {
        if textField == branchTf {
            typechecking = "branchTF"
            branchTf.resignFirstResponder()
            BranchesDropDownShow()
            dropDown.show()
        }else if textField == branchArTF
        {
            typechecking = "branchArTF"
            branchArTF.resignFirstResponder()
            BranchesDropDownShow()
            dropDown.show()
        }else if textField == dayTf
        {
            typechecking = "dayTf"
            dayTf.resignFirstResponder()
            BranchesDropDownShow()
            dropDown.show()
        }else if textField == dayArTf
        {
            typechecking = "dayArTf"
            dayArTf.resignFirstResponder()
            BranchesDropDownShow()
            dropDown.show()
        }
    }
    func BranchesDropDownShow()
    {
        if typechecking == "branchTF" {
            self.dropDown.anchorView = self.branchTf
            self.dropDown.dataSource = self.BranchesnameArray
        }else if typechecking == "branchArTF"
        {
            self.dropDown.anchorView = self.branchArTF
            self.dropDown.dataSource = self.BranchesnameARArray
        }else if typechecking == "dayTf"
        {
            self.dropDown.anchorView = self.dayTf
            self.dropDown.dataSource = self.SelectDayTypesArray
        }else if typechecking == "dayArTf"
        {
            self.dropDown.anchorView = self.dayArTf
            self.dropDown.dataSource = self.SelectDayTypesArArray
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
                if typechecking == "branchTF" {
                    self.branchTf.text = BranchesnameArray[index]
                    self.branchTfPassStr = BranchesnameArray[index]
                    if branchTf.text != "" && dayTf.text != "" {
                        trainingscheduleListApiMethod()

                    }else{
                        
                    }
                }else if typechecking == "branchArTF" {
                    self.branchArTF.text = BranchesnameARArray[index]
                    self.branchTfPassStr = BranchesnameArray[index]
                    if branchArTF.text != "" && dayArTf.text != "" {
                        trainingscheduleListApiMethod()

                    }else{
                        
                    }
                }else if typechecking == "dayTf" {
                    self.dayTf.text = SelectDayTypesArray[index]
                    self.dayTfPassStr = SelectDayTypesArray[index]
                    if branchTf.text != "" && dayTf.text != "" {
                        trainingscheduleListApiMethod()

                    }else{
                        
                    }
                }else if typechecking == "dayArTf" {
                    self.dayArTf.text = SelectDayTypesArArray[index]
                    self.dayTfPassStr = SelectDayTypesArray[index]
                    if branchArTF.text != "" && dayArTf.text != "" {
                        trainingscheduleListApiMethod()

                    }else{
                        
                    }
                    
                }
            }
        }
    }
    func BranchesApiMethod()  {
        BranchesnameArray.removeAll()
        BranchesnameARArray.removeAll()
        let urlString = URL(string:MyStrings().BranchesList_API)!
        print(urlString)
        let networkProcessor = NetworkProcessor(url: urlString)
        networkProcessor.downloadJSONFromURL { (passdata) in
            let json = JSON(passdata)
            print("BranchesJson: \(json)")
            let d = json["d"]
            let arrayNames =  d["results"].arrayValue.map {$0["BranchName"].stringValue}
            let arrayNamesAr =  d["results"].arrayValue.map {$0["BranchNameAr"].stringValue}

            self.BranchesnameArray = arrayNames
            self.BranchesnameARArray = arrayNamesAr
            print("BranchesnameARArray : \(self.BranchesnameARArray)")
            let lang_code = UserDefaults.standard.value(forKey: "lang_code")as? String
            if lang_code == "ar" {
                DispatchQueue.main.async {
                    self.branchArTF.text = self.BranchesnameARArray[0]
                }
            }else{
                DispatchQueue.main.async {
            self.branchTf.text = self.BranchesnameArray[0]
                }
            }
            self.branchTfPassStr = self.BranchesnameArray[0]
            self.dayTfPassStr = "Saturday/Monday/Wednesday"
            if lang_code == "ar" {
                DispatchQueue.main.async {
            self.dayArTf.text = "السبت / الاثنين / الاربعاء"
                }
            }else{
                DispatchQueue.main.async {
            self.dayTf.text = "Saturday/Monday/Wednesday"
                }
            }
            print(self.BranchesnameArray)
            self.trainingscheduleListApiMethod()
        }
                
    }
    
    func trainingscheduleListApiMethod()  {
      
        DispatchQueue.main.async {
            MBProgressHUD.showAdded(to: self.view, animated: true)
        }
        TrainingScheduleModelDetails.removeAll()
        SportsTrainingScheduleModelDetails.removeAll()
        CoachTrainingScheduleModelDetails.removeAll()
        let urlString1 = self.branchTfPassStr.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)
        if let urls = URL(string: urlString1!)
        {
            let ur = urls.absoluteString
        self.mainurlString = MyStrings().TrainingScheduleList_API + ur + "%27%20and%20TrainingDays%20eq%20%27" + dayTfPassStr + "%27"
        }
        let networkProcessor = NetworkProcessor(url: URL(string: self.mainurlString)!)
        networkProcessor.downloadJSONFromURL { (passdata) in
            DispatchQueue.main.async {
                MBProgressHUD.hide(for: self.view, animated: true)
            }
            
            let json1 = JSON(passdata)
            let d = json1["d"]
            let json = d["results"]
            print("trainingscheduleList:\(json)")
            for (index,subJson):(String, JSON) in json {
                print(index)
                print(subJson)
                let Coach = subJson["Coach"]
                print(Coach)
                let details1 = CoachTrainingScheduleModel.init(json: Coach)
                self.CoachTrainingScheduleModelDetails.append(details1)

                let Sport = subJson["Sport"]
                print(Sport)
                let details2 = SportsTrainingScheduleModel.init(json: Sport)
                self.SportsTrainingScheduleModelDetails.append(details2)

                let details = TrainingScheduleModel.init(json: subJson)
                self.TrainingScheduleModelDetails.append(details)
                
            }
            DispatchQueue.main.async {
                self.TBV.reloadData()
            }
        }
        
    }
  
}
extension trainingscheduleViewController: UITableViewDataSource,UITableViewDelegate {
    
    func numberOfSections(in tableView: UITableView) -> Int
    {
        if TrainingScheduleModelDetails.count == 0
        {
            return 0
        }else{
        return TrainingScheduleModelDetails.count
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
            let cell = self.TBV.dequeueReusableCell(withIdentifier: "TrainingScheduleTableViewArCell", for: indexPath)as! TrainingScheduleTableViewArCell
            cell.trainingCoachNameLbl.text = self.CoachTrainingScheduleModelDetails[indexPath.section].CoachNameAr
            cell.trainingSportNameLbl.text = self.SportsTrainingScheduleModelDetails[indexPath.section].SportNameAr
            let fromtime = self.TrainingScheduleModelDetails[indexPath.section].FromTime
            let totime = self.TrainingScheduleModelDetails[indexPath.section].ToTime
            cell.trainingTimeLbl.text = fromtime + "-" + totime
            return cell
        }else{
            let cell = self.TBV.dequeueReusableCell(withIdentifier: "TrainingScheduleTableViewCell", for: indexPath)as! TrainingScheduleTableViewCell
            cell.trainingCoachNameLbl.text = self.CoachTrainingScheduleModelDetails[indexPath.section].CoachName
            cell.trainingSportNameLbl.text = self.SportsTrainingScheduleModelDetails[indexPath.section].SportName
            let fromtime = self.TrainingScheduleModelDetails[indexPath.section].FromTime
            let totime = self.TrainingScheduleModelDetails[indexPath.section].ToTime
            cell.trainingTimeLbl.text = fromtime + "-" + totime
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
