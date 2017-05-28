//
//  dateTableViewCell.swift
//  Thakkir
//
//  Created by Bassem Abbas on 6/12/16.
//  Copyright © 2016 Bassem Abbas. All rights reserved.
//

import UIKit

class dateTableViewCell: UITableViewCell {
    
    var cellDate:Date?
    
    @IBOutlet weak var lblTitle: UILabel!
    
    
    func setIslamicDate (){
        
        var islamicCalender = Calendar(identifier: Calendar.Identifier.islamicUmmAlQura)
        islamicCalender.locale = Locale.current;
        //        let components = islamicCalender.components(NSCalendarUnit(rawValue: UInt.max), fromDate: day)
        //
        //        let arFormatter = NSNumberFormatter()
        //        arFormatter.locale = NSLocale(localeIdentifier: "ar_SA")
       
        
        let dateFormatter = DateFormatter()
        // dateFormatter.dateFormat = "MMM dd YYYY"
        dateFormatter.dateStyle = DateFormatter.Style.full
        dateFormatter.timeStyle = .none
        dateFormatter.calendar = islamicCalender;
        dateFormatter.locale = Locale.current
        
        lblTitle.text =   dateFormatter.string(  from: self.cellDate!);
        lblTitle.sizeToFit();
        
    }
}
