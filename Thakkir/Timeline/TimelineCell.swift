//
//  TimelineCalenderCell.swift
//  Guest-iOS
//
//  Created by Bassem on 7/20/17.
//  Copyright © 2017 Ibtikar. All rights reserved.
//

import Foundation
import UIKit
import SwiftDate
import JTAppleCalendar
import SwifterSwift

class TimelineCell: JTAppleCell {
    
    @IBOutlet var dateLabel: UILabel!
    
    @IBOutlet weak var cellHighlight: UIView!
    
    @IBOutlet var hijridateLabel: UILabel!
    
    func configure(for state: CellState) {
        
        
        
    let dateInRegion =   Helper.Date.getIslamicDate(date: state.date)

//        print(dateInRegion.georgianRegion.string(format: .custom("MMM dd  YYYY")), dateInRegion.ummAlQuraRegion.string(format: .custom("MMM dd  YYYY")))
        
        dateLabel.text = dateInRegion.georgianRegion.day.string
        hijridateLabel.text = dateInRegion.ummAlQuraRegion.day.string;
        
        if state.date.isToday {
            dateLabel.textColor = .red
        }

    }
    
    override func prepareForReuse() {
        dateLabel.textColor = #colorLiteral(red: 0.4497648478, green: 0.3633997738, blue: 0.1444568336, alpha: 1)
        dateLabel.text = " -- "
        self.borderWidth = 0;
        self.backgroundColor = .clear
        
    }
    
  

    
}
