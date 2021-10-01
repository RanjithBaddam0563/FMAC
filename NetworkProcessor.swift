//
//  NetworkProcessor.swift
//  ADDSICDISTARER
//
//  Created by Mahesh on 04/10/19.
//  Copyright © 2019 Microexcel. All rights reserved.
//

import Foundation
import Alamofire
import SwiftyJSON
import UIKit


class NetworkProcessor:NSObject {

    var username: String? = "Testuser2@microexcel.ae"
    var password: String? = "EgoV@Adm21@#$%"
    //    username = "microcom\\spsetup"
    //    password = "$9$3tu9"
    
    lazy var conn: URLSession = {
        let config = URLSessionConfiguration.ephemeral
        let session = URLSession(configuration: config, delegate: self , delegateQueue: nil)
        return session
    }()
    let url:URL
    init(url:URL) {
        self.url = url
        print("self.url data: \(self.url)")
    }
    
    typealias JSONDictionaryHandler = ((Data) -> Void)

    func downloadJSONFromURL1(_ completion: @escaping JSONDictionaryHandler) {
       
        let request = NSMutableURLRequest(url: self.url, cachePolicy: .reloadIgnoringLocalCacheData, timeoutInterval: 60000)
        request.httpMethod = "POST"
        request.addValue("application/json;odata=verbose", forHTTPHeaderField:"Accept")
        request.addValue("WSS_KeepSessionAuthenticated={a554e787-3261-4006-9895-ab6c35426258}", forHTTPHeaderField: "Cookie")
        request.addValue("text/xml", forHTTPHeaderField: "Content-Type")
        
        let dataTask = conn.dataTask(with: request as URLRequest) { (data, response, error) in
            print(error)
            print(response)
            
            if error == nil{
                if let httpResponse = response as? HTTPURLResponse{
                    switch httpResponse.statusCode {
                    case 200:
                        
                        // sucessful response
                        if let data = data{
                            do {
                                let jsonDictionary = try JSONSerialization.jsonObject(with:
                                    data, options: [])
                                completion(data)
                              

                                
                            }catch let error as NSError {
                                print("Error processing json data: \(error.localizedDescription)")
                                
                            }
 
                        }
                     
                    default:
                        print("HTTP Response code:\(httpResponse.statusCode)")
//                        let error = try completion1("Server connection down")
                       
                    
                    
                       
                    }
                }
                
            }else{
                print("Error:\(error?.localizedDescription)")
                
                
            }
            
        }
        
      dataTask.resume()
    }
    
