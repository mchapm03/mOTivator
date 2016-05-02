//
//  Patient.swift
//  mOTivator
//
//  Created by Margaret Chapman on 3/31/16.
//  Copyright © 2016 Tufts. All rights reserved.
//
//  The Patient Class defines the data structure for each patient instance. A patient has a name and a list of Tasks.
//

import UIKit

class Patient {


    // MARK: Properties
    var name: String
    var tasks = [Task]()
    
    
    init?(name: String){
        self.name = name
        
        if name.isEmpty{
            return nil
        }
    }


}