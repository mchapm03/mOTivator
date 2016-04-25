//
//  nameCell.swift
//  mOTivator
//
//  Created by Margaret Chapman on 4/21/16.
//  Copyright © 2016 Tufts. All rights reserved.
//

import UIKit

class nameCell: UITableViewCell {
    @IBOutlet weak var cellLabel: UILabel!
    @IBOutlet weak var nameLabel: UITextField!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
}
