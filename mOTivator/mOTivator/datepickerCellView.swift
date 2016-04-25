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
//    @IBOutlet weak var cellLabel: UILabel!
    @IBOutlet weak var datePicker: UIDatePicker!
    
    @IBOutlet weak var datePickerHeightConstraint: NSLayoutConstraint!
    
    
    var dateChange: ((NSDate) -> Void)?
//    class var bigHeight: CGFloat { get { return 200 } }
//    class var smallHeight: CGFloat  { get { return 44  } }

    override func awakeFromNib() {
        super.awakeFromNib()
        
        datePicker.addTarget(self, action: "pickerValueChange", forControlEvents: .ValueChanged)
    }
    
//    override func setSelected(selected: Bool, animated: Bool) {
//        super.setSelected(selected, animated: animated)
//    }
    
    func pickerValueChange() {
        dateChange?(datePicker.date)
    }
    
    func collapseCell () {
//        datePickerHeightConstraint.priority = 0
        datePickerHeightConstraint.constant = 0
        self.setNeedsUpdateConstraints()
        UIView.animateWithDuration(3) {
            self.layoutIfNeeded()
        }
    }
    
    func expandCell () {
//        datePickerHeightConstraint.priority = 1000
        datePickerHeightConstraint.constant = datePicker.intrinsicContentSize().height
        self.setNeedsUpdateConstraints()
        UIView.animateWithDuration(3) {
            self.layoutIfNeeded()
        }
    }
    
}