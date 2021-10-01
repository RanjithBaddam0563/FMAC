//
//  sideMenuViewController.swift
//  Alain
//
//  Created by MicroExcel on 5/19/20.
//  Copyright © 2020 Microexcel. All rights reserved.
//

import UIKit

class sideMenuViewController: UIViewController {

    var lang_code : String = ""
    
   
    @IBOutlet var logoutBtn: UIButton!
    @IBOutlet var userNameLbl: UILabel!
    @IBOutlet weak var sidemenuTBV: UITableView!
    
    
    
    var firstSectionListArray = [String]()
    var NetworkSectionListArray = [String]()
    var SecondSectionListArray = [String]()
    var ThirdSectionListArray = [String]()
    var fourthSectionListArray = [String]()
    var fifthSectionListArray = [String]()
    var sixthSectionListArray = [String]()
    var HeadersName = [String]()
    

    struct cellData {
        var Opened = Bool()
        var title = String()
        var sectionData = [String]()
        var Imgtitle = String()

    }
    
    var ImageArray = NSArray()
    var tableViewData = [cellData]()

    
    override func viewWillAppear(_ animated: Bool) {
        firstSectionListArray.removeAll()
        NetworkSectionListArray.removeAll()
        SecondSectionListArray.removeAll()
        ThirdSectionListArray.removeAll()
        fourthSectionListArray.removeAll()
        fifthSectionListArray.removeAll()
        sixthSectionListArray.removeAll()
        HeadersName.removeAll()

        let lang_code = UserDefaults.standard.value(forKey: "lang_code")as? String
        if lang_code == "ar" {
            self.langChange(strLan: "ar")
            self.sidemenuTBV.register(UINib.init(nibName: "MenuArTableViewCell", bundle: nil), forCellReuseIdentifier: "MenuArTableViewCell")
            sidemenuTBV.dataSource = self
            sidemenuTBV.delegate = self
            sidemenuTBV.reloadData()
            
        }else{
            self.langChange(strLan: "en")
            self.sidemenuTBV.register(UINib.init(nibName: "MenuTableViewCell", bundle: nil), forCellReuseIdentifier: "MenuTableViewCell")
            sidemenuTBV.dataSource = self
            sidemenuTBV.delegate = self
            sidemenuTBV.reloadData()
        }
        UIApplication.shared.isStatusBarHidden = true


    }
    override func viewWillDisappear(_ animated: Bool) {
        UIApplication.shared.isStatusBarHidden = false
    }
    func langChange(strLan : String)
    {
        userNameLbl.text = "Ranjith".localizableString(loc: strLan)
        logoutBtn.setTitle("Logout".localizableString(loc: strLan), for: .normal)
        
        firstSectionListArray.append("Brief".localizableString(loc: strLan))
        firstSectionListArray.append("LeadershipMessage".localizableString(loc: strLan))
        firstSectionListArray.append("Contactus".localizableString(loc: strLan))
        
        NetworkSectionListArray.append("LocalNews".localizableString(loc: strLan))
        NetworkSectionListArray.append("InternationalNews".localizableString(loc: strLan))
        
        SecondSectionListArray.append("Training".localizableString(loc: strLan))
        SecondSectionListArray.append("Championship".localizableString(loc: strLan))
        SecondSectionListArray.append("Camps".localizableString(loc: strLan))
        SecondSectionListArray.append("Conference".localizableString(loc: strLan))

        ThirdSectionListArray.append("LocalEvents".localizableString(loc: strLan))
        ThirdSectionListArray.append("InternationalEvents".localizableString(loc: strLan))
        
        fourthSectionListArray.append("Ourteam".localizableString(loc: strLan))
        fifthSectionListArray.append("Announcement".localizableString(loc: strLan))
        sixthSectionListArray.append("Arabic".localizableString(loc: strLan))
        
        HeadersName.append("Aboutclub".localizableString(loc: strLan))
        HeadersName.append("News".localizableString(loc: strLan))
        HeadersName.append("Gallery".localizableString(loc: strLan))
        HeadersName.append("Events".localizableString(loc: strLan))
        HeadersName.append("".localizableString(loc: strLan))
        HeadersName.append("".localizableString(loc: strLan))
        HeadersName.append("".localizableString(loc: strLan))
        
        tableViewData = [
            cellData(Opened: false, title: "Aboutclub".localizableString(loc: strLan), sectionData: firstSectionListArray),
            cellData(Opened: false, title: "Ourteam".localizableString(loc: strLan), sectionData: []),
            cellData(Opened: false, title: "Gallery".localizableString(loc: strLan), sectionData: SecondSectionListArray),
            cellData(Opened: false, title: "News".localizableString(loc: strLan), sectionData: NetworkSectionListArray),
                        
            cellData(Opened: false, title: "Events".localizableString(loc: strLan), sectionData: ThirdSectionListArray),
//            cellData(Opened: false, title: "Announcement".localizableString(loc: strLan), sectionData: []),
            cellData(Opened: false, title: "Arabic".localizableString(loc: strLan), sectionData: []),
        ]

    }
    override func viewDidLoad() {
        super.viewDidLoad()
//        self.sidemenuTBV.contentInset = UIEdgeInsets(top: 20,left: 0,bottom: 0,right: 0)

       
        
        ImageArray = ["leave","injury","trophy","notification"]

          
        var prefersStatusBarHidden: Bool {
                return true
            }
            setNeedsStatusBarAppearanceUpdate()
    }
   
    
    
    
   
}
extension sideMenuViewController : UITableViewDelegate,UITableViewDataSource
{
    
