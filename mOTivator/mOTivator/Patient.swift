//
//  Patient.swift
//  mOTivator
//
//  Created by Margaret Chapman on 3/31/16.
//  Copyright © 2016 Tufts. All rights reserved.
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