//
//  RegViewController.swift
//  FMAC
//
//  Created by MicroExcel on 2/3/21.
//  Copyright © 2021 Fujairah. All rights reserved.
//

import UIKit
import Material
import Alamofire
import SwiftyJSON
import DropDown
import MBProgressHUD
import Kingfisher


class RegViewController: CameraPhotoBaseViewController,UITextFieldDelegate {
    var BranchesnameArray = [String]()
    var BranchesnameIDArray = [Int]()
    
    var BranchIdStr : String = ""
    var dImg = UIImage()
    
    @IBOutlet var CheckBoxBtn: UIButton!
    
    var TypeOfSportnameArray = [String]()
    var TypeOfSportnameIDArray = [Int]()
    var TypeOfSportIdStr : String = ""

    var SocialCategoryArray = [String]()
    var SocialCategoryIDArray = [Int]()
    
    var SocialCategoryIdStr : String = ""


    var NationalityArray = [String]()
    var NationalityIDArray = [Int]()
    var NationalityIdStr : String = ""
    var YearOfBirthIdStr : String = ""


    var YearOfBirthArray = [String]()
    var YearOfBirthIDArray = [Int]()

    var ReverseYearOfBirthArray = [String]()
    
    var GetfileData: Data!
    var GetfileName: URL?
    var pickFrom : String = ""
    var ImageTypeArray = [String]()
    var selectedImageURLArray = [URL]()

    @IBOutlet var visaCopyView: UIStackView!
    var typeOfGenderArray = ["Male","Female"]
    var RegUserID = Int()


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
        
        
        print(Date.getCurrentDate())
        DateTF.text  = Date.getCurrentDate()
        

        var validation = Validation()

        let FormDigestValue = UserDefaults.standard.string(forKey: "FormDigestValue")
        if let FormDigestValueReg = FormDigestValue {
           print(FormDigestValueReg)
            print("FormDigestValueReg: \(FormDigestValueReg)")
        }

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
        DateTF.placeholderLabel.textColor = .lightGray
        EmiratesIDTF.placeholderLabel.textColor = .lightGray
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

        DateTF.textColor = UIColor.white
        DateTF.font = UIFont.init(name: ("Oswald-Regular"), size: 15.0);
        
        EmiratesIDTF.textColor = UIColor.white
        EmiratesIDTF.font = UIFont.init(name: ("Oswald-Regular"), size: 15.0);

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
        
