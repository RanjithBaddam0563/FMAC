//
//  detailAchivementViewController.swift
//  FMAC
//
//  Created by MicroExcel on 4/10/21.
//  Copyright © 2021 Fujairah. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON
import MBProgressHUD
import DropDown

class detailAchivementViewController: UIViewController {
    var imgArray = [String]()

    var from : String = ""
    var fromImg : String = ""

    
    @IBOutlet var dateLbl: UILabel!
    @IBOutlet var txtLbl: UILabel!
    var newsTitle : String = ""
    var newsDateTitle : String = ""
    var newsDes: String = ""

    @IBOutlet var contentTxtLbl: UILabel!
    @IBOutlet var collectionView: UICollectionView!
    
    override func viewWillAppear(_ animated: Bool)
    {
        let lang_code = UserDefaults.standard.value(forKey: "lang_code")as? String
        if lang_code == "ar" {
            self.langChange(strLan: "ar")
            self.contentTxtLbl.textAlignment = .right
            self.txtLbl.textAlignment = .right
            self.dateLbl.textAlignment = .right

        }else{
            self.langChange(strLan: "en")
            self.contentTxtLbl.textAlignment = .left
            self.txtLbl.textAlignment = .left
            self.dateLbl.textAlignment = .left

        }
    }
    func langChange(strLan : String)
    {
//        self.contentTxtLbl.text = "DetailedNewsContent".localizableString(loc: strLan)

    }
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = newsTitle
        self.imgArray.append(fromImg)
        self.txtLbl.text = newsTitle
        self.dateLbl.text = newsDateTitle
        self.contentTxtLbl.text = newsDes
    
       
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
extension detailAchivementViewController : UICollectionViewDataSource,UICollectionViewDelegate,UICollectionViewDelegateFlowLayout
{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if imgArray.count == 0 {
            return 0
        }else{
            return imgArray.count
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "DetailedNewsCollectionViewCell1", for: indexPath)as! DetailedNewsCollectionViewCell
        
        let imgTxt = self.fromImg
        print("imgTxt url \(imgTxt)")
        let combine =  MyStrings().BASEURL1 + imgTxt
        print("combine url \(combine)")
        let urlString = combine.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)
        if let urls = URL(string: urlString!)
        {
            DispatchQueue.main.async {
                cell.newsImg.kf.indicatorType = .activity
                cell.newsImg.kf.setImage(with: urls, placeholder: UIImage(named: "download1"), options: nil, progressBlock: nil, completionHandler: nil)
            }

        }else{
            
        }
//        cell.newsImg.image = UIImage.init(named: self.imgArray[indexPath.item])
      
        
        return cell
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: self.collectionView.frame.width, height: self.collectionView.frame.height)
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets.zero
    }
    

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
        
    }
    
    
    
}
