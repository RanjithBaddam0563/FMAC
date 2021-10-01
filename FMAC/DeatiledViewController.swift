//
//  DeatiledViewController.swift
//  FMAC
//
//  Created by MicroExcel on 2/3/21.
//  Copyright © 2021 Fujairah. All rights reserved.
//

import UIKit

class DeatiledViewController: UIViewController {

    var navTitle : String = ""
    var description1 : String = ""
    var Olympiad : String = ""
    var GameInFMAC : String = ""
    var LocalAchievements : String = ""
    var InternationalAchievements : String = ""
    var fromNav : String = ""
    var SendDecodedUrlPaths = [String]()

    @IBOutlet var imgView: UIImageView!
    var getIndex : Int!
    
    @IBOutlet var historyOfGameLbl: UILabel!
    @IBOutlet var RegBtn: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()

         if self.fromNav == "OurTeam"
        {
            self.navigationItem.title = self.navTitle
            UIBarButtonItem.appearance().setTitleTextAttributes([NSAttributedString.Key.font: UIFont(name: "Oswald-Regular", size: 17)!], for: .normal)
            
            let imgTxt = self.SendDecodedUrlPaths[0]
            let combine = MyStrings().BASEURL1 + imgTxt
            print("combine url \(combine)")
            let urlString = combine.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)
            if let urls = URL(string: urlString!)
            {
                DispatchQueue.main.async {
                    self.imgView.kf.indicatorType = .activity
                    self.imgView.kf.setImage(with: urls, placeholder: UIImage(named: "download1"), options: nil, progressBlock: nil, completionHandler: nil)
                }

            }else{
                
            }
            
            
         }else{
        // Do any additional setup after loading the view.
        let lang_code = UserDefaults.standard.value(forKey: "lang_code")as? String
        if lang_code == "ar" {
            self.navigationItem.title = "KARATE".localizableString(loc: "ar")
            UIBarButtonItem.appearance().setTitleTextAttributes([NSAttributedString.Key.font: UIFont(name: "Oswald-Regular", size: 17)!], for: .normal)
        }else{
            self.navigationItem.title = "KARATE".localizableString(loc: "en")
            UIBarButtonItem.appearance().setTitleTextAttributes([NSAttributedString.Key.font: UIFont(name: "Oswald-Regular", size: 17)!], for: .normal)
        }
         }
        RegBtn.roundCorners([ .bottomRight, .topLeft], radius: 30)
         

    }
    override func viewWillAppear(_ animated: Bool)
    {
           super.viewWillAppear(animated)
        self.navigationController?.navigationBar.tintColor = .white

        let lang_code = UserDefaults.standard.value(forKey: "lang_code")as? String
        if lang_code == "ar" {
            self.historyOfGameLbl.textAlignment = .right
            self.langChange(strLan: "ar")
        }else{
            self.historyOfGameLbl.textAlignment = .left
            self.langChange(strLan: "en")
        }
    }
    func langChange(strLan : String)
    {
        if self.fromNav == "OurTeam"
        {
            self.navigationItem.title = self.navTitle
            UIBarButtonItem.appearance().setTitleTextAttributes([NSAttributedString.Key.font: UIFont(name: "Oswald-Regular", size: 17)!], for: .normal)
        }else{
        self.navigationItem.title = "KARATE".localizableString(loc: strLan)
        UIBarButtonItem.appearance().setTitleTextAttributes([NSAttributedString.Key.font: UIFont(name: "Oswald-Regular", size: 17)!], for: .normal)
        }

        if self.fromNav == "OurTeam"
        {
        let text = NSMutableAttributedString()
        text.append(NSAttributedString(string: "Historyofthesportof".localizableString(loc: strLan) + navTitle + "\n" + "\n", attributes: [NSAttributedString.Key.foregroundColor: UIColor.init(red: 249/255, green: 89/255, blue: 95/255, alpha: 1)]));
            text.append(NSAttributedString(string: self.description1 + "\n" + "\n", attributes: [NSAttributedString.Key.foregroundColor: UIColor.init(red: 125/255, green: 125/255, blue: 125/255, alpha: 1)]));
        text.append(NSAttributedString(string: "Olympiad".localizableString(loc: strLan), attributes: [NSAttributedString.Key.foregroundColor: UIColor.init(red: 249/255, green: 89/255, blue: 95/255, alpha: 1)]));
            text.append(NSAttributedString(string: self.Olympiad + "\n" + "\n", attributes: [NSAttributedString.Key.foregroundColor: UIColor.init(red: 125/255, green: 125/255, blue: 125/255, alpha: 1)]));
            text.append(NSAttributedString(string: self.navTitle + "inFMAC".localizableString(loc: strLan) + "\n" + "\n", attributes: [NSAttributedString.Key.foregroundColor: UIColor.init(red: 249/255, green: 89/255, blue: 95/255, alpha: 1)]));
            text.append(NSAttributedString(string: self.GameInFMAC + "\n" + "\n", attributes: [NSAttributedString.Key.foregroundColor: UIColor.init(red: 125/255, green: 125/255, blue: 125/255, alpha: 1)]));
        text.append(NSAttributedString(string: "Themostachievements".localizableString(loc: strLan), attributes: [NSAttributedString.Key.foregroundColor: UIColor.init(red: 249/255, green: 89/255, blue: 95/255, alpha: 1)]));
            text.append(NSAttributedString(string: "Local".localizableString(loc: strLan) + self.LocalAchievements + "\n" + "\n" , attributes: [NSAttributedString.Key.foregroundColor: UIColor.init(red: 125/255, green: 125/255, blue: 125/255, alpha: 1)]));
            text.append(NSAttributedString(string: "International".localizableString(loc: strLan) + self.InternationalAchievements, attributes: [NSAttributedString.Key.foregroundColor: UIColor.init(red: 125/255, green: 125/255, blue: 125/255, alpha: 1)]))

        
        historyOfGameLbl.attributedText = text
        }else{
        let text = NSMutableAttributedString()
        text.append(NSAttributedString(string: "HistoryofthesportofKarate".localizableString(loc: strLan), attributes: [NSAttributedString.Key.foregroundColor: UIColor.init(red: 249/255, green: 89/255, blue: 95/255, alpha: 1)]));
        text.append(NSAttributedString(string: "HistoryOfsportdetail".localizableString(loc: strLan), attributes: [NSAttributedString.Key.foregroundColor: UIColor.init(red: 125/255, green: 125/255, blue: 125/255, alpha: 1)]));
        text.append(NSAttributedString(string: "Olympiad".localizableString(loc: strLan), attributes: [NSAttributedString.Key.foregroundColor: UIColor.init(red: 249/255, green: 89/255, blue: 95/255, alpha: 1)]));
        text.append(NSAttributedString(string: "OlympiadDetail".localizableString(loc: strLan), attributes: [NSAttributedString.Key.foregroundColor: UIColor.init(red: 125/255, green: 125/255, blue: 125/255, alpha: 1)]));
        text.append(NSAttributedString(string: "KarateinFMAC".localizableString(loc: strLan), attributes: [NSAttributedString.Key.foregroundColor: UIColor.init(red: 249/255, green: 89/255, blue: 95/255, alpha: 1)]));
        text.append(NSAttributedString(string: "KarateDetail".localizableString(loc: strLan), attributes: [NSAttributedString.Key.foregroundColor: UIColor.init(red: 125/255, green: 125/255, blue: 125/255, alpha: 1)]));
        text.append(NSAttributedString(string: "Themostachievements".localizableString(loc: strLan), attributes: [NSAttributedString.Key.foregroundColor: UIColor.init(red: 249/255, green: 89/255, blue: 95/255, alpha: 1)]));
        text.append(NSAttributedString(string: "LocalDetail".localizableString(loc: strLan), attributes: [NSAttributedString.Key.foregroundColor: UIColor.init(red: 125/255, green: 125/255, blue: 125/255, alpha: 1)]));
        text.append(NSAttributedString(string: "InternationalDetail".localizableString(loc: strLan), attributes: [NSAttributedString.Key.foregroundColor: UIColor.init(red: 125/255, green: 125/255, blue: 125/255, alpha: 1)]))

        
        historyOfGameLbl.attributedText = text
        }
        
        RegBtn.setTitle("CLICKHERETOREGISTERKey".localizableString(loc: strLan), for: .normal)
    }
    
       override func viewWillDisappear(_ animated: Bool) {
           super.viewWillDisappear(animated)
       }
  
    @IBAction func ClickOnShareBtn(_ sender: UIBarButtonItem)
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
    @IBAction func ClickOnRegBtn(_ sender: UIButton)
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