        let first4 = String(self.TelephoneTf.text!.prefix(4))
        print("Mobilefirst4 : \(first4)")
        
        
              guard let name = nameTf.text, let email = EmailTf.text, let phone = TelephoneTf.text else {
                 return
              }
        if typeOfGameTF.text?.isEmpty == true {
            typeOfGameTF.isError(baseColor: UIColor.red.cgColor, numberOfShakes: 4, revert: true)
            Toast.show(message: "Please select game", controller: self)
        }else if branchTF.text?.isEmpty == true {
            branchTF.isError(baseColor: UIColor.red.cgColor, numberOfShakes: 4, revert: true)
            Toast.show(message: "Please select branch", controller: self)
        }else if nameTf.text?.isEmpty == true {
            nameTf.isError(baseColor: UIColor.red.cgColor, numberOfShakes: 4, revert: true)
            Toast.show(message: "Please enter fullname", controller: self)
        }else if genderTF.text?.isEmpty == true {
            genderTF.isError(baseColor: UIColor.red.cgColor, numberOfShakes: 4, revert: true)
            Toast.show(message: "Please select gender", controller: self)
        }else if dateOfbirthTf.text?.isEmpty == true {
            dateOfbirthTf.isError(baseColor: UIColor.red.cgColor, numberOfShakes: 4, revert: true)
            Toast.show(message: "Please select your year of birth", controller: self)
        }else if socialCategoryTF.text?.isEmpty == true {
            socialCategoryTF.isError(baseColor: UIColor.red.cgColor, numberOfShakes: 4, revert: true)
            Toast.show(message: "Please select your social category", controller: self)
        }else if TelephoneTf.text?.isEmpty == true {
            TelephoneTf.isError(baseColor: UIColor.red.cgColor, numberOfShakes: 4, revert: true)
            Toast.show(message: "Please enter mobile number", controller: self)
        }else if !(self.TelephoneTf.text?.isValidContact)!
        {
            TelephoneTf.isError(baseColor: UIColor.red.cgColor, numberOfShakes: 4, revert: true)
            Toast.show(message: "Please check mobile number not valid", controller: self)
        }else if first4 != "9715"
        {
            TelephoneTf.isError(baseColor: UIColor.red.cgColor, numberOfShakes: 4, revert: true)
            Toast.show(message: "Please check mobile number not valid", controller: self)
        }else if EmailTf.text?.isEmpty == true {
            EmailTf.isError(baseColor: UIColor.red.cgColor, numberOfShakes: 4, revert: true)
            Toast.show(message: "Please enter email", controller: self)
        }else if !(self.EmailTf.text?.isValidEmail())!
        {
            EmailTf.isError(baseColor: UIColor.red.cgColor, numberOfShakes: 4, revert: true)
            Toast.show(message: "Please check email-id not valid", controller: self)
        }else if addressTF.text?.isEmpty == true {
            addressTF.isError(baseColor: UIColor.red.cgColor, numberOfShakes: 4, revert: true)
            Toast.show(message: "Please enter address", controller: self)
        }else if NationalityTf.text?.isEmpty == true {
            NationalityTf.isError(baseColor: UIColor.red.cgColor, numberOfShakes: 4, revert: true)
            Toast.show(message: "Please select nationality", controller: self)
        }else if EmiratesIDTF.text?.isEmpty == true {
            EmiratesIDTF.isError(baseColor: UIColor.red.cgColor, numberOfShakes: 4, revert: true)
            Toast.show(message: "Please enter emirates ID", controller: self)
        }else{
            DispatchQueue.main.async {
                MBProgressHUD.showAdded(to: self.view, animated: true)
            }
            let urlString = URL(string:MyStrings().BASEURL1 + "_api/web/lists/GetByTitle(%27Registrations%27)/items")!
            print(urlString)
            let params = ["__metadata": ["type":"SP.Data.RegistrationsListItem"],"Address":addressTF.text!,"BranchId":BranchIdStr,"CardNumber":"4558596","DateOfBirth":"2013-06-24T21:46:22","Email":EmailTf.text!,"EmiratesId":"4558595","EndorsementDate":"2021-06-08T11:08:51","Fees":"211","Gender":genderTF.text!,"Mobile":TelephoneTf.text!,"NationalityId":NationalityIdStr,"PlayerName":nameTf.text!,"RegistrationStatus":"Registered","SocialCategoryId":SocialCategoryIdStr,"SportId":TypeOfSportIdStr,"YearOfBirth":dateOfbirthTf.text!] as [String : Any]
            let networkProcessor = NetworkProcessor(url: urlString)
        networkProcessor.downloadJSONFromURL3(params: params) { (passdata) in
                DispatchQueue.main.async {
                    MBProgressHUD.hide(for: self.view, animated: true)
                }
                let json1 = JSON(passdata)
                print("CurrentUserInfoJson : \(json1)")
                let d = json1["d"]
                self.RegUserID = d["Id"].intValue
            }
        
            
        }
        
    }
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        if textField == nameTf {
        let maxLength = 20
        let currentString: NSString = (textField.text ?? "") as NSString
        let newString: NSString =
            currentString.replacingCharacters(in: range, with: string) as NSString
        return newString.length <= maxLength
        }else if textField == EmailTf {
            let maxLength = 40
            let currentString: NSString = (textField.text ?? "") as NSString
            let newString: NSString =
                currentString.replacingCharacters(in: range, with: string) as NSString
            return newString.length <= maxLength
        }else if textField == TelephoneTf {
            let maxLength = 12
            let currentString: NSString = (textField.text ?? "") as NSString
            let newString: NSString =
                currentString.replacingCharacters(in: range, with: string) as NSString
            return newString.length <= maxLength
        }else if textField == EmiratesIDTF {
            let maxLength = 15
            let currentString: NSString = (textField.text ?? "") as NSString
            let newString: NSString =
                currentString.replacingCharacters(in: range, with: string) as NSString
            return newString.length <= maxLength
        }
        return true
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
            print("Branches Json :\(json)")
            let d = json["d"]
            let arrayNames =  d["results"].arrayValue.map {$0["BranchName"].stringValue}
            let arrayNames1 =  d["results"].arrayValue.map {$0["ID"].intValue}
            
            self.BranchesnameIDArray = arrayNames1
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
                    self.TypeOfSportIdStr = String(TypeOfSportnameIDArray[index])
                }else if typechecking == "genderTF" {
                    self.genderTF.text = typeOfGenderArray[index]
                }else if typechecking == "socialCategoryTF" {
                    self.socialCategoryTF.text = SocialCategoryArray[index]
//                    self.socialCategoryIdStr = String(SocialCategoryIDArray[index])

                }else if typechecking == "dateOfbirthTf" {
                    self.dateOfbirthTf.text = ReverseYearOfBirthArray[index]

                }else if typechecking == "NationalityTf" {
                    self.NationalityTf.text = NationalityArray[index]
                    self.NationalityIdStr = String(NationalityIDArray[index])

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
//                    self.branchIdStr = String(BranchesnameIDArray[index])

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
            print("TypeOfSport Json :\(json)")
            let d = json["d"]
            let arrayNames =  d["results"].arrayValue.map {$0["SportName"].stringValue}
            let arrayNames1 =  d["results"].arrayValue.map {$0["ID"].intValue}
            
            self.TypeOfSportnameIDArray = arrayNames1
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
            print("socialCategory Json :\(json)")
            let d = json["d"]
            let arrayNames =  d["results"].arrayValue.map {$0["Title"].stringValue}
            let arrayNames1 =  d["results"].arrayValue.map {$0["ID"].intValue}
            
            self.SocialCategoryIDArray = arrayNames1
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
            print("Nationality Json :\(json)")
            let d = json["d"]
            let arrayNames =  d["results"].arrayValue.map {$0["Title"].stringValue}
            let arrayNames1 =  d["results"].arrayValue.map {$0["ID"].intValue}
            self.NationalityIDArray = arrayNames1
            self.NationalityArray = arrayNames
            print(self.NationalityArray)
        }
        
    }

    
    @IBAction func ClickOnEmiratesBrowse(_ sender: UIButton)
    {
//        self.pickFrom = "Emirates"
        let picker = super.showImagePicker(sourceType: .photoLibrary)
         self.present(picker, animated: true)
         super.imgBlock = { selectedImg in
//             self.imgView.image = selectedImg
             
         }
        super.urlBlock = { selectedImgUrl in
//             self.imgView.image = selectedImg
            print("selectedImgUrl : \(selectedImgUrl)")
            self.selectedImageURLArray.append(selectedImgUrl)
            self.ImageTypeArray.append("EmiratesID.jpg")
        }
        

     }
    @IBAction func ClickOnPersonalPhotoBrowse(_ sender: UIButton)
    {
//        self.pickFrom = "PersonalPhoto"
        let picker = super.showImagePicker(sourceType: .photoLibrary)
         self.present(picker, animated: true)
         super.imgBlock = { selectedImg in
//             self.imgView.image = selectedImg
             
         }
        super.urlBlock = { selectedImgUrl in
//             self.imgView.image = selectedImg
            print("selectedImgUrl : \(selectedImgUrl)")
            self.selectedImageURLArray.append(selectedImgUrl)
            self.ImageTypeArray.append("PersonalPhoto.jpg")
        }
        

     }
    @IBAction func ClickOnPassportPhotoBrowse(_ sender: UIButton)
    {
//        self.pickFrom = "PassportPhoto"
        let picker = super.showImagePicker(sourceType: .photoLibrary)
         self.present(picker, animated: true)
         super.imgBlock = { selectedImg in
//             self.imgView.image = selectedImg
             
         }
        super.urlBlock = { selectedImgUrl in
//             self.imgView.image = selectedImg
            print("selectedImgUrl : \(selectedImgUrl)")
            self.selectedImageURLArray.append(selectedImgUrl)
            self.ImageTypeArray.append("Passport.jpg")
        }
        

     }
    @IBAction func ClickOnVisaPhotoBrowse(_ sender: UIButton)
    {
//        self.pickFrom = "VisaPhoto"
        let picker = super.showImagePicker(sourceType: .photoLibrary)
         self.present(picker, animated: true)
         super.imgBlock = { selectedImg in
//             self.imgView.image = selectedImg
             
         }
        super.urlBlock = { selectedImgUrl in
//             self.imgView.image = selectedImg
            print("selectedImgUrl : \(selectedImgUrl)")
            self.selectedImageURLArray.append(selectedImgUrl)
            self.ImageTypeArray.append("Visa.jpg")
            print("selectedImageURLArray: \(self.selectedImageURLArray)")
            print("ImageTypeArray: \(self.ImageTypeArray)")
            let filep = self.selectedImageURLArray[0]
            self.downloadfile(URL: filep)

        }
        

       

     }
    fileprivate func downloadfile(URL: URL) {
        let sessionConfig = URLSessionConfiguration.default
        let session = URLSession(configuration: sessionConfig, delegate: nil, delegateQueue: nil)
        var request = URLRequest(url: URL as URL)
        request.httpMethod = "GET"
        let task = session.dataTask(with: request as URLRequest, completionHandler: { (data, response, error) -> Void in
            if (error == nil) {
                // Success
                let responseString = String(data: data!, encoding: .utf8)
                    print("responseString = \(responseString)")
                let statusCode = response?.mimeType
                print("Success: \(String(describing: statusCode))")
                DispatchQueue.main.async(execute: {
                    self.p_uploadDocument(data!, filename: URL)
                    print("URL : \(URL)")
                })

                // This is your file-variable:
                // data
            }
            else {
                // Failure
                print("Failure: %@", error!.localizedDescription)
            }
        })
        task.resume()
    }
    fileprivate func p_uploadDocument(_ file: Data,filename : URL) {

        print("File : \(file)")
        print("filename : \(filename)")
        self.GetfileData = file
        self.GetfileName = filename
        uploadImages()
//        self.uploadTimePathNameLbl.text = self.GetfileName

    }
    
    func uploadImages()
    {
        //https://fmac.fujairah.ae/_api/web/lists/getbytitle('Registrations')/items('138')/AttachmentFiles/add(FileName='PersonalPhoto.jpg')
        //https://fmac.fujairah.ae/_api/web/lists/getbytitle('Registrations')/items('139')/AttachmentFiles/add(FileName='PersonalPhoto.jpg')
        let urlString = URL(string:MyStrings().BASEURL1 + "_api/web/lists/getbytitle(%27Registrations%27)/items(%27135%27)/AttachmentFiles/add(FileName=%27PersonalPhoto.jpg%27")!
        print(urlString)
//    let params = self.GetfileData
        let networkProcessor = NetworkProcessor(url: urlString)
//        self.GetfileData.base64EncodedString()
//        if let imagess = UIImage(data: self.GetfileData){
//        }
        networkProcessor.downloadJSONFromURL4(params: self.GetfileData, filename: self.GetfileName!, image: UIImage(data: self.GetfileData)!) { (passdata) in
//                DispatchQueue.main.async {
//                    MBProgressHUD.hide(for: self.view, animated: true)
//                }
            let json1 = JSON(passdata)
//            print("CurrentUserInfoJson : \(json1)")
//            let d = json1["d"]
//            self.RegUserID = d["Id"].intValue
        }

//        let parameters = self.GetfileName
//        let postData = parameters.data(using: .utf8)
//
//        var request = URLRequest(url: URL(string: "https://fmac.fujairah.ae/_api/web/lists/getbytitle(%27Registrations%27)/items(%27138%27)/AttachmentFiles/add(FileName=%27Visa.jpg%27)")!,timeoutInterval: Double.infinity)
//        request.addValue("application/json;odata=verbose", forHTTPHeaderField: "Accept")
//        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
//        request.addValue("0x3FF1B1A5B8839F7E4A71294CA0DE7B0CC5E73F252237B895796E20B9DC8A268B1191EFAA64EA9834E913722E72CD52624C56BD05490188F2BB772C239F1D3C15,08 Jun 2021 14:02:30 -0000", forHTTPHeaderField: "X-RequestDigest")
//        request.addValue("WSS_KeepSessionAuthenticated={a554e787-3261-4006-9895-ab6c35426258}", forHTTPHeaderField: "Cookie")
//
//        request.httpMethod = "POST"
//        request.httpBody = postData
//
//        let task = URLSession.shared.dataTask(with: request) { data, response, error in
//          guard let data = data else {
//            print(String(describing: error))
//            return
//          }
//          print(String(data: data, encoding: .utf8)!)
//        }
//
//        task.resume()
        
        
        
        
        
    }
    
}
extension Date {
    func get(_ components: Calendar.Component..., calendar: Calendar = Calendar.current) -> DateComponents {
        return calendar.dateComponents(Set(components), from: self)
    }

