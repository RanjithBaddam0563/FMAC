//
//  registerViewController.swift
//  FMAC
//
//  Created by MicroExcel on 1/8/21.
//  Copyright © 2021 Fujairah. All rights reserved.
//

import UIKit
import SwiftyJSON

class registerViewController: UIViewController {
    @IBOutlet weak var TBV: UITableView!

    var titleArray = [String]()
    var DettitleArray = [String]()

    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        var semaphore = DispatchSemaphore (value: 0)

        var request = URLRequest(url: URL(string: "https://microexcelae.sharepoint.com/sites/FMAC/_api/web/lists/GetByTitle(%27Branches%27)/items")!,timeoutInterval: Double.infinity)
        request.httpMethod = "GET"

        let task = URLSession.shared.dataTask(with: request) { data, response, error in
          guard let data = data else {
            print(String(describing: error))
            return
          }
          print(String(data: data, encoding: .utf8)!)
            let xmlStr = String(data: data, encoding: .utf8)!
            let parser = ParseXMLData(xml: xmlStr)
            let jsonStr = parser.parseXML()
            print(jsonStr)
            let data1: Data? = jsonStr.data(using: .utf8)
//            let json1 = (try? JSONSerialization.jsonObject(with: data1!, options: [])) as? [String:AnyObject]
//             print(json1 ?? "Empty Data")
            let json = JSON.init(parseJSON:String(data: data1!, encoding: .utf8)!)
            print(json)
             for (index,subJson):(String, JSON) in json {
                    print(index)
                    print(subJson)
//                let entry = subJson["entry"]
//                print(entry)
//                let arrayNames =  entry["link"].arrayValue.map {$0["_rel"].stringValue}
//                let arrayNames1 =  entry["link"].arrayValue.map {$0["_title"].stringValue}
//
//                self.titleArray = arrayNames1
//                self.DettitleArray = arrayNames

               
             }
          semaphore.signal()
        }

        task.resume()
        semaphore.wait()
        
    }
 

}
extension registerViewController: UITableViewDataSource,UITableViewDelegate {


func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
{
    if self.titleArray.count == 0
    {
        return 0
    }else{
        
        return self.titleArray.count
    }
}

func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
{
    
    let cell = self.TBV.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
    cell.textLabel?.text = self.titleArray[indexPath.row]
    cell.detailTextLabel?.text = self.DettitleArray[indexPath.row]
    return cell
}


func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
    return UITableView.automaticDimension
}
func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
    return 500
}
   
   
}
