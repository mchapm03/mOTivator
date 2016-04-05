//
//  Task.swift
//  mOTivator
//
//  Created by Margaret Chapman on 3/31/16.
//  Copyright © 2016 Tufts. All rights reserved.
//

import UIKit
import Foundation

class Task {
    // Mark: Properties
    var name: String
    // TODO: figure out type of icon
    var icon: UIImage
    // TODO: figure time format
    var primaryTime:NSDate?
    var secondaryTime:NSDate?
    var timeAssigned = [NSDate]()
    var caretaker : (String, Int)?
    var record = [(NSDate, Bool)]()
    
    init?(name: String, icon: UIImage){
        self.name = name
        self.icon = icon
        
        if (name.isEmpty){
            return nil
        }
    }
}
