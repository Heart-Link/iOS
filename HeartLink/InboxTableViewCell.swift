//
//  InboxTableViewCell.swift
//  HeartLink
//
//  Created by User on 9/09/2016.
//  Copyright (c) 2016 Max. All rights reserved.
//

import UIKit

class InboxTableViewCell: UITableViewCell {
    
    @IBOutlet weak var subjectLabel: UILabel!
    @IBOutlet weak var senderLabel: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
