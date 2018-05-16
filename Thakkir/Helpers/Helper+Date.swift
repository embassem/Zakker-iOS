//
//  Helper+Date.swift
//  Guest-iOS
//
//  Created by Bassem on 7/20/17.
//  Copyright © 2017 Ibtikar. All rights reserved.
//

import Foundation
import SwiftDate


extension Helper {
    
    class  Date {
        
        static var correctionDays = 0;
        class func getIslamicDate(date:Foundation.Date) -> IslamicDate {
            var local = LocaleName.current;
            if (Helper.Localized.currentLanguage() == Helper.Localized.AppLanguageEnum.Arabic.rawValue)  {
              local = LocaleName.arabic
            }else {
                local = LocaleName.english
            }
            let regionKSAIslamic = Region(tz: TimeZoneName.current, cal: CalendarName.islamicUmmAlQura, loc: local)
            
            let regionKSAGorgian  = Region(tz: TimeZoneName.current, cal: CalendarName.gregorian, loc: local)
            
            
            let dateInRegionKSAGorgian = DateInRegion(absoluteDate: date, in: regionKSAGorgian)
            
            let islamicDay = date + correctionDays.days
            // Resulting object is DateInRegion which express the current moment in Rome
            let dateInRegionKSAIslamic = DateInRegion(absoluteDate: islamicDay, in: regionKSAIslamic)
            
            let region = IslamicDate(georgianRegion: dateInRegionKSAGorgian, ummAlQuraRegion: dateInRegionKSAIslamic);
            
            return region
            
        }
        
        
        class func getyoutubeDate(date:Foundation.Date) -> String {
            var local = LocaleName.english;
           
            let region = Region(tz: TimeZoneName.current, cal: CalendarName.gregorian, loc: local)
            
          
            
            let dateInRegion = DateInRegion(absoluteDate: date, in: region)
        
            
          return  dateInRegion.string(custom: Config.youtubeDateFormater)
            
            
            
        }
        
    }
    
}


struct IslamicDate {
    
    var georgianRegion: DateInRegion!
    var ummAlQuraRegion: DateInRegion!
    
    public init(georgianRegion: DateInRegion!, ummAlQuraRegion: DateInRegion!) {
        self.georgianRegion = georgianRegion
        self.ummAlQuraRegion = ummAlQuraRegion
    }
}
