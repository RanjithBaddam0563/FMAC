//
//  MainTabbarViewController.swift
//  FMAC
//
//  Created by MicroExcel on 4/11/21.
//  Copyright © 2021 Fujairah. All rights reserved.
//

import UIKit

class MainTabbarViewController: UITabBarController {
    @IBOutlet weak var myTabBar: UITabBar?

    
    override func viewWillLayoutSubviews() {
        var tabFrame = self.tabBar.frame
        // - 40 is editable , the default value is 49 px, below lowers the tabbar and above increases the tab bar size
        tabFrame.size.height = 40
        tabFrame.origin.y = self.view.frame.size.height - 40
        self.tabBar.frame = tabFrame
    }
    override func viewDidLoad() {
        super.viewDidLoad()

        myTabBar?.tintColor = UIColor.white
              tabBarItem.title = ""

              setTabBarItems()
        
    }
    
    func setTabBarItems(){

          let myTabBarItem1 = (self.tabBar.items?[0])! as UITabBarItem
        myTabBarItem1.image = UIImage(named: "people")?.withRenderingMode(UIImage.RenderingMode.alwaysOriginal)
        myTabBarItem1.selectedImage = UIImage(named: "people")?.withRenderingMode(UIImage.RenderingMode.alwaysOriginal)
          myTabBarItem1.title = " "
          myTabBarItem1.imageInsets = UIEdgeInsets(top: 6, left: 0, bottom: -6, right: 0)

          let myTabBarItem2 = (self.tabBar.items?[1])! as UITabBarItem
        myTabBarItem2.image = UIImage(named: "cal")?.withRenderingMode(UIImage.RenderingMode.alwaysOriginal)
        myTabBarItem2.selectedImage = UIImage(named: "cal")?.withRenderingMode(UIImage.RenderingMode.alwaysOriginal)
          myTabBarItem2.title = " "
          myTabBarItem2.imageInsets = UIEdgeInsets(top: 6, left: 0, bottom: -6, right: 0)


          let myTabBarItem3 = (self.tabBar.items?[2])! as UITabBarItem
        myTabBarItem3.image = UIImage(named: "homeTab")?.withRenderingMode(UIImage.RenderingMode.alwaysOriginal)
        myTabBarItem3.selectedImage = UIImage(named: "homeTab")?.withRenderingMode(UIImage.RenderingMode.alwaysOriginal)
          myTabBarItem3.title = " "
          myTabBarItem3.imageInsets = UIEdgeInsets(top: -40, left: 0, bottom: -6, right: 0)

          let myTabBarItem4 = (self.tabBar.items?[3])! as UITabBarItem
        myTabBarItem4.image = UIImage(named: "trophy")?.withRenderingMode(UIImage.RenderingMode.alwaysOriginal)
        myTabBarItem4.selectedImage = UIImage(named: "trophy")?.withRenderingMode(UIImage.RenderingMode.alwaysOriginal)
          myTabBarItem4.title = " "
          myTabBarItem4.imageInsets = UIEdgeInsets(top: 6, left: 0, bottom: -6, right: 0)
        
        let myTabBarItem5 = (self.tabBar.items?[4])! as UITabBarItem
        myTabBarItem5.image = UIImage(named: "champion")?.withRenderingMode(UIImage.RenderingMode.alwaysOriginal)
        myTabBarItem5.selectedImage = UIImage(named: "champion")?.withRenderingMode(UIImage.RenderingMode.alwaysOriginal)
        myTabBarItem5.title = " "
        myTabBarItem5.imageInsets = UIEdgeInsets(top: 6, left: 0, bottom: -6, right: 0)

     }
}
extension UITabBar {

     override open func sizeThatFits(_ size: CGSize) -> CGSize {
     var sizeThatFits = super.sizeThatFits(size)
     sizeThatFits.height = 40 // adjust your size here
     return sizeThatFits
    }
 }
