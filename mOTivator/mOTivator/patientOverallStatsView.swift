//
//  patientOverallStats.swift
//  mOTivator
//
//  Created by Margaret Chapman on 3/31/16.
//  Copyright © 2016 Tufts. All rights reserved.
//

import UIKit

class patientOverallStatsView: UIViewController {
    
    var patient : Patient?
    override func viewDidLoad() {
        super.viewDidLoad()
        if let p1 = patient {
            navigationItem.title = p1.name
        }

    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    
    // MARK: - Navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {

    }

}