//
//  UIViewControllerExtension.swift
//  SlideMenuControllerSwift
//
//  Created by Yuji Hato on 1/19/15.
//  Copyright (c) 2015 Yuji Hato. All rights reserved.
//

import UIKit

extension UIViewController {
    
    func setNavigationBarItem(_ leftImageName:String,rightImageName:String?) {
        self.addLeftBarButtonWithImage(UIImage(named: leftImageName)!)
        self.slideMenuController()?.removeLeftGestures()
        self.slideMenuController()?.addLeftGestures()
        
        if(rightImageName != nil){
            self.addRightBarButtonWithImage(UIImage(named: rightImageName!)!)
            self.slideMenuController()?.removeRightGestures()
            self.slideMenuController()?.addRightGestures()

        }
       
    }
    
    func removeNavigationBarItem() {
        self.navigationItem.leftBarButtonItem = nil
        self.navigationItem.rightBarButtonItem = nil
        self.slideMenuController()?.removeLeftGestures()
        self.slideMenuController()?.removeRightGestures()
    }
}
