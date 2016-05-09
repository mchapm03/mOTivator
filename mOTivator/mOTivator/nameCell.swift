//
//  nameCell.swift
//  mOTivator
//
//  Created by Margaret Chapman on 4/21/16.
//  Copyright © 2016 Tufts. All rights reserved.
//
//  This class is used to add new tasks or modify existing ones. It allows users to add a name for the task.
//

import UIKit

class nameCell: UITableViewCell {
    
    @IBOutlet weak var nameInput: UITextField!
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
}
