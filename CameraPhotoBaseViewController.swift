//
//  CameraPhotoBaseViewController.swift
//  UiDefferedMenuElements
//
//  Created by MicroExcel on 5/13/21.
//

import UIKit

typealias imageBlock = ((UIImage)->())
typealias urlBlock = ((URL)->())


class CameraPhotoBaseViewController: UIViewController {

    var imgBlock : imageBlock?
    var urlBlock : urlBlock?

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
    }
    
    func showImagePicker(sourceType : UIImagePickerController.SourceType) ->
    UIImagePickerController
    {
        let imgPicker = UIImagePickerController()
        imgPicker.sourceType = sourceType
        imgPicker.delegate = self
        imgPicker.allowsEditing = true
        return imgPicker
    }
    
}
extension CameraPhotoBaseViewController : UINavigationControllerDelegate, UIImagePickerControllerDelegate
{
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        
        if #available(iOS 11.0, *) {
            if let imageURL = info[UIImagePickerController.InfoKey.imageURL] as? URL {
                print(imageURL)
                let imgdata = try? Data(contentsOf: imageURL)
                print(imgdata)
                if urlBlock != nil {
                    self.urlBlock!(imageURL)
                }

               
            }
        } else {
            if let imageUrl = info[UIImagePickerController.InfoKey.mediaURL] as? URL {
                print(imageUrl)
                let imgdata = try? Data(contentsOf: imageUrl)
                print(imgdata)
                if urlBlock != nil {
                    self.urlBlock!(imageUrl)
                }
            }
        }
       
        
        dismiss(animated: true)
        let image = info[UIImagePickerController.InfoKey.originalImage] as! UIImage
        if imgBlock != nil {
            self.imgBlock!(image)
        }
        
        
    }
}

