//
//  Shared.swift
//  GooTaxi
//
//  Created by Bassem on 8/13/16.
//  Copyright © 2017 ADLANC.COM. All rights reserved.
//

import Foundation
import CoreGraphics
import UIKit
import Localize_Swift
import PKHUD
import ObjectMapper
import PopupDialog
import SwiftMessages




class Shared {
   
    
    
    
    class func setImageViewForNavigation(_ imageName:String, nav:UINavigationItem, navigationBar:UINavigationBar) {
        
        
        DispatchQueue.main.async { 
            
            let navImage = UIImageView(frame: CGRect(x: 0, y: 0, width: 120, height: 40));
            navImage.center = CGPoint(x: navigationBar.frame.size.width / 2.0, y: navigationBar.frame.size.height / 2.0);
            navImage.image = UIImage(named: imageName);
            nav.titleView = navImage;
            
            
        }
        
        
        
    }
    
 
    
    
    
    class func alert (_ title:String, message:String, confirmTitle:String, isCansle:Bool = false, sender:UIViewController){
        
        
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        
        let defaultAction = UIAlertAction(title: confirmTitle, style: .default, handler: nil)
        alertController.addAction(defaultAction)
        
        appDelegate.window?.rootViewController!.present(alertController, animated: true, completion: nil)
        
        
    }
    
    class func borderButton(_ button:UIButton,cornerRadius:Int = 4,borderColor:UIColor = UIColor.white,borderWidth:Float = 1.0)
    {
        button.layer.cornerRadius = CGFloat(cornerRadius);
        button.layer.borderColor = borderColor.cgColor;
        button.layer.borderWidth=CGFloat(borderWidth);
       
        button.layer.masksToBounds = true;
        
    }
    
   
    
    class func adjustButtonDesign(_ button:UIButton,imageName:String?,text:String,borderColor:UIColor)
    {
        //button.layer.cornerRadius = button.layer.frame.size.height/2;
         button.layer.cornerRadius = CGFloat(4);
        button.layer.borderColor = borderColor.cgColor;
        button.layer.borderWidth=3.0;
         if let imageNameTxt = imageName {
//            if imageName.isNotEmpty {
            let spacing:CGFloat = 10;
//            button.imageEdgeInsets = UIEdgeInsetsMake(0, 0, 0, spacing);
//            button.titleEdgeInsets = UIEdgeInsetsMake(0, spacing, 0, 0);
            button.imageEdgeInsets = UIEdgeInsetsMake(0, 0, 0, spacing);
            button.titleEdgeInsets = UIEdgeInsetsMake(0, spacing, 0, 0);
            let btnImage = UIImage(named: imageNameTxt);
            button.setImage(btnImage, for: UIControlState());
            button.setTitle(text, for: .normal)
        }
        button.layer.masksToBounds = true;
        
    }
    
    
  
    
    class  HUD {
        
        
        class func progressHUD  (_ title:String? = nil,message:String? = nil,hideafter:Int? = nil,userInteraction:Bool = false){

            PKHUD.sharedHUD.contentView = PKHUDProgressBeat(title: title, subtitle: message);
            PKHUD.sharedHUD.effect = nil;
            PKHUD.sharedHUD.contentView.backgroundColor = UIColor.fieldDrab
            PKHUD.sharedHUD.contentView.alpha = 1;
                //PKHUDProgressView(title: title, subtitle: message)//PKHUDProgressCircular(title: title, subtitle: message);
            PKHUD.sharedHUD.show();
            if (hideafter != nil){
                PKHUD.sharedHUD.hide(afterDelay: TimeInterval(hideafter!));
            }
            
                PKHUD.sharedHUD.userInteractionOnUnderlyingViewsEnabled = userInteraction;
            
            
        }
        
        class func successHUD  (_ title:String?,message:String?,hideafter:Int? = nil){
            
            PKHUD.sharedHUD.contentView = PKHUDSuccessView(title: title, subtitle: message);
            PKHUD.sharedHUD.show();
            if (hideafter != nil){
             PKHUD.sharedHUD.hide(afterDelay: TimeInterval(hideafter!));
            }
        }
        
        class func errorHUD  (_ title:String?, message:String?, hideafter:Int? = nil){
            
            PKHUD.sharedHUD.contentView = PKHUDErrorView(title: title, subtitle: message);
            PKHUD.sharedHUD.show();
            if (hideafter != nil){
                PKHUD.sharedHUD.hide(afterDelay: TimeInterval(hideafter!));
            }
        }
        
        class func hide (_ after:Int? = nil){
            
            if (after == nil){
                PKHUD.sharedHUD.hide(true);
            } else {
                PKHUD.sharedHUD.hide(afterDelay: TimeInterval(after!));
            }
        }
        
        class func hide (_ after:Int? = nil,Completion:(() -> Void)? = nil){
            
