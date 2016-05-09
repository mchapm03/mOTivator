//
//  taskCompletedCell.swift
//  mOTivator
//
//  Created by Margaret Chapman on 5/9/16.
//  Copyright © 2016 Tufts. All rights reserved.
//
//  This cell is used to show dates where tasks were/weren't completed.
//

import UIKit

class taskCompletedCell: UITableViewCell {
    
    @IBOutlet weak var completedLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
}