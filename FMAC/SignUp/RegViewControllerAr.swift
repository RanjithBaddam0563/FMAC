//
//  RegViewControllerAr.swift
//  FMAC
//
//  Created by MicroExcel on 3/30/21.
//  Copyright © 2021 Fujairah. All rights reserved.
//

import UIKit
import Material
import Alamofire
import SwiftyJSON
import DropDown

class RegViewControllerAr: CameraPhotoBaseViewController,UITextFieldDelegate {
    var BranchesnameArray = [String]()
    var TypeOfSportnameArray = [String]()
    var SocialCategoryArray = [String]()
    var NationalityArray = [String]()
    var YearOfBirthArray = [String]()
    var ReverseYearOfBirthArray = [String]()
    @IBOutlet var visaCopyView: UIStackView!
    var typeOfGenderArray = ["ذكر","أنثى"]
    
    @IBOutlet var CheckBoxBtn: UIButton!


    @IBOutlet var socialCategoryTF: ErrorTextField!
    var typechecking : String = ""
    
    let dropDown = DropDown()

    @IBOutlet var addressTF: ErrorTextField!
    @IBOutlet var branchTF: ErrorTextField!
    @IBOutlet var DateTF: ErrorTextField!
    @IBOutlet var EmiratesIDTF: ErrorTextField!

    @IBOutlet var genderTF: ErrorTextField!
    @IBOutlet var typeOfGameTF: ErrorTextField!
    @IBOutlet var EmailTf: ErrorTextField!
    @IBOutlet var TelephoneTf: ErrorTextField!
    @IBOutlet var dateOfbirthTf: ErrorTextField!
    @IBOutlet var NationalityTf: ErrorTextField!
    @IBOutlet var nameTf: ErrorTextField!
    @IBOutlet var regBtn: UIButton!
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        let FormDigestValue = UserDefaults.standard.string(forKey: "FormDigestValue")
        if let FormDigestValueReg = FormDigestValue {
           print(FormDigestValueReg)
            print("FormDigestValueReg: \(FormDigestValueReg)")
        }

        BranchesApiMethod()
        TypeOfSportApiMethod()
        socialCategoryApiMethod()
        NationalityApiMethod()
        NationalityTf.delegate = self
        socialCategoryTF.delegate = self
        branchTF.delegate = self
        typeOfGameTF.delegate = self

        regBtn.roundCorners([ .bottomRight, .topLeft], radius: 30)
        // Do any additional setup after loading the view.
        self.navigationController?.navigationBar.tintColor = UIColor.white
        addressTF.placeholderLabel.textColor = .lightGray
        branchTF.placeholderLabel.textColor = .lightGray
        EmiratesIDTF.placeholderLabel.textColor = .lightGray
        DateTF.placeholderLabel.textColor = .lightGray
        genderTF.placeholderLabel.textColor = .lightGray
        typeOfGameTF.placeholderLabel.textColor = .lightGray
        socialCategoryTF.placeholderLabel.textColor = .lightGray

        EmailTf.placeholderLabel.textColor = .lightGray
        TelephoneTf.placeholderLabel.textColor = .lightGray
        dateOfbirthTf.placeholderLabel.textColor = .lightGray
        NationalityTf.placeholderLabel.textColor = .lightGray
        nameTf.placeholderLabel.textColor = .lightGray
        socialCategoryTF.placeholderLabel.textColor = .lightGray

        addressTF.textColor = UIColor.white
        addressTF.font = UIFont.init(name: ("Oswald-Regular"), size: 15.0);

        branchTF.textColor = UIColor.white
        branchTF.font = UIFont.init(name: ("Oswald-Regular"), size: 15.0);

        EmiratesIDTF.textColor = UIColor.white
        EmiratesIDTF.font = UIFont.init(name: ("Oswald-Regular"), size: 15.0);
        DateTF.textColor = UIColor.white
        DateTF.font = UIFont.init(name: ("Oswald-Regular"), size: 15.0);

        genderTF.textColor = UIColor.white
        genderTF.font = UIFont.init(name: ("Oswald-Regular"), size: 15.0);

