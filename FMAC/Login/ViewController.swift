//
//  ViewController.swift
//  FMAC
//
//  Created by MicroExcel on 12/30/20.
//  Copyright © 2020 Fujairah. All rights reserved.
//

import UIKit
import Material
import Alamofire
import SwiftyJSON
import MBProgressHUD

class ViewController: UIViewController {

    @IBOutlet var arabicView: UIStackView!
    @IBOutlet var englishView: UIStackView!
    @IBOutlet var joinNowBtn: UIButton!
    @IBOutlet var signInBtn: UIButton!
    @IBOutlet var passwordField: TextField!
    @IBOutlet var emailField: ErrorTextField!
    var GroupsModelDetails : [GroupsModel] = []

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        let lang_code = UserDefaults.standard.value(forKey: "lang_code")as? String
        if lang_code == "ar" {
            self.langChange(strLan: "ar")
            self.arabicView.isHidden = false
            self.englishView.isHidden = true
            self.emailField.textAlignment = .right
            self.passwordField.textAlignment = .right

        }else{
            self.langChange(strLan: "en")
            self.arabicView.isHidden = true
            self.englishView.isHidden = false
            self.emailField.textAlignment = .left
            self.passwordField.textAlignment = .left

        }
    }
    func langChange(strLan : String)
    {
        self.signInBtn.setTitle("signin".localizableString(loc: strLan), for: .normal)
        
        let attributes = [
            NSAttributedString.Key.foregroundColor: UIColor.white.withAlphaComponent(0.4),
            NSAttributedString.Key.font : UIFont(name: "Oswald-Regular", size: 15)!
        ]
        emailField.attributedPlaceholder = NSAttributedString(string: "Email".localizableString(loc: strLan),
                                     attributes: attributes)
        passwordField.attributedPlaceholder = NSAttributedString(string: "Password".localizableString(loc: strLan),
                                     attributes: attributes)
        
        
//        emailField.attributedPlaceholder = NSAttributedString(string: "Email".localizableString(loc: strLan),
//                                     attributes: [NSAttributedString.Key.foregroundColor : UIColor.white.withAlphaComponent(0.4)])
//        passwordField.attributedPlaceholder = NSAttributedString(string: "Password".localizableString(loc: strLan),
//                                     attributes: [NSAttributedString.Key.foregroundColor : UIColor.white.withAlphaComponent(0.4)])

    }
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
    }

    @IBAction func ClickOnBack(_ sender: UIBarButtonItem)
    {
        self.navigationController?.popViewController(animated: true)
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        signInBtn.roundCorners([ .bottomRight, .topLeft], radius: 30)

        self.navigationController?.navigationBar.tintColor = UIColor.white
        
        emailField.textColor = .white
        passwordField.textColor = .white
        
        // Do any additional setup after loading the view.
//               emailField.placeholder = "Email"
//               emailField.detail = "Error, incorrect email"
//               emailField.isClearIconButtonEnabled = true
//               emailField.delegate = self
//               emailField.isPlaceholderUppercasedWhenEditing = true
//               emailField.placeholderAnimation = .hidden
//
//        let leftView = UIImageView()
//        leftView.image = Icon.cm.audio
//        emailField.leftView = leftView
        
//        view.layout(emailField).center(offsetY: -passwordField.bounds.height - 60).left(20).right(20)
        
//        passwordField = TextField()
//        passwordField.placeholder = "Password"
//        passwordField.detail = "At least 8 characters"
//        passwordField.clearButtonMode = .whileEditing
//        passwordField.isVisibilityIconButtonEnabled = true
//        
//        // Setting the visibilityIconButton color.
//        passwordField.visibilityIconButton?.tintColor = Color.green.base.withAlphaComponent(passwordField.isSecureTextEntry ? 0.38 : 0.54)
        
//        view.layout(passwordField).center().left(20).right(20)
    }
    @IBAction func ClickOnForgotPassword(_ sender: UIButton)
    {
        /*if #available(iOS 13.0, *) {
            let vc = self.storyboard?.instantiateViewController(identifier: "forgotPassViewController")as! forgotPassViewController
            self.navigationController?.pushViewController(vc, animated: true)

        } else {
            let vc = self.storyboard?.instantiateViewController(withIdentifier: "forgotPassViewController")as! forgotPassViewController
            self.navigationController?.pushViewController(vc, animated: true)
            
        }*/
    }
    @IBAction func ClickOnSigninBtn(_ sender: UIButton)
    {
        if emailField.text == "" {
            
        }else if passwordField.text == "" {
            
        }else{
            UserDefaults.standard.setValue(self.emailField.text, forKey: "UserName")
            UserDefaults.standard.setValue(self.passwordField.text, forKey: "Password")
            UserDefaults.standard.synchronize()
            GetCurrentUserInfo()
        }
        
    }
    func GetCurrentUserInfo()
    {
        DispatchQueue.main.async {
            MBProgressHUD.showAdded(to: self.view, animated: true)
        }

        GroupsModelDetails.removeAll()
        let urlString = URL(string:MyStrings().BASEURL1 + "_api/web/currentuser/?$select=Title,Groups/Title&$expand=groups")!
        print(urlString)
        let networkProcessor = NetworkProcessor(url: urlString)
        networkProcessor.downloadJSONFromURL2 { (passdata) in
            DispatchQueue.main.async {
                MBProgressHUD.hide(for: self.view, animated: true)
            }
            let json1 = JSON(passdata)
            print("CurrentUserInfoJson : \(json1)")
            let d = json1["d"]
            let json = d["Groups"]
            let result = json["results"]
            for (index,subJson):(String, JSON) in result {
                print(index)
                print("subJson: \(subJson)")
                let details = GroupsModel.init(json: subJson)
                self.GroupsModelDetails.append(details)
            }
            let groupName = self.GroupsModelDetails[0].Title
            print("groupName: \(groupName)")
            UserDefaults.standard.set(groupName, forKey: "GroupName")
            UserDefaults.standard.synchronize()
            
            DispatchQueue.main.async {
                if #available(iOS 13.0, *) {
                    let vc = self.storyboard?.instantiateViewController(identifier: "MainAdminViewController")as! MainAdminViewController

                    self.navigationController?.pushViewController(vc, animated: false)

                } else {
                    let vc = self.storyboard?.instantiateViewController(withIdentifier: "MainAdminViewController")as! MainAdminViewController

                    self.navigationController?.pushViewController(vc, animated: false)
                    
                }
            }
        }
        
        
    }

    
    @IBAction func ClickOnJoinNowBtn(_ sender: UIButton)
    {
        /*if #available(iOS 13.0, *) {
            let vc = self.storyboard?.instantiateViewController(identifier: "registerViewController")as! registerViewController
            self.navigationController?.pushViewController(vc, animated: true)

        } else {
            let vc = self.storyboard?.instantiateViewController(withIdentifier: "registerViewController")as! registerViewController
            self.navigationController?.pushViewController(vc, animated: true)
            
        }*/
    }
    

}
extension ViewController: TextFieldDelegate {
    public func textFieldDidEndEditing(_ textField: UITextField) {
        (textField as? ErrorTextField)?.isErrorRevealed = false
    }
    
    public func textFieldShouldClear(_ textField: UITextField) -> Bool {
        (textField as? ErrorTextField)?.isErrorRevealed = false
        return true
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        (textField as? ErrorTextField)?.isErrorRevealed = true
        return true
    }
}

