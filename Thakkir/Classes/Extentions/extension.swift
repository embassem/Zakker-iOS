//
//  extension.swift
//  Heart Plus
//
//  Created by Bassem on 1/31/16.
//  Copyright © 2016 TheAppConcept. All rights reserved.
//
import UIKit
import Foundation



public extension UIViewController{
    
    @IBAction func  popViewController(_ sender:UIBarButtonItem){
        
        self.navigationController?.popViewController(animated: true);
    }
}

internal extension UIStoryboard {
    
    class func initViewControllerFromStoryboard(_ stoaryboard:String,viewcontroller:UIViewController)-> UIViewController{
        let stoaryboard = UIStoryboard(name: stoaryboard, bundle: Bundle.main);
        
         return stoaryboard.instantiateViewController(withIdentifier: "\(viewcontroller)")
    }
    
    
    class func mainStoryboard() -> UIStoryboard { return UIStoryboard(name: "Main", bundle: Bundle.main) }
//    
//    class func todayViewController() -> TodayViewController?{
//                return mainStoryboard().instantiateViewControllerWithIdentifier("TodayViewController") as! TodayViewController
//            }
//
//    class func nowViewController() -> NowViewController?{
//        return mainStoryboard().instantiateViewControllerWithIdentifier("NowViewController") as! NowViewController
//    }
    
    
//    class func dateViewController() -> DateViewController?{
//        return mainStoryboard().instantiateViewControllerWithIdentifier("DateViewController") as? DateViewController
//    }
    
}

public extension UIButton{
    
    func buttonWithRadiosShadow(_ radius:CGFloat = 45,shadowColor:UIColor = UIColor.lightGray,shadowRadius:CGFloat = 5) {
        
        
        self.layer.masksToBounds = false;
        self.layer.borderWidth = 0.0;
        self.layer.cornerRadius = radius;
        self.layer.shadowRadius = shadowRadius;
        self.layer.borderColor = shadowColor.cgColor;
        self.layer.shadowColor = shadowColor.cgColor;
        self.layer.shadowOpacity = 0.8;
        self.layer.shadowOffset = CGSize(width: 2, height: 2);
    }
    
    
    func HeartPlusButton(){
        self.layer.cornerRadius = 4    ;
        self.layer.borderWidth = 2;
        self.layer.borderColor = UIColor.lightGray.cgColor//UIColor(rgba: HPColors.Blue.rawValue).CGColor
        self.titleLabel?.adjustsFontSizeToFitWidth = true ;
        
    }
}

extension Array {
    func forEach(_ doThis: (_ element: Element) -> Void) {
        for e in self {
            doThis(e)
        }
    }
}

extension UILabel{
    
    func requiredHeight() -> CGFloat{
        
        let label:UILabel = UILabel(frame: CGRect(x: 0, y: 0, width: self.frame.width, height: CGFloat.greatestFiniteMagnitude))
        label.numberOfLines = 0
        label.lineBreakMode = NSLineBreakMode.byWordWrapping
        label.font = self.font
        label.text = self.text
        
        label.sizeToFit()
        
        return label.frame.height
    }
}

/** @abstract UIWindow hierarchy category.  */
public extension UIWindow {
    
    /** @return Returns the current Top Most ViewController in hierarchy.   */
     //commentBassem
//    public  override func topMostController()->UIViewController? {
//        
//        var topController = rootViewController
//        
//        while let presentedController = topController?.presentedViewController {
//            topController = presentedController
//        }
//        
//        return topController
//    }
    
    /** @return Returns the topViewController in stack of topMostController.    */
    
//    public func currentViewController()->UIViewController? {
//        
//        var currentViewController = topMostController()
//        
//        while currentViewController != nil && currentViewController is UINavigationController && (currentViewController as! UINavigationController).topViewController != nil {
//            currentViewController = (currentViewController as! UINavigationController).topViewController
//        }
//        
//        return currentViewController
//    }
}

extension UIWindow {
    
    func visibleViewController() -> UIViewController? {
        if let rootViewController: UIViewController  = self.rootViewController {
            return UIWindow.getVisibleViewControllerFrom(rootViewController)
        }
        return nil
    }
    
    class func getVisibleViewControllerFrom(_ vc:UIViewController) -> UIViewController {
        if vc.isKind(of: UINavigationController.self) {
            
            let navigationController = vc as! UINavigationController
            return UIWindow.getVisibleViewControllerFrom( navigationController.visibleViewController!)
            
        } else if vc.isKind(of: UITabBarController.self) {
            
            let tabBarController = vc as! UITabBarController
            return UIWindow.getVisibleViewControllerFrom(tabBarController.selectedViewController!)
            
        } else {
            
            if let presentedViewController = vc.presentedViewController {
                
                return UIWindow.getVisibleViewControllerFrom(presentedViewController.presentedViewController!)
                
            } else {
                
                return vc;
            }
        }
    }
    
}

extension Foundation.Locale {
    
    struct Locale {
        let countryCode: String
        let countryName: String
    }
    
//    static func locales() -> [Locale] {
//        
//        
//        //let frLocale = NSLocale(localeIdentifier: "fr_FR")
////        print(frLocale.displayNameForKey(NSLocaleIdentifier, value: "fr_FR")!)
//        var locales = [Locale]()
//        for localeCode in Foundation.Locale.isoRegionCodes {
//            let countryName = Foundation.ubiquitousItemContainerDisplayName//(Foundation.Locale.current.di ).displayName(forKey: NSLocale.Key.countryCode, value: localeCode)!
//            let countryCode = localeCode 
//            let locale = Locale(countryCode: countryCode, countryName: countryName)
//            locales.append(locale)
//        }
//        
//        return locales
//    }
    
}

extension UserDefaults {
    // check for is first launch - only true on first invocation after app install, false on all further invocations
    static func isFirstLaunch() -> Bool {
        let firstLaunchFlag = "FirstLaunchFlag"
        let isFirstLaunch = UserDefaults.standard.string(forKey: firstLaunchFlag) == nil
        if (isFirstLaunch) {
            UserDefaults.standard.set("false", forKey: firstLaunchFlag)
            UserDefaults.standard.synchronize()
          
        }
        return isFirstLaunch
    }
}
//extension UILabel {
//    
//    override func init(frame: CGRect) {
//        
//        adjustsFontSizeToFitWidth = true; // default is NO
//        public var baselineAdjustment:
//    }
//}

//extension String {
//    
//    subscript (i: Int) -> Character {
//        return self[advance(self.startIndex, i)]
//    }
//    
//    subscript (i: Int) -> String {
//        return String(self[i] as Character)
//    }
//    
//    //    subscript (r: Range) -> String {
//    //        return substringWithRange(Range(start: advance(startIndex, r.startIndex), end: advance(startIndex, r.endIndex)))
//    //    }
//}

