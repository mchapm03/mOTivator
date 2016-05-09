//
//  datepickerCellView.swift
//  mOTivator
//
//  Created by Margaret Chapman on 4/21/16.
//  Copyright © 2016 Tufts. All rights reserved.
//
//  This class is used in table that enables users to add new tasks to the app. It displays the date that the task is scheduled for and expands to a datepicker when clicked.
//

import UIKit

class datepickerCellView: UITableViewCell {
    
    @IBOutlet weak var typeLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var date: UIDatePicker!
    
    // height is 200 when expanded, and 44 normally
    class var bigHeight: CGFloat { get { return 200 } }
    class var smallHeight: CGFloat  { get { return 44  } }

    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
}
