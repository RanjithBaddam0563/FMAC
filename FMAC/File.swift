//
//  File.swift
//  FMAC
//
//  Created by MicroExcel on 1/11/21.
//  Copyright © 2021 Fujairah. All rights reserved.
//

import Foundation
import UIKit

extension String{
    // remove amp; from string
func removeAMPSemicolon() -> String{
    return replacingOccurrences(of: "amp;", with: "")
}

// replace "&" with "And" from string
func replaceAnd() -> String{
    return replacingOccurrences(of: "&", with: "And")
}

// replace "\n" with "" from string
func removeNewLine() -> String{
    return replacingOccurrences(of: "\n", with: "")
}

func replaceAposWithApos() -> String{
    return replacingOccurrences(of: "Andapos;", with: "'")
}
}
extension UIView {
    func roundCorners(_ corners: UIRectCorner, radius: CGFloat) {
        if #available(iOS 11, *) {
            var cornerMask = CACornerMask()
            if(corners.contains(.topLeft)){
                cornerMask.insert(.layerMinXMinYCorner)
            }
            if(corners.contains(.topRight)){
                cornerMask.insert(.layerMaxXMinYCorner)
            }
            if(corners.contains(.bottomLeft)){
                cornerMask.insert(.layerMinXMaxYCorner)
            }
            if(corners.contains(.bottomRight)){
                cornerMask.insert(.layerMaxXMaxYCorner)
            }
            self.layer.cornerRadius = radius
            self.layer.maskedCorners = cornerMask

        } else {
            let path = UIBezierPath(roundedRect: self.bounds, byRoundingCorners: corners, cornerRadii: CGSize(width: radius, height: radius))
            let mask = CAShapeLayer()
            mask.path = path.cgPath
            self.layer.mask = mask
        }
    }
}
@IBDesignable
extension UIImageView
{
    private struct AssociatedKey
    {
        static var rounded = "UIImageView.rounded"
    }

    @IBInspectable var rounded: Bool
    {
        get
        {
            if let rounded = objc_getAssociatedObject(self, &AssociatedKey.rounded) as? Bool
            {
                return rounded
            }
            else
            {
                return false
            }
        }
        set
        {
            objc_setAssociatedObject(self, &AssociatedKey.rounded, newValue, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
            layer.cornerRadius = CGFloat(newValue ? 1.0 : 0.0)*min(bounds.width, bounds.height)/2
        }
    }
}
@IBDesignable
class FormTextField: UITextField {

    @IBInspectable var borderColor1: UIColor? {
        didSet {
            layer.borderColor = borderColor1?.cgColor
        }
    }

    @IBInspectable var borderWidth: CGFloat = 0 {
        didSet {
            layer.borderWidth = borderWidth
        }
    }
}
extension UIViewController {

    func presentAlertWithTitle(title: String, message: String, options: String..., completion: @escaping (Int) -> Void) {
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        for (index, option) in options.enumerated() {
            alertController.addAction(UIAlertAction.init(title: option, style: .default, handler: { (action) in
                completion(index)
            }))
        }
        self.present(alertController, animated: true, completion: nil)
    }
}