    func downloadJSONFromURL(_ completion: @escaping JSONDictionaryHandler) {
       
        let request = NSMutableURLRequest(url: self.url, cachePolicy: .reloadIgnoringLocalCacheData, timeoutInterval: 60000)
        request.httpMethod = "GET"
        request.addValue("application/json;odata=verbose", forHTTPHeaderField:"Accept")


        let dataTask = conn.dataTask(with: request as URLRequest) { (data, response, error) in
            print(error)
            print(response)
            if error == nil{
                if let httpResponse = response as? HTTPURLResponse{
                    switch httpResponse.statusCode {
                    case 200:
                        // sucessful response
                        if let data = data{
                            do {
                                let jsonDictionary = try JSONSerialization.jsonObject(with:
                                    data, options: [])
                                completion(data)
                              

                                
                            }catch let error as NSError {
                                print("Error processing json data: \(error.localizedDescription)")
                            }
 
                        }
                    default:
                        print("HTTP Response code:\(httpResponse.statusCode)")
                        
                        
                    }
                }
                
            }else{
                print("Error:\(error?.localizedDescription)")
                
            }
            
        }
        
      dataTask.resume()
    }
    
    
    func downloadJSONFromURL2(_ completion: @escaping JSONDictionaryHandler) {
       
        let request = NSMutableURLRequest(url: self.url, cachePolicy: .reloadIgnoringLocalCacheData, timeoutInterval: 60000)
        request.addValue("application/json;odata=verbose", forHTTPHeaderField: "Accept")
        request.addValue("application/json;odata=verbose", forHTTPHeaderField: "Content-Type")
        let FormDigestValue =  UserDefaults.standard.string(forKey: "FormDigestValue")
        print("FormDigestValuePost:\(FormDigestValue)")
        request.addValue(FormDigestValue!, forHTTPHeaderField: "X-RequestDigest")
        request.addValue("WSS_KeepSessionAuthenticated={a554e787-3261-4006-9895-ab6c35426258}", forHTTPHeaderField: "Cookie")

//        request.addValue("WSS_KeepSessionAuthenticated={a554e787-3261-4006-9895-ab6c35426258}", forHTTPHeaderField: "Cookie")
        request.httpMethod = "POST"

        let dataTask = conn.dataTask(with: request as URLRequest) { (data, response, error) in
            print("error:\(error)")
            print("response:\(response)")
            if error == nil{
                if let httpResponse = response as? HTTPURLResponse{
                    switch httpResponse.statusCode {
                    case 200:
                        // sucessful response
                        if let data = data{
                            do {
                                let jsonDictionary = try JSONSerialization.jsonObject(with:
                                data, options: [])
                                
                                completion(data)
                              

                                
                            }catch let error as NSError {
                                print("Error processing json data: \(error.localizedDescription)")
                            }
 
                        }
                     
                    default:
                        print("HTTP Response code:\(httpResponse.statusCode)")
                        
                    }
                }
                
            }else{
                print("Error:\(error?.localizedDescription)")
                
                
            }
            
        }
        
      dataTask.resume()
    }
    