    func get(_ component: Calendar.Component, calendar: Calendar = Calendar.current) -> Int {
        return calendar.component(component, from: self)
    }
}
extension String {
    func isValidEmail() -> Bool {
        // here, `try!` will always succeed because the pattern is valid
        let regex = try! NSRegularExpression(pattern: "^[a-zA-Z0-9.!#$%&'*+/=?^_`{|}~-]+@[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,61}[a-zA-Z0-9])?(?:\\.[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,61}[a-zA-Z0-9])?)*$", options: .caseInsensitive)
        return regex.firstMatch(in: self, options: [], range: NSRange(location: 0, length: count)) != nil
    }
    //MobileNumber Validation
    var isValidContact: Bool {
        let phoneNumberRegex = "^[6-9]\\d{9}$"
        let phoneTest = NSPredicate(format: "SELF MATCHES %@", phoneNumberRegex)
        let isValidPhone = phoneTest.evaluate(with: self)
        return isValidPhone
    }
    //To check text field or String is blank or not
    var isBlank: Bool {
        get {
            let trimmed = trimmingCharacters(in: CharacterSet.whitespaces)
            return trimmed.isEmpty
        }
    }
    //validate Password
    var isValidPassword: Bool {
        do {
            let regex = try NSRegularExpression(pattern: "^[a-zA-Z_0-9\\-_,;.:#+*?=!§$%&/()@]+$", options: .caseInsensitive)
            if(regex.firstMatch(in: self, options: NSRegularExpression.MatchingOptions(rawValue: 0), range: NSMakeRange(0, self.count)) != nil){
                
                if(self.count>=8 && self.count<=20){
                    return true
                }else{
                    return false
                }
            }else{
                return false
            }
        } catch {
            return false
        }
    }
    
    var isAlphanumeric: Bool {
        return !isEmpty && range(of: "[^a-zA-Z0-9]", options: .regularExpression) == nil
    }
  
    func isValidPassword1() -> Bool {
        let regularExpression = "^(?=.*[a-z])(?=.*[A-Z])(?=.*\\d)(?=.*[$@$!%*?&])[A-Za-z\\d$@$!%*?&]{8,}"
        let passwordValidation = NSPredicate.init(format: "SELF MATCHES %@", regularExpression)
        
        return passwordValidation.evaluate(with: self)
    }
    
    func toBool() -> Bool? {
            switch self {
            case "True", "true", "yes", "1":
                return true
            case "False", "false", "no", "0":
                return false
            default:
                return nil
            }
    }
    

}
extension Date {

 static func getCurrentDate() -> String {

        let dateFormatter = DateFormatter()

        dateFormatter.dateFormat = "dd/MM/yyyy"

        return dateFormatter.string(from: Date())

    }
}