            if (after == nil){
                PKHUD.sharedHUD.hide(true);
            } else {
                PKHUD.sharedHUD.hide(afterDelay: TimeInterval(after!));
            }
            
            if let Completion = Completion {
                Completion();
            }
        }
        
        
    }
    
    
    class AlertDialog
    {
    
        class func alertWithDismiss(_ title:String?,message:String?,image:UIImage?,cancelTitleKey:String , presentview:UIViewController? = nil,cancelCompletion:(() -> Void)? = nil){
            
            

            // Create the dialog
//             let popup = PopupDialog
            let popup = PopupDialog(title: title, message: message, image: image, buttonAlignment: UILayoutConstraintAxis.vertical, transitionStyle: PopupDialogTransitionStyle.bounceUp, gestureDismissal: false, completion: nil)
            
            // Create first button
            let buttonOne = CancelButton(title: cancelTitleKey) {
                if (cancelCompletion != nil){
                cancelCompletion!();
                }
            }
            
            
           
            
            popup.addButtons([buttonOne])
            
            var viewtoPresent = presentview;
            if (viewtoPresent == nil ) {
               viewtoPresent = UIApplication.shared.topViewController
                if (viewtoPresent == nil){
                    viewtoPresent = appDelegate.window?.rootViewController
                }
            }
            viewtoPresent?.present(popup,animated:true);
       
           
        }
        
        class func alertWithActionAndDismiss(_ title:String?,message:String?,image:UIImage?,actionTitleKey:String,cancelTitleKey:String , presentview:UIViewController? = nil,
                                             actionCompletion:@escaping (() -> Void),cancelCompletion:(() -> Void)? = nil){
            
            
            
            // Create the dialog
            //             let popup = PopupDialog
            let popup = PopupDialog(title: title, message: message, image: image, buttonAlignment: UILayoutConstraintAxis.vertical, transitionStyle: PopupDialogTransitionStyle.bounceUp, gestureDismissal: false, completion: nil)
            
            // Create first button
            let buttonOne = CancelButton(title: cancelTitleKey) {
                if (cancelCompletion != nil){
                    cancelCompletion!();
                }
            }
            
            let buttonaction = DefaultButton(title: actionTitleKey) {
                
                    actionCompletion();
                
            }
            
            
            
            popup.addButtons([buttonaction,buttonOne])
            
            var viewtoPresent = presentview;
            if (viewtoPresent == nil ) {
                viewtoPresent = UIApplication.shared.topViewController
                if (viewtoPresent == nil){
                    viewtoPresent = appDelegate.window?.rootViewController
                }
            }
            viewtoPresent?.present(popup,animated:true);
            
            
        }
        
        
        class func alertUnknownErrorWithDismiss(cancelTitleKey:String = "ok",cancelCompletion:(() -> Void)? = nil){
            
            
            
            // Create the dialog
            //             let popup = PopupDialog
            let popup = PopupDialog(title: "Error".localized(), message: "Sorry some Error Happend Contact Admin.", image: nil, buttonAlignment: UILayoutConstraintAxis.vertical, transitionStyle: PopupDialogTransitionStyle.bounceUp, gestureDismissal: false, completion: nil)
            
            // Create first button
            let buttonOne = CancelButton(title: cancelTitleKey) {
                if (cancelCompletion != nil){
                    cancelCompletion!();
                }
            }
            
            
            
            
            popup.addButtons([buttonOne])
            
            
            UIApplication.present(popup,animated:true);
            
            
        }

        
        class func showNointernet(){
          
            let view = MessageView.viewFromNib(layout: .messageView)
            
            view.configureTheme(.error, iconStyle: .default)
            view.configureDropShadow()
            
            view.configureContent(body: "NO_INTERNET_CONNECTION".localized())
            view.titleLabel?.isHidden = true
            view.button?.isHidden = true
            view.tapHandler = {
                _ in
                
                SwiftMessages.hide()
            }
            
            SwiftMessages.show(view: view)
            
        }
        
//        class func ValidateRequirePassword(title:String?,description:String? ,placeHolder:String?,callback:@escaping ((_ valid:Bool)->()))  {
//            
//            // Create a custom view controller
//            let confirmPasswordPopup = TextFieldDialogViewController(nibName: "TextFieldDialogViewController", bundle: nil)
//           
//                confirmPasswordPopup.titleLabelString = title;
//                confirmPasswordPopup.descriptionLabelString = description;
//                confirmPasswordPopup.textFieldPlaceholderText = placeHolder;
//          
//            // Create the dialog
//            let popup = PopupDialog(viewController: confirmPasswordPopup, buttonAlignment: .vertical, transitionStyle: .bounceDown, gestureDismissal: false);
//
//            let buttonOne = CancelButton(title: "CANCEL") {
//
//            }
//            
//            
//            let buttonTwo = DefaultButton(title: "CONTINUE") {
//  
//                if let savedPassword = AppDefaultsAuth?.string(forKey: AppUserDefaults.savedPassword.rawValue) , let confirmPassword = confirmPasswordPopup.textField.text {
//                    
//                    if (savedPassword == confirmPassword){
//                        callback(true);
//                    }else {
//                      
//                        Shared.AlertDialog.alertWithDismiss("ERROR".localized(), message: "Your passowrd didnot match", image: nil, cancelTitleKey: "CLOSE".localized());
//                    
//                    }
//                }
//            }
//            
//            popup.addButtons([ buttonTwo , buttonOne])
//            
//            
//            UIApplication.present(popup,animated:true);
//            
//            
//        }
//        
        
    }
    
