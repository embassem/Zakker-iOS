//
//  TimeLineTableViewCell.swift
//  Guest-iOS
//
//  Created by Bassem on 7/20/17.
//  Copyright © 2017 Ibtikar. All rights reserved.
//

import UIKit

class TimeLineTableViewCell: UITableViewCell {

    
    @IBOutlet weak var dayLabel: UILabel!
    @IBOutlet weak var endDateLabel: UILabel!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
