//
//  NewAdminLoginViewController.swift
//  FMAC
//
//  Created by MicroExcel on 6/6/21.
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
import WebKit


class NewAdminLoginViewController: LGSideMenuController,UIGestureRecognizerDelegate,WKUIDelegate,WKNavigationDelegate {
    @IBOutlet weak var AlphaView: UIView!
    var username: String? = "Testuser2@microexcel.ae"
    var password: String? = "EgoV@Adm21@#$%"
    var webView: WKWebView!

    var fileUrlStr : String = ""


    override func viewWillAppear(_ animated: Bool) {
        self.AlphaView.isHidden = true
        hideLeftView(animated: false, completionHandler: nil)
        self.tabBarController?.tabBar.isHidden = true
    }
//    override func loadView() {
//          super.loadView()
//        let webView = WKWebView(frame: .zero, configuration: WKWebViewConfiguration())
//        view.addSubview(webView)
//        self.webView = webView
//          webView.uiDelegate = self
//          webView.navigationDelegate = self
////          view = webView
//      }
    override func viewDidLoad() {
        super.viewDidLoad()

//        self.view.addSubview(AlphaView)
        let lang_code = UserDefaults.standard.value(forKey: "lang_code")as? String
        if lang_code == "ar" {
            fileUrlStr = MyStrings().BASEURL1 + "ar/pages/admin/AdminList.aspx?Source=RegistrationApproval"
        }else{
            fileUrlStr = MyStrings().BASEURL1 + "en/pages/admin/AdminList.aspx?Source=RegistrationApproval"
        }
        let url = NSURL(string: fileUrlStr)
            let request = NSURLRequest(url: url! as URL)

            // init and load request in webview.
            webView = WKWebView(frame: self.view.frame)
            webView.navigationDelegate = self
            webView.load(request as URLRequest)
            self.view.addSubview(webView)
//        self.view.sendSubviewToBack(webView)
        
//        if let url = URL(string: fileUrlStr) {
//            print(url)
//            let request = URLRequest(url: url)
//            DispatchQueue.main.async {
//                self.webView.load(request)
//            }
//
//        }else{
//            print("Nil")
//        }
        
        //SideMenuCode
        let left = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "sideMenuAdminViewController") as? sideMenuAdminViewController
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
   

    @IBAction func ClickOnLogoutBtn(_ sender: Any)
    {
        let alert = UIAlertController(title: "My alert", message: "Are you sure you want to logout?", preferredStyle: UIAlertController.Style.alert)

        // add the actions (buttons)
        alert.addAction(UIAlertAction(title: "Yes", style: UIAlertAction.Style.default, handler: {
            (result : UIAlertAction) -> Void in
//            UserDefaults.standard.removeObject(forKey: "UserName")
           
            if #available(iOS 13.0, *) {
             let vc = self.storyboard?.instantiateViewController(identifier: "forgotPassViewController")as! forgotPassViewController

             self.navigationController?.pushViewController(vc, animated: true)

             } else {
                 let vc = self.storyboard?.instantiateViewController(withIdentifier: "forgotPassViewController")as! forgotPassViewController

                 self.navigationController?.pushViewController(vc, animated: true)

            }

        }))
        alert.addAction(UIAlertAction(title: "No", style: UIAlertAction.Style.destructive, handler: nil))

        // show the alert
        self.present(alert, animated: true, completion: nil)
    }
    