        typeOfGameTF.textColor = UIColor.white
        typeOfGameTF.font = UIFont.init(name: ("Oswald-Regular"), size: 15.0);

        EmailTf.textColor = UIColor.white
        EmailTf.font = UIFont.init(name: ("Oswald-Regular"), size: 15.0);

        TelephoneTf.textColor = UIColor.white
        TelephoneTf.font = UIFont.init(name: ("Oswald-Regular"), size: 15.0);

        dateOfbirthTf.textColor = UIColor.white
        dateOfbirthTf.font = UIFont.init(name: ("Oswald-Regular"), size: 15.0);

        NationalityTf.textColor = UIColor.white
        NationalityTf.font = UIFont.init(name: ("Oswald-Regular"), size: 15.0);

        nameTf.textColor = UIColor.white
        nameTf.font = UIFont.init(name: ("Oswald-Regular"), size: 15.0);
        
        socialCategoryTF.textColor = UIColor.white
        socialCategoryTF.font = UIFont.init(name: ("Oswald-Regular"), size: 15.0);
        
        addressTF.textAlignment = .right
        branchTF.textAlignment = .right
        EmiratesIDTF.textAlignment = .right
        DateTF.textAlignment = .right
        genderTF.textAlignment = .right
        typeOfGameTF.textAlignment = .right
        EmailTf.textAlignment = .right
        TelephoneTf.textAlignment = .right
        dateOfbirthTf.textAlignment = .right
        NationalityTf.textAlignment = .right
        nameTf.textAlignment = .right
        socialCategoryTF.textAlignment = .right

        let date1 = Calendar.current.date(byAdding: .year, value: -8, to: Date())
        var date2 = Calendar.current.date(byAdding: .year, value: -39, to: Date())
        let fmt = DateFormatter()
        fmt.dateFormat = "yyyy-MM-dd HH:mm:ss Z"

