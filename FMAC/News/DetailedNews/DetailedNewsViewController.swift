//
//  DetailedNewsViewController.swift
//  FMAC
//
//  Created by MicroExcel on 3/17/21.
//  Copyright © 2021 Fujairah. All rights reserved.
//

import UIKit

class DetailedNewsViewController: UIViewController {
    var imgArray = ["news1","news2","news3","news4","news5","news6","news7"]
    var SendDecodedUrlPaths = [String]()

    var from : String = ""
    var fromImg : String = ""

    var DescriptionText : String = ""
    
    var newsTitle : String = ""
    var newsDateTitle : String = ""

    @IBOutlet var contentTxtLbl: UILabel!
    @IBOutlet var collectionView: UICollectionView!
    
    override func viewWillAppear(_ animated: Bool)
    {
        self.contentTxtLbl.text = self.DescriptionText
        let lang_code = UserDefaults.standard.value(forKey: "lang_code")as? String
        if lang_code == "ar" {
            self.langChange(strLan: "ar")
            self.contentTxtLbl.textAlignment = .right
        }else{
            self.langChange(strLan: "en")
            self.contentTxtLbl.textAlignment = .left
        }
    }
    func langChange(strLan : String)
    {

    }
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = newsTitle
        if from == "Achive" {
            self.imgArray.removeAll()
            self.imgArray.append(fromImg)
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
extension DetailedNewsViewController : UICollectionViewDataSource,UICollectionViewDelegate,UICollectionViewDelegateFlowLayout
{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if SendDecodedUrlPaths.count == 0 {
            return 0
        }else{
            return SendDecodedUrlPaths.count
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "DetailedNewsCollectionViewCell", for: indexPath)as! DetailedNewsCollectionViewCell
        let lang_code = UserDefaults.standard.value(forKey: "lang_code")as? String
        if lang_code == "ar" {
            cell.newsTitleLbl.textAlignment  = .right
            cell.newsDateLbl.textAlignment  = .right
        }else{
            cell.newsTitleLbl.textAlignment  = .left
            cell.newsDateLbl.textAlignment  = .left
        }
        let imgTxt = self.SendDecodedUrlPaths[indexPath.item]
        let combine = MyStrings().BASEURL1 + imgTxt
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
        cell.newsTitleLbl.text = newsTitle
        cell.newsDateLbl.text = newsDateTitle
        
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

