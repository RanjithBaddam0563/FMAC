//
//  AnnouncementViewController.swift
//  FMAC
//
//  Created by MicroExcel on 3/25/21.
//  Copyright © 2021 Fujairah. All rights reserved.
//

import UIKit
import LGSideMenuController
import LGSideMenuController.LGSideMenuController
import LGSideMenuController.UIViewController_LGSideMenuController

class AnnouncementViewController: LGSideMenuController,UIGestureRecognizerDelegate {
    @IBOutlet var searchTF: UITextField!
    var navTitleName : String = ""

    @IBOutlet var TBV: UITableView!
    var imgArray = ["annoc","annoc1","annoc2","annoc","annoc1"]
    var txtArray = [String]()
    var dateArray = [String]()
    
    

    @IBOutlet weak var AlphaView: UIView!

    override func viewWillAppear(_ animated: Bool) {
        self.title = navTitleName
        searchTF.resignFirstResponder()
        self.navigationController?.navigationBar.tintColor = .white

        txtArray.removeAll()
        dateArray.removeAll()

        hideLeftView(animated: false, completionHandler: nil)
        self.AlphaView.isHidden = true
        let lang_code = UserDefaults.standard.value(forKey: "lang_code")as? String
        if lang_code == "ar" {
            self.langChange(strLan: "ar")
            searchTF.textAlignment = .right
            self.TBV.reloadData()

        }else{
            self.langChange(strLan: "en")
            searchTF.textAlignment = .left
            self.TBV.reloadData()

        }
    }
    func langChange(strLan : String)
    {
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
        
        searchTF.attributedPlaceholder = NSAttributedString(string: "searchAnnouncement".localizableString(loc: strLan),
                                                            attributes: [NSAttributedString.Key.foregroundColor: UIColor.white.withAlphaComponent(0.4)])

    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        searchTF.setLeftPaddingPoints(10)
        self.TBV.register(UINib.init(nibName: "achivementTableViewCell", bundle: nil), forCellReuseIdentifier: "achivementTableViewCell")
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
extension AnnouncementViewController: UITableViewDataSource,UITableViewDelegate {
    
    func numberOfSections(in tableView: UITableView) -> Int
    {
        if imgArray.count == 0
        {
            return 0
        }else{
            return imgArray.count
        }
        
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
        
        let cell = self.TBV.dequeueReusableCell(withIdentifier: "achivementTableViewCell", for: indexPath)as! achivementTableViewCell
        let lang_code = UserDefaults.standard.value(forKey: "lang_code")as? String
        if lang_code == "ar" {
            cell.achivTxtLbl.textAlignment = .right
            cell.achivDateLbl.textAlignment = .right

        }else{
            cell.achivTxtLbl.textAlignment = .left
            cell.achivDateLbl.textAlignment = .left
        }
        cell.achivImg.image = UIImage.init(named: self.imgArray[indexPath.section])
        cell.achivTxtLbl.text = self.txtArray[indexPath.section]
        cell.achivDateLbl.text = self.dateArray[indexPath.section]
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath)
    {
        if #available(iOS 13.0, *) {
            let vc = self.storyboard?.instantiateViewController(identifier: "detailAchivementViewController")as! detailAchivementViewController
            vc.newsTitle = self.txtArray[indexPath.section]
            vc.fromImg = self.imgArray[indexPath.section]
            vc.newsDateTitle = self.dateArray[indexPath.section]
            self.navigationController?.pushViewController(vc, animated: true)

        } else {
            let vc = self.storyboard?.instantiateViewController(withIdentifier: "detailAchivementViewController")as! detailAchivementViewController
            vc.newsTitle = self.txtArray[indexPath.section]
            vc.fromImg = self.imgArray[indexPath.section]
            vc.newsDateTitle = self.dateArray[indexPath.section]

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
            headerView.backgroundColor = UIColor.black
        return headerView
    }

}