    func downloadJSONFromURL3(params: [String : Any], _ completion: @escaping JSONDictionaryHandler) {
       
        let request = NSMutableURLRequest(url: self.url, cachePolicy: .reloadIgnoringLocalCacheData, timeoutInterval: 60000)
        request.addValue("application/json;odata=verbose", forHTTPHeaderField: "Accept")
        request.addValue("application/json;odata=verbose", forHTTPHeaderField: "Content-Type")
        let FormDigestValue =  UserDefaults.standard.string(forKey: "FormDigestValue")
        print("FormDigestValuePost:\(FormDigestValue)")
        request.addValue(FormDigestValue!, forHTTPHeaderField: "X-RequestDigest")
        request.addValue("WSS_KeepSessionAuthenticated={a554e787-3261-4006-9895-ab6c35426258}", forHTTPHeaderField: "Cookie")
//        let params = ["__metadata": ["type":"SP.Data.RegistrationsListItem"],"Address":"tesfirstios","BranchId":"2","CardNumber":"4558596","DateOfBirth":"2014-06-24T21:46:22","Email":"abc@gmail.com","EmiratesId":"4558595","EndorsementDate":"2021-06-08T11:08:51","Fees":"0","Gender":"Male","Mobile":"59595958595","NationalityId":"3","PlayerName":"test1","RegistrationStatus":"Registered","SocialCategoryId":"2","SportId":"2","YearOfBirth":"2014"] as [String : Any]
        guard let httpBody = try? JSONSerialization.data(withJSONObject: params, options: []) else {
               return
           }
        request.httpBody = httpBody
//        request.addValue("WSS_KeepSessionAuthenticated={a554e787-3261-4006-9895-ab6c35426258}", forHTTPHeaderField: "Cookie")
        request.httpMethod = "POST"

        let dataTask = conn.dataTask(with: request as URLRequest) { (data, response, error) in
            print("error:\(error)")
            print("response:\(response)")
            if error == nil{
                if let httpResponse = response as? HTTPURLResponse{
                    switch httpResponse.statusCode {
                    case 201:
                        // sucessful response
                        if let data = data{
                            do {
                                let jsonDictionary = try JSONSerialization.jsonObject(with:
                                    data, options: [])
                                completion(data)
                              

                                
                            }catch let error as NSError {
                                print("Error processing json data: \(error.localizedDescription)")
                            }
 
                        }
                     
                    default:
                        print("HTTP Response code:\(httpResponse.statusCode)")
                        
                    }
                }
                
            }else{
                print("Error:\(error?.localizedDescription)")
                
                
            }
            
        }
        
      dataTask.resume()
    }
    func downloadJSONFromURL4(params: Data? = nil, filename : URL,image: UIImage, _ completion: @escaping JSONDictionaryHandler) {
       
        let request = NSMutableURLRequest(url: self.url, cachePolicy: .reloadIgnoringLocalCacheData, timeoutInterval: 60000)
        request.addValue("application/json;odata=verbose", forHTTPHeaderField: "Accept")
//        request.addValue("application/json;odata=verbose", forHTTPHeaderField: "Content-Type")
        let FormDigestValue =  UserDefaults.standard.string(forKey: "FormDigestValue")
        print("FormDigestValuePost:\(FormDigestValue)")
        request.addValue(FormDigestValue!, forHTTPHeaderField: "X-RequestDigest")
//        request.addValue("WSS_KeepSessionAuthenticated={a554e787-3261-4006-9895-ab6c35426258}", forHTTPHeaderField: "Cookie")
        
        
//        let fileURL = URL (fileURLWithPath: filename)
//        print("fileURL : \(fileURL)")
//        let fileData = try Data (contentsOf: fileURL)
//        multipartFormData.append(self.GetfileData, withName: "TrainingFile", fileName:
//                                       self.GetfileName, mimeType: "application/pdf")

//        
//        do {
//            let fileData =  try Data (contentsOf: filename)
//            let imageString = params!.base64EncodedString ()
//            let postData = imageString.data(using: .utf8)
////            let imageSData = Data(base64Encoded: imageString)!
//            print("postData : \(postData)")
//            print("paramsData : \(params)")
//
//            request.httpBody = postData
//
//        } catch let err {
//            print("err:\(err)")
//        }
        

        
//        let base64Encoded = params!
//            .base64EncodedString(options: [])
//            .addingPercentEncoding(withAllowedCharacters: .urlQueryValueAllowed)!
//            .data(using: String.Encoding.utf8)!
//
//        var body = "key=".data(using: .utf8)!
//        body.append(base64Encoded)
        //       guard let httpBody = try? JSONSerialization.data(withJSONObject: para, options: []) else {
        //               return
        //           }
//        do {
//            request.httpBody = try JSONSerialization.data(withJSONObject: body, options: .prettyPrinted)
//        } catch let error {
////            errorCompletion(error)
//            return
//        }
//        request.setValue("application/x-www-form-urlencoded", forHTTPHeaderField: "Content-Type")
//        request.httpMethod = "POST"
        
        
//        let para = params.base64EncodedString()

//        let parameters = params!.base64EncodedString(options: .lineLength64Characters)
//        let postData = parameters.data(using: .utf8)

//
//
//        let base64Encoded = params
//            .base64EncodedString(options: [])
//            .addingPercentEncoding(withAllowedCharacters: .urlQueryValueAllowed)!
//            .data(using: String.Encoding.utf8)!
//
//        var body = "AttachmentFiles=".data(using: .utf8)!
//        body.append(base64Encoded)
//        let makeRandom = { UInt32.random(in: (.min)...(.max)) }
        let boundary = UUID().uuidString
//        var data = Data("--\(boundary)\r\n".utf8)
//        data += Data("Content-Disposition: form-data; name=file; filename=\"\(filename)\"\r\n".utf8)
//        data += Data("Content-Type: octet-stream\r\n\r\n".utf8)
//        if let body = params { data += body }
//        data += Data("\r\n".utf8)
//        data += Data("--\(boundary)--\r\n".utf8)
        
//        var data = params
//        var body = params

//        let filename = "user-profile.jpg"
//                        let mimetype = "image/jpg"
//
//                        body.append("--\(boundary)\r\n")
//                        body.append("Content-Disposition: form-data; name=\"\(filename!)\"; filename=\"\(filename)\"\r\n")
//                        body.append("Content-Type: \(mimetype)\r\n\r\n")
//                        body.append(params)
//                        body.append("\r\n")
        
        
        // Add the image data to the raw http request data
//            data!.append("\r\n--\(boundary)\r\n".data(using: .utf8)!)
//            data!.append("Content-Disposition: form-data; name=\"\(filename)\"; filename=\"\("Visa.jpg")\"\r\n".data(using: .utf8)!)
//            data!.append("Content-Type: \(mimetype)\r\n\r\n".data(using: .utf8)!)
//        data!.append(image.jpegData(compressionQuality: 1)!)
//        data!.append(params!)
//        data!.append("\r\n".data(using: .utf8)!)
//        data!.append("\r\n--\(boundary)\r\n".data(using: .utf8)!)
        

        
//       guard let httpBody = try? JSONSerialization.data(withJSONObject: para, options: []) else {
//               return
//           }
//        request.httpBody = body
//        request.httpMethod = "POST"
//        let headers = [
//            "Content-Type":"application/json",
//            "X-RequestDigest":"0xB10EF1E6817510815507FD20188140592B03B748B1F4CF87CD8DD3A4A445A9E13346943F59CA45A230145D03EEE6431DCB43C2D7DB3E3151EEE9AE7DC109DC8C,13 Jun 2021 09:25:00 -0000",
//            "Accept" : "application/json;odata=verbose",
//            "Cookie" : "WSS_KeepSessionAuthenticated={a554e787-3261-4006-9895-ab6c35426258}",
//            "Authorization" : "Basic ZnVqZ292XGZtYWNhZG06RWdvVkBBZG0yMUAjJCU="
//        ]
//        let yourData = params
//        let endPoint =  URL(string:MyStrings().BASEURL1 + "_api/web/lists/getbytitle(%27Registrations%27)/items(%27138%27)/AttachmentFiles/add(FileName=%27Visa.jpg%27")!
//
//        Alamofire.upload(yourData!, to: "\(endPoint)", headers: headers)
//            .validate(statusCode: 200..<300)
//            .responseJSON { response in
//                // handle response
//                print("AlamofireRes : \(response)")
//
//            }
        
//        let subscriptionKey = "YOUR-KEY"
        let image = #imageLiteral(resourceName: "news4")
        let imageData  = image.jpegData(compressionQuality: 1.0)!

//        let endpoint = ("https://westus.api.cognitive.microsoft.com/vision/v1.0/analyze?visualFeatures=Description,Categories,Tags")
//
//        let requestURL = URL(string: endpoint)!
//        let session = URLSession(configuration: URLSessionConfiguration.default)
//        var request:URLRequest = URLRequest(url: requestURL)
        request.httpMethod = "POST"
        request.addValue("application/octet-stream", forHTTPHeaderField: "Content-Type")
//        request.addValue(subscriptionKey, forHTTPHeaderField: "Ocp-Apim-Subscription-Key")
        request.httpBody = imageData

        var semaphore = DispatchSemaphore.init(value: 0);

//        let task = session.dataTask(with: request) { (data, response, error) in
//            guard let data = data, error == nil else { return }
//            do {
//                let json = try JSONSerialization.jsonObject(with: data, options: .allowFragments) as! [String:Any]
//                print("Response \(json)")
//            } catch let error as Error {
//                print("Error \(error)")
//            }
//            semaphore.signal()
//        }
//
//        task.resume()
//        semaphore.wait()
        
        
        
        
        let dataTask = conn.dataTask(with: request as URLRequest) { (data, response, error) in
            print("error:\(error)")
            print("response:\(response)")
            if error == nil{
                if let httpResponse = response as? HTTPURLResponse{
                    switch httpResponse.statusCode {
                    case 201:
                        // sucessful response
                        if let data = data{
                            do {
                                let jsonDictionary = try JSONSerialization.jsonObject(with:
                                    data, options: [])
                                completion(data)
                              

                                
                            }catch let error as NSError {
                                print("Error processing json data: \(error.localizedDescription)")
                            }
 
                        }
                     
                    default:
                        print("HTTP Response code:\(httpResponse.statusCode)")
                        
                    }
                }
                
            }else{
                print("Error:\(error?.localizedDescription)")
                
                
            }
            
        }
        
      dataTask.resume()
    }
    
//    func sendFile(
//        urlPath:String,
//        fileName:String,
//        data:NSData,
//        completionHandler: (URLResponse?, NSData?, NSError?) -> Void){
//
//            var url: NSURL = NSURL(string: urlPath)!
//        var request1: NSMutableURLRequest = NSMutableURLRequest(url: url as URL)
//
//            request1.httpMethod = "POST"
//
//            let boundary = UUID().uuidString
//        let fullData = photoDataToFormData(data: data,boundary:boundary,fileName:fileName)
//
//            request1.setValue("multipart/form-data; boundary=" + boundary,
//                forHTTPHeaderField: "Content-Type")
//
//            // REQUIRED!
//            request1.setValue(String(fullData.length), forHTTPHeaderField: "Content-Length")
//
//        request1.httpBody = fullData as Data
//        request1.httpShouldHandleCookies = false
//
//        let queue:OperationQueue = OperationQueue()
//
//            NSURLConnection.sendAsynchronousRequest(
//                request1 as URLRequest,
//                queue: queue,
//                completionHandler:completionHandler)
//    }

