//
//  AppDelegate.swift
//  FMAC
//
//  Created by MicroExcel on 12/30/20.
//  Copyright © 2020 Fujairah. All rights reserved.
//

import UIKit
import IQKeyboardManagerSwift

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate
{
    
var window: UIWindow?
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool
    {
        // Override point for customization after application launch.

        if let tabBarController = self.window!.rootViewController as? UITabBarController {
                tabBarController.selectedIndex = 2
            }
        IQKeyboardManager.shared.enable = true
        for fontFamily in UIFont.familyNames {
            for fontName in UIFont.fontNames(forFamilyName: fontFamily) {
//                print("\(fontName)")
            }
        }
        UIFont.overrideDefaultTypography()
        return true
    }

    


}

