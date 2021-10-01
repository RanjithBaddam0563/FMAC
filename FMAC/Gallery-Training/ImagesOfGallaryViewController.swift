//
//  ImagesOfGallaryViewController.swift
//  FMAC
//
//  Created by MicroExcel on 5/24/21.
//  Copyright © 2021 Fujairah. All rights reserved.
//

import UIKit
import DropDown

import Alamofire
import SwiftyJSON
import MBProgressHUD
import Kingfisher

class ImagesOfGallaryViewController: UIViewController,UIGestureRecognizerDelegate,UITextFieldDelegate {
    var navTitleName : String = ""
    var typechecking : String = ""
    var TypeOfSportnameArray = [String]()
    var SelectYearArray = [String]()
    var typeOFSportName : String = ""
    var mainurlString : String = ""
    var TrainingModelFileDetails : [TrainingModelFiles] = []
    var IndexID = Int()
    var BaseURL : String = ""
    
    var fromIndex : String = ""

    let dropDownValues = ["Boxing", "Archery", "Fence","Judo", "Taekwondo","Karate","Wrestling"]
    let dropDownValues1 = ["2021", "2020", "2019","2018", "2017"]
    var PopUpImageIndex = Int()


    @IBOutlet var fullImgView: UIImageView!
    @IBOutlet var popUpView: UIView!
    @IBOutlet var AlphaView: UIView!
    @IBOutlet var forwardBtn: UIButton!
    @IBOutlet var backBtn: UIButton!
    var imgArray = ["news1","news2","news3","news4","news5","news6","news7","news1","news2"]

    @IBOutlet var collectionVw: UICollectionView!
    
    override func viewWillAppear(_ animated: Bool)
    {
        self.navigationController?.navigationBar.tintColor = .white

        
        let lang_code = UserDefaults.standard.value(forKey: "lang_code")as? String
        if lang_code == "ar" {
            self.langChange(strLan: "ar")
           

        }else{
            self.langChange(strLan: "en")
            
        }
    }
    func langChange(strLan : String)
    {
        if navTitleName == ""
        {
            self.navigationItem.title = "ChampionShips".localizableString(loc: strLan)
            GalleryDetails()
        }else{
        self.title = navTitleName
            GalleryDetails()

        }

        
        let attributes = [
            NSAttributedString.Key.foregroundColor: UIColor.white.withAlphaComponent(0.4),
            NSAttributedString.Key.font : UIFont(name: "Oswald-Regular", size: 15)!
        ]
        
        
        
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.fullImgView.enableZoom()
        backBtn.layer.cornerRadius = backBtn.frame.size.width/2
        backBtn.layer.borderColor = UIColor.white.cgColor
        backBtn.layer.borderWidth = 1.0
        forwardBtn.layer.cornerRadius = forwardBtn.frame.size.width/2
        forwardBtn.layer.borderColor = UIColor.white.cgColor
        forwardBtn.layer.borderWidth = 1.0

        //TapGestureCode
        let mytapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(myTapAction))
        mytapGestureRecognizer.numberOfTapsRequired = 1
        self.AlphaView.addGestureRecognizer(mytapGestureRecognizer)
        mytapGestureRecognizer.delegate = self as UIGestureRecognizerDelegate
        
       
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