    // this is a very verbose version of that function
    // you can shorten it, but i left it as-is for clarity
//    // and as an example
//    func photoDataToFormData(data:NSData,boundary:String,fileName:String) -> NSData {
//        var fullData = NSMutableData()
//
//        // 1 - Boundary should start with --
//        let lineOne = "--" + boundary + "\r\n"
//        fullData.append(lineOne.data(
//                            using: String.Encoding.utf8,
//            allowLossyConversion: false)!)
//
//        // 2
//        let lineTwo = "Content-Disposition: form-data; name=\"image\"; filename=\"" + fileName + "\"\r\n"
//        NSLog(lineTwo)
//        fullData.append(lineTwo.data(
//                            using: String.Encoding.utf8,
//            allowLossyConversion: false)!)
//
//        // 3
//        let lineThree = "Content-Type: image/jpeg\r\n\r\n"
//        fullData.append(lineThree.data(
//                            using: String.Encoding.utf8,
//            allowLossyConversion: false)!)
//
//        // 4
//        fullData.append(data as Data)
//
//        // 5
//        let lineFive = "\r\n"
//        fullData.append(lineFive.data(
//                            using: String.Encoding.utf8,
//            allowLossyConversion: false)!)
//
//        // 6 - The end. Notice -- at the start and at the end
//        let lineSix = "--" + boundary + "--\r\n"
//        fullData.append(lineSix.data(
//                            using: String.Encoding.utf8,
//            allowLossyConversion: false)!)
//
//        return fullData
//    }
    
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
extension NetworkProcessor: URLSessionDelegate {
    func urlSession(_ session: URLSession, didReceive challenge: URLAuthenticationChallenge, completionHandler: @escaping (URLSession.AuthChallengeDisposition, URLCredential?) -> Void) {
        
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
            print("cert1 : \(cert1)")
            print("cert2 : \(cert2)")
        if cert1.isEqual(to: cert2 as Data) { completionHandler(URLSession.AuthChallengeDisposition.useCredential, URLCredential(trust:serverTrust))
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
}
extension CharacterSet {
    static let urlQueryValueAllowed: CharacterSet = {
        let generalDelimitersToEncode = ":#[]@" // does not include "?" or "/" due to RFC 3986 - Section 3.4
        let subDelimitersToEncode = "!$&'()*+,;="

        var allowed = CharacterSet.urlQueryAllowed
        allowed.remove(charactersIn: generalDelimitersToEncode + subDelimitersToEncode)
        return allowed
    }()
}
