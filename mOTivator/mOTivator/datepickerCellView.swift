//
//  datepickerCellView.swift
//  mOTivator
//
//  Created by Margaret Chapman on 4/21/16.
//  Copyright © 2016 Tufts. All rights reserved.
//

import UIKit

class datepickerCellView: UITableViewCell {
//    var isEditing = false
    
    @IBOutlet weak var typeLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var date: UIDatePicker!
    
    class var bigHeight: CGFloat { get { return 200 } }
    class var smallHeight: CGFloat  { get { return 44  } }

    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
}