    @objc func myTapAction(recognizer: UITapGestureRecognizer)
    {
        DispatchQueue.main.async {
            self.popUpView.isHidden = true
            self.AlphaView.isHidden = true
        }
        
    }
    func GalleryDetails()
    {
        if IndexID == 0 {
            self.BaseURL = MyStrings().TotalTrainingsGalleryImages_API
        }else if IndexID == 1 {
            self.BaseURL = MyStrings().TotalChampionshipsGalleryImages_API
        }else if IndexID == 2 {
            self.BaseURL = MyStrings().TotalCampsGalleryImages_API
        }else if IndexID == 3 {
            self.BaseURL = MyStrings().TotalConferencesGalleryImages_API
        }
        DispatchQueue.main.async {
            MBProgressHUD.showAdded(to: self.view, animated: true)
        }
//        GalleryModelDetails.removeAll()
//        GalleryModelFileDetails.removeAll()
        print("typeOFSportName\(typeOFSportName)")
        let urlString1 = typeOFSportName.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)
        if let urls = URL(string: urlString1!)
        {
            let ur = urls.absoluteString
            self.mainurlString = self.BaseURL + ur + "%27&$expand=File"
        }else{
            
        }
        print("self.mainurlString:\(mainurlString)")
        let networkProcessor = NetworkProcessor(url: URL(string: self.mainurlString)!)
        networkProcessor.downloadJSONFromURL { (passdata) in
            DispatchQueue.main.async {
                MBProgressHUD.hide(for: self.view, animated: true)
            }
            let json1 = JSON(passdata)
            print("json1: \(json1)")
            let d = json1["d"]
            let json = d["results"]
            for (index,subJson):(String, JSON) in json {
                print(index)
                print("subJson: \(subJson)")
                let file = subJson["File"]
                let details = TrainingModelFiles.init(json: file)
                self.TrainingModelFileDetails.append(details)
            }
            print("TrainingModelFileDetails \(self.TrainingModelFileDetails.count)")
            DispatchQueue.main.async {
                self.collectionVw.reloadData()
            }
        }
        
    }
    
    
    @IBAction func ClickOnForwardBtn(_ sender: UIButton)
    {
        print("TrainingModelFileDetails : \(self.TrainingModelFileDetails.count)")
        print("PopUpImageIndex : \(self.PopUpImageIndex)")
        if self.TrainingModelFileDetails.count == self.PopUpImageIndex {
           
//            let imgTxt = self.TrainingModelFileDetails[self.PopUpImageIndex].ServerRelativeUrl
//            let combine = MyStrings().BASEURL1 + imgTxt
//            let urlString = combine.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)
//            if let urls = URL(string: urlString!)
//            {
//                DispatchQueue.main.async {
//                    self.popUpView.isHidden = false
//                    self.AlphaView.isHidden = false
//                    self.fullImgView.kf.indicatorType = .activity
//                    self.fullImgView.kf.setImage(with: urls, placeholder: UIImage(named: "download1"), options: nil, progressBlock: nil, completionHandler: nil)
//                }
//
//            }else{
//
//            }
            self.PopUpImageIndex = 0
        }else if self.PopUpImageIndex == 0
        {
            let imgTxt = self.TrainingModelFileDetails[self.PopUpImageIndex].ServerRelativeUrl
            let combine = MyStrings().BASEURL1 + imgTxt
            let urlString = combine.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)
            if let urls = URL(string: urlString!)
            {
                DispatchQueue.main.async {
                    self.popUpView.isHidden = false
                    self.AlphaView.isHidden = false
                    self.fullImgView.kf.indicatorType = .activity
                    self.fullImgView.kf.setImage(with: urls, placeholder: UIImage(named: "download1"), options: nil, progressBlock: nil, completionHandler: nil)
                }

            }else{
                
            }
            self.PopUpImageIndex = self.PopUpImageIndex + 1

        }else{
            let imgTxt = self.TrainingModelFileDetails[self.PopUpImageIndex].ServerRelativeUrl
            let combine = MyStrings().BASEURL1 + imgTxt
            let urlString = combine.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)
            if let urls = URL(string: urlString!)
            {
                 DispatchQueue.main.async {
                    self.popUpView.isHidden = false
                    self.AlphaView.isHidden = false
                    self.fullImgView.kf.indicatorType = .activity
                    self.fullImgView.kf.setImage(with: urls, placeholder: UIImage(named: "download1"), options: nil, progressBlock: nil, completionHandler: nil)
                }

            }else{
                
            }
            self.PopUpImageIndex = self.PopUpImageIndex + 1


        }
        
    }
    @IBAction func ClickOnBackBtn(_ sender: UIButton)
    {
        print("TrainingModelFileDetails : \(self.TrainingModelFileDetails.count)")
        print("PopUpImageIndex : \(self.PopUpImageIndex)")
        if self.PopUpImageIndex == 1 {
            self.PopUpImageIndex = self.TrainingModelFileDetails.count - 1
            let imgTxt = self.TrainingModelFileDetails[self.PopUpImageIndex].ServerRelativeUrl
            let combine = MyStrings().BASEURL1 + imgTxt
            let urlString = combine.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)
            if let urls = URL(string: urlString!)
            {
                DispatchQueue.main.async {
                    self.popUpView.isHidden = false
                    self.AlphaView.isHidden = false
                    self.fullImgView.kf.indicatorType = .activity
                    self.fullImgView.kf.setImage(with: urls, placeholder: UIImage(named: "download1"), options: nil, progressBlock: nil, completionHandler: nil)
                }

            }else{
                
            }
        }else if self.PopUpImageIndex == 0
        {
            let imgTxt = self.TrainingModelFileDetails[self.PopUpImageIndex].ServerRelativeUrl
            let combine = MyStrings().BASEURL1 + imgTxt
            let urlString = combine.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)
            if let urls = URL(string: urlString!)
            {
                DispatchQueue.main.async {
                    self.popUpView.isHidden = false
                    self.AlphaView.isHidden = false
                    self.fullImgView.kf.indicatorType = .activity
                    self.fullImgView.kf.setImage(with: urls, placeholder: UIImage(named: "download1"), options: nil, progressBlock: nil, completionHandler: nil)
                }

            }else{
                
            }
            self.PopUpImageIndex = self.TrainingModelFileDetails.count - 1

        }else{
            self.PopUpImageIndex = self.PopUpImageIndex - 1
           
            let imgTxt = self.TrainingModelFileDetails[self.PopUpImageIndex].ServerRelativeUrl
            let combine = MyStrings().BASEURL1 + imgTxt
            let urlString = combine.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)
            if let urls = URL(string: urlString!)
            {
                DispatchQueue.main.async {
                    self.popUpView.isHidden = false
                    self.AlphaView.isHidden = false
                    self.fullImgView.kf.indicatorType = .activity
                    self.fullImgView.kf.setImage(with: urls, placeholder: UIImage(named: "download1"), options: nil, progressBlock: nil, completionHandler: nil)
                }

            }else{
                
            }
        }
        
    }
    
}
extension ImagesOfGallaryViewController : UICollectionViewDataSource,UICollectionViewDelegate,UICollectionViewDelegateFlowLayout
{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if TrainingModelFileDetails.count == 0 {
            return 0
        }else{
            return TrainingModelFileDetails.count
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "galleryTrainingCollectionViewCell", for: indexPath)as! galleryTrainingCollectionViewCell
        let imgTxt = self.TrainingModelFileDetails[indexPath.item].ServerRelativeUrl
        print("imgTxt url \(imgTxt)")

