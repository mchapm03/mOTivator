//
//  careTakerCell.swift
//  mOTivator
//
//  Created by Margaret Chapman on 4/21/16.
//  Copyright © 2016 Tufts. All rights reserved.
//

import UIKit

class careTakerCell: UITableViewCell {

    @IBOutlet weak var caretakerName: UITextField!
    @IBOutlet weak var careTakerEmail: UITextField!
    @IBOutlet weak var careTakerNotes: UITextView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
}