//    func webView(_ webView: WKWebView, didReceive challenge: URLAuthenticationChallenge, completionHandler: @escaping (URLSession.AuthChallengeDisposition, URLCredential?) -> Void) {
//
//            let user = UserDefaults.standard.string(forKey: "UserName")
//            let password = UserDefaults.standard.string(forKey: "Password")
//            let credential = URLCredential(user: user!, password: password!, persistence: URLCredential.Persistence.forSession)
//            challenge.sender?.use(credential, for: challenge)
//            completionHandler(URLSession.AuthChallengeDisposition.useCredential, credential)
//    }
    func webView(_ webView: WKWebView, didReceive challenge: URLAuthenticationChallenge, completionHandler: @escaping (URLSession.AuthChallengeDisposition, URLCredential?) -> Void) {
//        let user = UserDefaults.standard.string(forKey: "UserName")
//        let newstr = "\\" + user!
//        print(newstr)
//        let sliced = String(newstr.dropFirst()) // ello
//        print("sliced: \(sliced)")
//        let password = UserDefaults.standard.string(forKey: "Password")
//        print("password :\(password)")
//        let credential = URLCredential(user: sliced, password: password!, persistence: URLCredential.Persistence.forSession)
//        completionHandler(URLSession.AuthChallengeDisposition.useCredential, credential)
        
            
            guard challenge.previousFailureCount == 0 else {
                print("too many failures")
                challenge.sender?.cancel(challenge)
                completionHandler(.cancelAuthenticationChallenge, nil)
                return
            }
            
    //        guard challenge.protectionSpace.authenticationMethod == NSURLAuthenticationMethodNTLM else {
    //               print("unknown authentication method \(challenge.protectionSpace.authenticationMethod)")
    //               challenge.sender?.cancel(challenge)
    //               completionHandler(.cancelAuthenticationChallenge, nil)
    //               return
    //           }
            
            if (challenge.protectionSpace.authenticationMethod == NSURLAuthenticationMethodServerTrust) {
                if let serverTrust = challenge.protectionSpace.serverTrust {
                var secresult = SecTrustResultType.invalid
                let status = SecTrustEvaluate(serverTrust, &secresult)

                if (errSecSuccess == status) {
                if let serverCertificate = SecTrustGetCertificateAtIndex(serverTrust, 0) {
                let serverCertificateData = SecCertificateCopyData(serverCertificate)
                let data = CFDataGetBytePtr(serverCertificateData);
                let size = CFDataGetLength(serverCertificateData);
                let cert1 = NSData(bytes: data, length: size)
                let file_der = Bundle.main.path(forResource: "wildcard_fujairah_ae", ofType: "pfx")

                if let file = file_der {
                if let cert2 = NSData(contentsOfFile: file) {
                if cert1.isEqual(to: cert2 as Data) {
                    print("too Succ")
                    completionHandler(URLSession.AuthChallengeDisposition.useCredential, URLCredential(trust:serverTrust))
                return
                }
                }
                }
                }
                }
                }
            
            }
            
            guard self.doesHaveCredentials() else {
                challenge.sender?.cancel(challenge)
                completionHandler(.cancelAuthenticationChallenge, nil)
                DispatchQueue.main.async {
                    print("Userdata not set")
                };
                return
            }
            self.username =  UserDefaults.standard.string(forKey: "UserName")
            self.password =  UserDefaults.standard.string(forKey: "Password")
            print("UserName\(self.username)")
            print("Password\(self.password)")

            let newstr = "\\" + self.username!
            print(newstr)
            let sliced = String(newstr.dropFirst()) // ello
            print(sliced)
            let credentials = URLCredential(user: sliced, password: self.password!, persistence: .forSession)
            challenge.sender?.use(credentials, for: challenge)
            completionHandler(.useCredential, credentials)
            
        
    }
    func doesHaveCredentials() -> Bool {
        self.username =  UserDefaults.standard.string(forKey: "UserName")
        self.password =  UserDefaults.standard.string(forKey: "Password")

        print("UserName\(self.username)")
        print("Password\(self.password)")

        let newstr = "\\" + self.username!
        print(newstr)
        self.username = String(newstr.dropFirst()) // ello
        print(self.username)
        guard let _ = self.username else { return false }
        guard let _ = self.password else { return false }
        return true
    }
    private func webView(webView: WKWebView, didFailProvisionalNavigation navigation: WKNavigation!, withError error: NSError) {
    print(error.localizedDescription)
    }


    func webView(_ webView: WKWebView, didStartProvisionalNavigation navigation: WKNavigation!) {
    print("Strat to load")
        }

    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
    print("finish to load")
    }


//    func webView( webView: WKWebView, didReceive challenge: URLAuthenticationChallenge, completionHandler: @escaping (URLSession.AuthChallengeDisposition, URLCredential?) -> Void) {
//        let user = UserDefaults.standard.string(forKey: "UserName")
//        let password = UserDefaults.standard.string(forKey: "Password")
//        let credential = URLCredential(user: user!, password: password!, persistence: URLCredential.Persistence.forSession)
//        challenge.sender?.use(credential, for: challenge)
//        completionHandler(URLSession.AuthChallengeDisposition.useCredential, credential)
//
//    }
   
}


    

