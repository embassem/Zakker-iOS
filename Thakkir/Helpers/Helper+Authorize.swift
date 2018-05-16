//
//  Helper_Authorize.swift
//  GooTaxiClient
//
//  Created by Bassem Abbas on 4/28/17.
//  Copyright © 2017 ADLANC. All rights reserved.
//

import Foundation

import Foundation
import ObjectMapper
import SwiftyJSON
import Crashlytics
import Firebase
import UserNotifications
 extension Helper {
    
     class Authorize {
        
        static var loginResponse : LoginResponse? {
            
            get{
                
              return   self.getLoginResponse();
            }
            
        }
        
         class func logOutUser(){
            
            appDefaultsAuthorized.removeObject(forKey: AppUserDefaults.userinfo.rawValue)
            appDefaultsAuthorized.removeSuite(named: "net.sa.ibtikar.moia.guest.authorize");
            appDefaultsAuthorized.synchronize()
            appDefault.removeObject(forKey: AppUserDefaults.userinfo.rawValue)
            appDefault.removeSuite(named: "net.sa.ibtikar.moia.guest.authorize")
            appDefault.synchronize();
            if #available(iOS 10.0, *) {
                UNUserNotificationCenter.current().removeAllDeliveredNotifications()
            }
                   
                UIApplication.shared.applicationIconBadgeNumber = 0;
               
            
            appDelegate.initCorrectView();
        }
        
        
          class  func  updateLoginResponse( _ loginResponse:LoginResponse)
        {
            
              Crashlytics.sharedInstance().setUserName(loginResponse.user?.fullEngName)
              Crashlytics.sharedInstance().setUserIdentifier(Messaging.messaging().fcmToken)
//            loginResponse.user?.flag = nil;
//            loginResponse.moiaLoginResponse?.user.flag = nil;
            
            let loginResponseString = Mapper().toJSONString(loginResponse, prettyPrint: false)
            appDefaultsAuthorized.set(loginResponseString!, forKey: AppUserDefaults.userinfo.rawValue);
            appDefaultsAuthorized.synchronize()
        
//            debugPrint(loginResponse.toJSONString());
        }
        
        fileprivate class func getLoginResponse()->(LoginResponse?)
        {
            if let UserSettingObj = appDefaultsAuthorized.object(forKey: AppUserDefaults.userinfo.rawValue) as? String{
                let jsonObj:JSON =  JSON(UserSettingObj)
                let UserObject = Mapper<LoginResponse>().map(JSONString:jsonObj.rawString()!);
            
                // print(UserObject?.userName);
                return UserObject;
            }
            
            return nil;
            
        }
        

        
        
    }
    
    
    
}
