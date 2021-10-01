//
//  MainAdminViewController.swift
//  FMAC
//
//  Created by MicroExcel on 6/15/21.
//  Copyright © 2021 Fujairah. All rights reserved.
//

import UIKit
import WebKit

class MainAdminViewController: UIViewController,WKNavigationDelegate {
    var webView : WKWebView!
    var username: String? = "Testuser2@microexcel.ae"
    var password: String? = "EgoV@Adm21@#$%"
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "My Requests"
        // Do any additional setup after loading the view.
        //https://fmac.fujairah.ae/en/pages/admin/AdminList.aspx?Source=RegistrationApproval
        let myBlog = MyStrings().BASEURL1 + "en/pages/admin/AdminList.aspx?Source=RegistrationApproval"
        let url = NSURL(string: myBlog)
            let request = NSURLRequest(url: url! as URL)

            // init and load request in webview.
            webView = WKWebView(frame: self.view.frame)
            webView.navigationDelegate = self
            webView.load(request as URLRequest)
            self.view.addSubview(webView)
        self.view.sendSubviewToBack(webView)
    }
    //MARK:- WKNavigationDelegate

    private func webView(webView: WKWebView, didFailProvisionalNavigation navigation: WKNavigation!, withError error: NSError) {
    print(error.localizedDescription)
    }


    func webView(_ webView: WKWebView, didStartProvisionalNavigation navigation: WKNavigation!) {
    print("Strat to load")
        }

    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
    print("finish to load")
    }
    
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
                let file_der = Bundle.main.path(forResource: "686fe82cf0ae7206", ofType: "crt")

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

}
