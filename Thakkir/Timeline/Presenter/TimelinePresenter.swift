//
//  TimelinePresenter.swift
//  Guest-iOS
//
//  Created by Bassem on 7/9/17.
//  Copyright © 2017 Ibtikar. All rights reserved.
//

import Foundation

class TimelinePresenter : TimelinePresenterDelegate {
    
     weak var view: TimelineViewDelegate?
    var selectedDate:Date?
    
    
    required init(view: TimelineViewDelegate) {
        self.view = view
    }
    
}