        let combine = MyStrings().BASEURL1 + imgTxt
        print("combine url \(combine)")
        let urlString = combine.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)
        if let urls = URL(string: urlString!)
        {
            DispatchQueue.main.async {
                cell.galleryImgview.kf.indicatorType = .activity
                cell.galleryImgview.kf.setImage(with: urls, placeholder: UIImage(named: "download1"), options: nil, progressBlock: nil, completionHandler: nil)
            }

        }else{
            
        }
//        cell.galleryImgview.image = UIImage.init(named: self.imgArray[indexPath.item])
        
        return cell
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: self.collectionVw.frame.width/2.3, height: self.collectionVw.frame.height/3.4)
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath)
    {
        self.PopUpImageIndex = indexPath.item + 1
        let imgTxt = self.TrainingModelFileDetails[indexPath.item].ServerRelativeUrl
        let combine = MyStrings().BASEURL1 + imgTxt
        let urlString = combine.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)
        if let urls = URL(string: urlString!)
        {
            DispatchQueue.main.async {
                self.popUpView.isHidden = false
                self.AlphaView.isHidden = false
                self.fullImgView.kf.indicatorType = .activity
                self.fullImgView.kf.setImage(with: urls, placeholder: UIImage(named: "download1"), options: nil, progressBlock: nil, completionHandler: nil)
            }

        }else{
            
        }
        if self.TrainingModelFileDetails.count == 1 {
            DispatchQueue.main.async {
            self.backBtn.isHidden = true
            self.forwardBtn.isHidden = true
            }
        }else{
            DispatchQueue.main.async {
            self.backBtn.isHidden = false
            self.forwardBtn.isHidden = false
            }
        }
       
    }
    
    
}
extension UIImageView {
  func enableZoom() {
    let pinchGesture = UIPinchGestureRecognizer(target: self, action: #selector(startZooming(_:)))
    isUserInteractionEnabled = true
    addGestureRecognizer(pinchGesture)
  }

  @objc
  private func startZooming(_ sender: UIPinchGestureRecognizer) {
    let scaleResult = sender.view?.transform.scaledBy(x: sender.scale, y: sender.scale)
    guard let scale = scaleResult, scale.a > 1, scale.d > 1 else { return }
    sender.view?.transform = scale
    sender.scale = 1
  }
}
