//
//  goodJobViewController.swift
//  mOTivator
//
//  Created by Chapman, Margaret E. on 4/28/16.
//  Copyright © 2016 Tufts. All rights reserved.
//
//  This view is displayed when the correct motion is detected.
//

import UIKit

class goodJobViewController: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.setHidesBackButton(true, animated:false)
        // Unwind after 2 seconds of displaying the view
        NSTimer.scheduledTimerWithTimeInterval(2, target: self, selector: #selector(goodJobViewController.doUnwind), userInfo: nil, repeats: false)
    }
    
    func doUnwind() {
        self.performSegueWithIdentifier("unwindgJobSegue", sender: self)
    }


}