        while date2! <= date1! {
            print(fmt.string(from: date2!))
            date2 = Calendar.current.date(byAdding: .year, value: 1, to: date2!)!
            let components = date2!.get(.day, .month, .year)
            if let year = components.year {
                print("years: \(year)")
               let yrStr = String(year)
                self.YearOfBirthArray.append(yrStr)
               
            }
        }
        for name in YearOfBirthArray {
            ReverseYearOfBirthArray.insert(name, at: 0)
        }
        print("ReverseYearOfBirthArray : \(ReverseYearOfBirthArray)")
    }
    @IBAction func ClickOnLoginBtn(_ sender: UIButton) {
        if #available(iOS 13.0, *) {
            let vc = self.storyboard?.instantiateViewController(identifier: "ViewController")as! ViewController
            self.navigationController?.pushViewController(vc, animated: true)

        } else {
            let vc = self.storyboard?.instantiateViewController(withIdentifier: "ViewController")as! ViewController
            self.navigationController?.pushViewController(vc, animated: true)
            
        }
    }
    @IBAction func ClickOnShareBtn(_ sender: Any) {
    }
    
    @IBAction func ClickOnBackBtn(_ sender: Any)
    {
        self.navigationController?.popViewController(animated: true)
    }
    @IBAction func ClickOnCheckBoxBtn(_ sender: UIButton)
    {
            if sender.isSelected {
                   // set deselected
                sender.isSelected = false
               } else {
                   // set selected
                sender.isSelected = true
               }
           
    }
    @IBAction func ClickOnRegBtn(_ sender: UIButton) {
//        let parameters = [
//                    "CardNumber" :        "1000",
//                    "DateOfBirth":      "Murat Akdeniz",
//                    "Email":        "xxxxxx",
//            "Address":        "xxxxxx",
//            "RegistrationStatus":        "xxxxxx",
//            "BranchId":        "xxxxxx",
//            "Gender":        "xxxxxx",
//            "Fees":        "xxxxxx",
//            "Mobile":        "xxxxxx",
//            "NationalityId":        "xxxxxx",
//            "EndorsementDate":        "xxxxxx",
//            "PlayerName":        "xxxxxx",
//            "Mobile":        "xxxxxx",
//            "Mobile":        "xxxxxx",
//            "Mobile":        "xxxxxx",
//        ]
//
//        let imgData = UIImage(named: "download")!.jpegData(compressionQuality: 1)
//
//
//
//            Alamofire.upload(
//                multipartFormData: { MultipartFormData in
//                //    multipartFormData.append(imageData, withName: "user", fileName: "user.jpg", mimeType: "image/jpeg")
//
//                    for (key, value) in parameters {
//                        MultipartFormData.append(value.data(using: String.Encoding.utf8)!, withName: key)
//                    }
//
//                    MultipartFormData.append(UIImage(named: "download")!.jpegData(compressionQuality: 1)!, withName: "photos[1]", fileName: "swift_file.jpeg", mimeType: "image/jpeg")
//                    MultipartFormData.append(UIImage(named: "download")!.jpegData(compressionQuality: 1)!, withName: "photos[2]", fileName: "swift_file.jpeg", mimeType: "image/jpeg")
//
//
//            }, to: "http://platform.twitone.com/station/add-feedback") { (result) in
//
//                switch result {
//                case .success(let upload, _, _):
//
//                    upload.responseJSON { response in
//                        print(response.result.value)
//                    }
//
//                case .failure(let encodingError): break
//                    print(encodingError)
//                }
//
//
//            }
    }
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        if textField == branchTF {
            typechecking = "branchTF"
            branchTF.resignFirstResponder()
            BranchesDropDownShow()
            dropDown.show()
        }else  if textField == typeOfGameTF {
            typechecking = "typeOfGameTF"
            typeOfGameTF.resignFirstResponder()
            BranchesDropDownShow()
            dropDown.show()
        }else  if textField == genderTF {
            typechecking = "genderTF"
            genderTF.resignFirstResponder()
            BranchesDropDownShow()
            dropDown.show()
        }else  if textField == socialCategoryTF {
            typechecking = "socialCategoryTF"
            socialCategoryTF.resignFirstResponder()
            BranchesDropDownShow()
            dropDown.show()
        }else  if textField == NationalityTf {
            typechecking = "NationalityTf"
            NationalityTf.resignFirstResponder()
            BranchesDropDownShow()
            dropDown.show()
        }else  if textField == dateOfbirthTf {
            typechecking = "dateOfbirthTf"
            dateOfbirthTf.resignFirstResponder()
            BranchesDropDownShow()
            dropDown.show()
        }
    }
    func BranchesApiMethod()  {
        BranchesnameArray.removeAll()
        let urlString = URL(string:MyStrings().BranchesList_API)!
        print(urlString)
        let networkProcessor = NetworkProcessor(url: urlString)
        networkProcessor.downloadJSONFromURL { (passdata) in
            let json = JSON(passdata)
            print(json)
            let d = json["d"]
            print("BranchesJson : \(d)")
            let arrayNames =  d["results"].arrayValue.map {$0["BranchNameAr"].stringValue}
            self.BranchesnameArray = arrayNames
            print(self.BranchesnameArray)
        }
        
    }
    func BranchesDropDownShow()
    {
        if typechecking == "typeOfGameTF" {
            self.dropDown.anchorView = self.typeOfGameTF
            self.dropDown.dataSource = self.TypeOfSportnameArray
        }else if typechecking == "genderTF" {
            self.dropDown.anchorView = self.genderTF
            self.dropDown.dataSource = self.typeOfGenderArray
        }else if typechecking == "socialCategoryTF" {
            self.dropDown.anchorView = self.socialCategoryTF
            self.dropDown.dataSource = self.SocialCategoryArray
        }else if typechecking == "NationalityTf" {
            self.dropDown.anchorView = self.NationalityTf
            self.dropDown.dataSource = self.NationalityArray
        }else if typechecking == "dateOfbirthTf" {
            self.dropDown.anchorView = self.dateOfbirthTf
            self.dropDown.dataSource = self.ReverseYearOfBirthArray
        }else{
            self.dropDown.anchorView = self.branchTF
            self.dropDown.dataSource = self.BranchesnameArray
        }
        
        DispatchQueue.main.async {
            self.dropDown.bottomOffset = CGPoint(x: 0, y:(self.dropDown.anchorView?.plainView.bounds.height)!)
            self.dropDown.topOffset = CGPoint(x: 0, y:-(self.dropDown.anchorView?.plainView.bounds.height)!)
        self.dropDown.direction = .bottom
        DropDown.appearance().textColor = UIColor.black
        DropDown.appearance().selectedTextColor = UIColor.red
            DropDown.appearance().textFont = UIFont(name: "Oswald-Regular", size: 15)!
        DropDown.appearance().backgroundColor = UIColor.white
        DropDown.appearance().selectionBackgroundColor = UIColor.lightGray
        }
//        DropDown.appearance().cellHeight = 60
        self.dropDown.selectionAction = { [unowned self] (index: Int, item: String) in
          print("Selected item: \(item) at index: \(index)")
            DispatchQueue.main.async {
                if typechecking == "typeOfGameTF" {
                    self.typeOfGameTF.text = TypeOfSportnameArray[index]
                }else if typechecking == "genderTF" {
                    self.genderTF.text = typeOfGenderArray[index]
                }else if typechecking == "socialCategoryTF" {
                    self.socialCategoryTF.text = SocialCategoryArray[index]
                }else if typechecking == "dateOfbirthTf" {
                    self.dateOfbirthTf.text = ReverseYearOfBirthArray[index]
                }else if typechecking == "NationalityTf" {
                    self.NationalityTf.text = NationalityArray[index]
                    if self.NationalityTf.text == "United Arab Emirates"
                    {
                        DispatchQueue.main.async {
                        self.visaCopyView.isHidden = true
                        }
                    }else{
                        DispatchQueue.main.async {
                        self.visaCopyView.isHidden = false
                        }
                    }
                }else{
                    self.branchTF.text = BranchesnameArray[index]
                }
            }
        }
    }
    func TypeOfSportApiMethod()  {
        TypeOfSportnameArray.removeAll()
        let urlString = URL(string:MyStrings().TypeOfGame_API)!
        print(urlString)
        let networkProcessor = NetworkProcessor(url: urlString)
        networkProcessor.downloadJSONFromURL { (passdata) in
            let json = JSON(passdata)
            print(json)
            let d = json["d"]
            print("TypeOfSportJson : \(d)")
            let arrayNames =  d["results"].arrayValue.map {$0["SportNameAr"].stringValue}
            self.TypeOfSportnameArray = arrayNames
            print(self.TypeOfSportnameArray)
        }
        
    }
    func socialCategoryApiMethod()  {
        SocialCategoryArray.removeAll()
        let urlString = URL(string:MyStrings().socialCategory_API)!
        print(urlString)
        let networkProcessor = NetworkProcessor(url: urlString)
        networkProcessor.downloadJSONFromURL { (passdata) in
            let json = JSON(passdata)
            let d = json["d"]
            print("socialCategoryJson : \(d)")
            let arrayNames =  d["results"].arrayValue.map {$0["TitleAr"].stringValue}
            self.SocialCategoryArray = arrayNames
            print(self.SocialCategoryArray)
        }
        
    }
    func NationalityApiMethod()  {
        NationalityArray.removeAll()
        let urlString = URL(string:MyStrings().Nationality_API)!
        print(urlString)
        let networkProcessor = NetworkProcessor(url: urlString)
        networkProcessor.downloadJSONFromURL { (passdata) in
            let json = JSON(passdata)
            let d = json["d"]
            print("NationalityJson : \(d)")
            let arrayNames =  d["results"].arrayValue.map {$0["TitleAr"].stringValue}
            self.NationalityArray = arrayNames
            print(self.NationalityArray)
        }
        
    }

    
    @IBAction func ClickOnEmiratesBrowse(_ sender: UIButton)
    {
        let picker = super.showImagePicker(sourceType: .photoLibrary)
         self.present(picker, animated: true)
         super.imgBlock = { selectedImg in
//             self.imgView.image = selectedImg
             
         }

     }
    
}
