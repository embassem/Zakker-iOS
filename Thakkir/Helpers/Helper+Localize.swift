//
//  Helper+Localize.swift
//  Guest-iOS
//
//  Created by Bassem on 8/7/17.
//  Copyright © 2017 Ibtikar. All rights reserved.
//

import Foundation



extension Helper {
    
   public class  Localized : Localize {
        
       // This Class is A Wrapper for Localized Swift  ;
       
    public enum AppLanguageEnum : String {
        case Arabic = "ar"
        case English  = "en"
    }
    
    
    
    var keys =   ["No survey publish".localized()]
    
    
    public class func setLanguage(newLang: String){
        
        self.setCurrentLanguage(newLang)
        LanguageManager.saveLanguage(byCode: newLang)
        
    }
    
    
    
    }
    
    
   
}