    func numberOfSections(in tableView: UITableView) -> Int
    {
        if tableViewData.count == 0
        {
            return 0
        }else{
           return tableViewData.count
        }
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        if tableViewData[section].Opened == true {
            return tableViewData[section].sectionData.count + 1
        }else{
            return 1
        }
      
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
        
        if indexPath.row == 0 &&  tableViewData[indexPath.section].Opened == false{
            
            let lang_code = UserDefaults.standard.value(forKey: "lang_code")as? String
            if lang_code == "ar" {
                let cell = self.sidemenuTBV.dequeueReusableCell(withIdentifier: "MenuArTableViewCell", for: indexPath)as! MenuArTableViewCell
                
                if  indexPath.section == 5 {
                    cell.menuArrowView.image = UIImage(named:"black-box")
                }else{
                    cell.menuArrowView.image = UIImage(named:"backArrow")
                    cell.menuArrowView.transform = CGAffineTransform(rotationAngle: CGFloat.zero)
                }
                
                cell.backgroundColor = UIColor.black
                cell.menuTitleLbl.font = UIFont(name: "Oswald-Medium", size: 18)
                cell.menuTitleLbl.textColor = UIColor.init(red: 204/255, green: 204/255, blue: 204/255, alpha: 1)
                cell.menuTitleLbl.text = tableViewData[indexPath.section].title
                
                return cell
            }else{
                let cell = self.sidemenuTBV.dequeueReusableCell(withIdentifier: "MenuTableViewCell", for: indexPath)as! MenuTableViewCell
                
                if  indexPath.section == 5 {
                    cell.menuArrowView.image = UIImage(named:"black-box")
                }else{
                    cell.menuArrowView.image = UIImage(named:"rightArrow")
                    cell.menuArrowView.transform = CGAffineTransform(rotationAngle: CGFloat.zero)
                }
//                    cell.menuArrowView.image = UIImage(named:"rightArrow")
//                    cell.menuArrowView.transform = CGAffineTransform(rotationAngle: CGFloat.zero)
                
                cell.backgroundColor = UIColor.black
                cell.menuTitleLbl.font = UIFont(name: "Oswald-Medium", size: 18)
                cell.menuTitleLbl.textColor = UIColor.init(red: 204/255, green: 204/255, blue: 204/255, alpha: 1)
                cell.menuTitleLbl.text = tableViewData[indexPath.section].title
                
                return cell
            }
            
        }else if indexPath.row == 0 &&  tableViewData[indexPath.section].Opened == true{
            let lang_code = UserDefaults.standard.value(forKey: "lang_code")as? String
            if lang_code == "ar" {
                let cell = self.sidemenuTBV.dequeueReusableCell(withIdentifier: "MenuArTableViewCell", for: indexPath)as! MenuArTableViewCell
                if  indexPath.section == 5 {
                    cell.menuArrowView.image = UIImage(named:"black-box")
                }else{
                cell.menuArrowView.image = UIImage(named:"backArrow")
                }
                cell.menuArrowView.contentMode = .scaleAspectFit
                cell.menuArrowView.transform = CGAffineTransform(rotationAngle: CGFloat(-Double.pi/2))
                cell.backgroundColor = UIColor.black
                cell.menuTitleLbl.font = UIFont(name: "Oswald-Medium", size: 18)
                cell.menuTitleLbl.textColor = UIColor.init(red: 204/255, green: 204/255, blue: 204/255, alpha: 1)
                cell.menuTitleLbl.text = tableViewData[indexPath.section].title
                
                return cell
            }else{
                let cell = self.sidemenuTBV.dequeueReusableCell(withIdentifier: "MenuTableViewCell", for: indexPath)as! MenuTableViewCell
                if  indexPath.section == 5 {
                    cell.menuArrowView.image = UIImage(named:"black-box")
                }else{
                cell.menuArrowView.image = UIImage(named:"rightArrow")
                }
                cell.menuArrowView.contentMode = .scaleAspectFit
                cell.menuArrowView.transform = CGAffineTransform(rotationAngle: CGFloat(Double.pi/2))
                cell.backgroundColor = UIColor.black
                cell.menuTitleLbl.font = UIFont(name: "Oswald-Medium", size: 18)
                cell.menuTitleLbl.textColor = UIColor.init(red: 204/255, green: 204/255, blue: 204/255, alpha: 1)
                cell.menuTitleLbl.text = tableViewData[indexPath.section].title
                
                return cell
            }
            
        }else{
                    
            
            let lang_code = UserDefaults.standard.value(forKey: "lang_code")as? String
            if lang_code == "ar" {
                let cell = self.sidemenuTBV.dequeueReusableCell(withIdentifier: "MenuArTableViewCell", for: indexPath)as! MenuArTableViewCell
                
                cell.menuArrowView.image = UIImage(named:"black-box")
                
                cell.backgroundColor = UIColor.black
                cell.menuTitleLbl.font = UIFont.systemFont(ofSize: 16.0)
                cell.menuTitleLbl.textColor = UIColor.init(red: 125/255, green: 125/255, blue: 125/255, alpha: 1)
                cell.menuTitleLbl.text = tableViewData[indexPath.section].sectionData[indexPath.row - 1]
                return cell
            }else{
                let cell = self.sidemenuTBV.dequeueReusableCell(withIdentifier: "MenuTableViewCell", for: indexPath)as! MenuTableViewCell

                cell.menuArrowView.image = UIImage(named:"black-box")
                cell.backgroundColor = UIColor.black
                cell.menuTitleLbl.font = UIFont.systemFont(ofSize: 16.0)
                cell.menuTitleLbl.textColor = UIColor.init(red: 125/255, green: 125/255, blue: 125/255, alpha: 1)
                cell.menuTitleLbl.text = tableViewData[indexPath.section].sectionData[indexPath.row - 1]
                return cell
            }
            

                }
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        return 300
        
    }
    func tableView(_ tableView: UITableView, willDisplayHeaderView view: UIView, forSection section: Int)
    {
           view.tintColor = UIColor.black
            let header: UITableViewHeaderFooterView = view as! UITableViewHeaderFooterView
            header.textLabel?.font = UIFont(name: "Oswald-SemiBold", size: 18)
            header.textLabel?.textColor = UIColor.init(red: 204/255, green: 204/255, blue: 204/255, alpha: 1)
            header.textLabel?.textAlignment = NSTextAlignment.left
        
    }
//    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String?
//    {
//        return HeadersName[section]
//    }
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat
    {
        if section == 0
        {
            return 0
        }else{
            return 7
        }
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath)
    {
        
        if indexPath.section == 0
        {
            if indexPath.row == 0
            {
               
           if tableViewData[indexPath.section].Opened == true {
               tableViewData[indexPath.section].Opened = false
               let sections = IndexSet.init(integer: indexPath.section)
            tableView.reloadSections(sections, with: .none) // play Around with this
               
           }else{
            
               tableViewData[indexPath.section].Opened = true
               let sections = IndexSet.init(integer: indexPath.section)
               print("Selectedsections:\(sections)")
               tableView.reloadSections(sections, with: .none)
               
           }
           }
           else if indexPath.row == 1
           {
               if #available(iOS 13.0, *) {
                   let vc = self.storyboard?.instantiateViewController(identifier: "BriefViewController")as! BriefViewController
                   self.navigationController?.pushViewController(vc, animated: true)

               } else {
                   let vc = self.storyboard?.instantiateViewController(withIdentifier: "BriefViewController")as! BriefViewController
                   self.navigationController?.pushViewController(vc, animated: true)
                   
               }

           }else if indexPath.row == 2
           {
               if #available(iOS 13.0, *) {
                   let vc = self.storyboard?.instantiateViewController(identifier: "LeadershipMessageViewController")as! LeadershipMessageViewController
                   self.navigationController?.pushViewController(vc, animated: true)

               } else {
                   let vc = self.storyboard?.instantiateViewController(withIdentifier: "LeadershipMessageViewController")as! LeadershipMessageViewController
                   self.navigationController?.pushViewController(vc, animated: true)
                   
               }

           }else{
            if #available(iOS 13.0, *) {
                let vc = self.storyboard?.instantiateViewController(identifier: "ContactUsViewController")as! ContactUsViewController
                self.navigationController?.pushViewController(vc, animated: true)

            } else {
                let vc = self.storyboard?.instantiateViewController(withIdentifier: "ContactUsViewController")as! ContactUsViewController
                self.navigationController?.pushViewController(vc, animated: true)
                
            }

        }
        }else if indexPath.section == 1
        {
            
                if #available(iOS 13.0, *) {
                    let vc = self.storyboard?.instantiateViewController(identifier: "OutTeamsViewController")as! OutTeamsViewController
                    vc.navTitleName = self.fourthSectionListArray[indexPath.row]

                    self.navigationController?.pushViewController(vc, animated: true)

                } else {
                    let vc = self.storyboard?.instantiateViewController(withIdentifier: "OutTeamsViewController")as! OutTeamsViewController
                    vc.navTitleName = self.fourthSectionListArray[indexPath.row]

                    self.navigationController?.pushViewController(vc, animated: true)
                    
                }

            

           
        }else if indexPath.section == 2
        {
            if indexPath.row == 0
            {
               
           if tableViewData[indexPath.section].Opened == true {
               tableViewData[indexPath.section].Opened = false
               let sections = IndexSet.init(integer: indexPath.section)
            tableView.reloadSections(sections, with: .none) // play Around with this
               
           }else{
            
               tableViewData[indexPath.section].Opened = true
               let sections = IndexSet.init(integer: indexPath.section)
               print("Selectedsections:\(sections)")
               tableView.reloadSections(sections, with: .none)
               
           }
            }else {
            if #available(iOS 13.0, *) {
                let vc = self.storyboard?.instantiateViewController(identifier: "GalleryTrainingViewController")as! GalleryTrainingViewController
                vc.IndexID = indexPath.row - 1
                print("IndexpathGallery \(indexPath.row - 1)")
                vc.navTitleName = self.SecondSectionListArray[indexPath.row - 1]
                self.navigationController?.pushViewController(vc, animated: true)

            } else {
                let vc = self.storyboard?.instantiateViewController(withIdentifier: "GalleryTrainingViewController")as! GalleryTrainingViewController
                print("IndexpathGallery \(indexPath.row - 1)")
                vc.IndexID = indexPath.row - 1
                vc.navTitleName = self.SecondSectionListArray[indexPath.row - 1]
                self.navigationController?.pushViewController(vc, animated: true)
                
            }
            }
        }else if indexPath.section == 3
        {
            if indexPath.row == 0
            {
               
           if tableViewData[indexPath.section].Opened == true {
               tableViewData[indexPath.section].Opened = false
               let sections = IndexSet.init(integer: indexPath.section)
            tableView.reloadSections(sections, with: .none) // play Around with this
               
           }else{
            
               tableViewData[indexPath.section].Opened = true
               let sections = IndexSet.init(integer: indexPath.section)
               print("Selectedsections:\(sections)")
               tableView.reloadSections(sections, with: .none)
               
           }
            }else{
                    
                    DispatchQueue.main.async {
        
                        if #available(iOS 13.0, *) {
                            let vc = self.storyboard?.instantiateViewController(identifier: "NewsViewController")as! NewsViewController
                            print("NetworkSectionListArray is : \(self.NetworkSectionListArray[indexPath.row])")
                            vc.IndexID = indexPath.row - 1
                            vc.navTitleName = self.NetworkSectionListArray[indexPath.row - 1]
        
                            self.navigationController?.pushViewController(vc, animated: true)
        
                        } else {
                            let vc = self.storyboard?.instantiateViewController(withIdentifier: "NewsViewController")as! NewsViewController
                            vc.IndexID = indexPath.row - 1
                            vc.navTitleName = self.NetworkSectionListArray[indexPath.row - 1]
                            self.navigationController?.pushViewController(vc, animated: true)
        
                        }
                    }
                    
            }
        }else if indexPath.section == 4
        {
            if indexPath.row == 0
            {

           if tableViewData[indexPath.section].Opened == true {
               tableViewData[indexPath.section].Opened = false
               let sections = IndexSet.init(integer: indexPath.section)
            tableView.reloadSections(sections, with: .none) // play Around with this

           }else{

               tableViewData[indexPath.section].Opened = true
               let sections = IndexSet.init(integer: indexPath.section)
               print("Selectedsections:\(sections)")
               tableView.reloadSections(sections, with: .none)

           }
            }else{
            if #available(iOS 13.0, *) {
                let vc = self.storyboard?.instantiateViewController(identifier: "EventsViewController")as! EventsViewController
                vc.IndexID = indexPath.row - 1
                vc.navTitleName = self.ThirdSectionListArray[indexPath.row - 1]
                self.navigationController?.pushViewController(vc, animated: true)

            } else {
                let vc = self.storyboard?.instantiateViewController(withIdentifier: "EventsViewController")as! EventsViewController
                vc.IndexID = indexPath.row - 1
                vc.navTitleName = self.ThirdSectionListArray[indexPath.row - 1]
                self.navigationController?.pushViewController(vc, animated: true)
                
            }
            }

        }else
        {
            let lang_code1 = UserDefaults.standard.value(forKey: "lang_code")as? String
            if  lang_code1 == ""{
                lang_code = "ar"
                UserDefaults.standard.set(lang_code, forKey: "lang_code")
                UserDefaults.standard.synchronize()
            }else if lang_code1 == "ar" {
                lang_code = "en"
                UserDefaults.standard.set(lang_code, forKey: "lang_code")
                UserDefaults.standard.synchronize()
            }else{
                lang_code = "ar"
                UserDefaults.standard.set(lang_code, forKey: "lang_code")
                UserDefaults.standard.synchronize()
            }
            
                if #available(iOS 13.0, *) {
                    let vc = self.storyboard?.instantiateViewController(identifier: "forgotPassViewController")as! forgotPassViewController
                    self.navigationController?.pushViewController(vc, animated: false)

                } else {
                    let vc = self.storyboard?.instantiateViewController(withIdentifier: "forgotPassViewController")as! forgotPassViewController
                    self.navigationController?.pushViewController(vc, animated: false)
                    
                }

            
            
        }
    }
   
}
