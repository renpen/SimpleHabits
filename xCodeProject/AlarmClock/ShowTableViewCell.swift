//
//  ShowTableViewCell.swift
//  AlarmClock
//
//  Created by Bene on 17/11/2016.
//  Copyright © 2016 ReneUser. All rights reserved.
//

import UIKit

class ShowTableViewCell: UITableViewCell {
    
    @IBOutlet weak var alarmName: UILabel!
    @IBOutlet weak var alarmSource: UILabel!
    @IBOutlet weak var alarmDestination: UILabel!
    @IBOutlet weak var offsetLabel: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