    class Functions {
        
       
        class func openSetting(){
            
            guard let settingsUrl = URL(string: UIApplicationOpenSettingsURLString) else {
                return
            }
            
            
            if UIApplication.shared.canOpenURL(settingsUrl) {
                if #available(iOS 10.0, *) {
                    UIApplication.shared.open(settingsUrl, completionHandler: { (success) in
                        print("Settings opened: \(success)") // Prints true
                    })
                } else {
                    UIApplication.shared.openURL(settingsUrl);
                    // Fallback on earlier versions
                }
            }
        }
        
        class func openYoutubeVideo(_ videoId: String) ->Bool {
            if let phoneCallURL:URL = URL(string:"youtube://\(videoId)") {
                let application:UIApplication = UIApplication.shared
                if (application.canOpenURL(phoneCallURL)) {
                    application.openURL(phoneCallURL);
                } else { 
                    let  weburl = URL(string:"https://www.youtube.com/watch?v=\(videoId)")!
                    UIApplication.shared.openURL(weburl)
                }
                return true;
            }else {
               let  weburl = URL(string:"https://www.youtube.com/watch?v=\(videoId)")!
                UIApplication.shared.openURL(weburl)
                return false;
            }
            
            
        }
        
        
        
        class func callPhone(_ number: String) ->Bool {
            if let phoneCallURL:URL = URL(string:"tel://\(number)") {
                let application:UIApplication = UIApplication.shared
                if (application.canOpenURL(phoneCallURL)) {
                    application.openURL(phoneCallURL);
                }
                return true;
            }else {
                
                Shared.AlertDialog.alertWithDismiss("SORRY".localized() , message: "FAILED_To_CALL".localized(), image: nil, cancelTitleKey: "CANCEL".localized(), cancelCompletion: nil)
                
               
                
                return false;
            }
            
            
        }
        
        class func openUrl(_ stringURL:String?) -> Bool{
            
            
            if let   urlString = stringURL  {
                if let url = URL(string: urlString) {
                if UIApplication.shared.canOpenURL(url)
                {
                    UIApplication.shared.openURL(url)
                    return true;
                } else {
                    return false;
                }
                }else{
                   return false;
                    
                }
            }else {
                return false;
            }
            
        }
        
        class  func openAppUrl(appUrl appURLString:String, fallback webURLString:String) {
            if let appURL = URL(string: appURLString) , let  webURL =  URL(string: webURLString) {
                if UIApplication.shared.canOpenURL(appURL as URL) {
                    if #available(iOS 10.0, *) {
                        UIApplication.shared.open(appURL as URL, options: [:], completionHandler: nil)
                    } else {
                        UIApplication.shared.openURL(appURL as URL)
                    }
                } else {
                    //redirect to safari because the user doesn't have Instagram
                    if #available(iOS 10.0, *) {
                        UIApplication.shared.open(webURL as URL, options: [:], completionHandler: nil)
                    } else {
                        UIApplication.shared.openURL(webURL as URL)
                    }
                }
            }else {
                assert(true, "appurl is not valid url ")
            }
        }
    }
    
    class Image {
        
        class func scaleImage (_ oldImage:UIImage?,width:Int?) -> UIImage?{
            if let cgImage = oldImage?.cgImage {
            
            let nwidth = width ?? cgImage.width / 2
            let nheight = ( cgImage.height * width! / cgImage.width ) ?? cgImage.height / 2
            let bitsPerComponent = cgImage.bitsPerComponent
            let bytesPerRow = cgImage.bytesPerRow
            let colorSpace = cgImage.colorSpace
            let bitmapInfo = cgImage.bitmapInfo
        
                if let  context = CGContext(data: nil, width: width!, height: nheight, bitsPerComponent: bitsPerComponent, bytesPerRow: bytesPerRow, space: colorSpace!, bitmapInfo: bitmapInfo.rawValue) {
            
                context.interpolationQuality = CGInterpolationQuality.medium;
           
                    context.draw(cgImage, in: CGRect(origin: CGPoint.zero, size: CGSize(width: CGFloat(nwidth), height: CGFloat(nheight))));
  
            let scaledImage = context.makeImage().flatMap { UIImage(cgImage: $0) }
                    return scaledImage
            }
            }
            
            
            return nil
            
        }
        
    }
    
   
}
