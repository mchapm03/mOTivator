//
//  careTakerCell.swift
//  mOTivator
//
//  Created by Margaret Chapman on 4/21/16.
//  Copyright © 2016 Tufts. All rights reserved.
//
//  This class is used to add new tasks or modify existing ones. It allows users to add a caretaker name, a cartaker email
//  and notes for the caretaker to the task.
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
