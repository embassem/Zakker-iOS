//
//  TimelineViewProtocol.swift
//  Guest-iOS
//
//  Created by Bassem on 7/9/17.
//  Copyright © 2017 Ibtikar. All rights reserved.
//

import Foundation

protocol TimelineViewDelegate: class {

    func didGetModel()
    func didGetTimelineByMonth()
    func clearList()
}
