//
//  NSDate.swift
//  Thakkir
//
//  Created by Bassem Abbas on 6/8/16.
//  Copyright © 2016 Bassem Abbas. All rights reserved.
//

import Foundation
import AFDateHelper
extension Date{
    
    static func GetDateOnly() ->Date{
        
        
        let normalCalender = Calendar(identifier: Calendar.Identifier.iso8601)
        
        let day :Date =  normalCalender.startOfDay(for: Date())
        
        let dateComponents = (normalCalender as NSCalendar).components(NSCalendar.Unit(rawValue: UInt.max), from: day)
        
        let startDate = dateComponents.date?.addingTimeInterval(TimeInterval(TimeZone.current.secondsFromGMT()));           
        
        return startDate!
        
    }
    
    func dateByAddingDay(_ days:Int) -> Date{
        let dateComponunt = DateComponents(day:days);

        
        let newdate = Calendar.current.date(byAdding: dateComponunt, to: self);
        
        return newdate!;
        
        
    }
    
    
    
}
