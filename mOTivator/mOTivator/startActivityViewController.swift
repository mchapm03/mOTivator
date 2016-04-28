//
//  startActivityViewController.swift
//  mOTivator
//
//  Created by Chapman, Margaret E. on 4/17/16.
//  Copyright © 2016 Tufts. All rights reserved.
//

import UIKit

class startActivityViewController: UIViewController {
    @IBOutlet weak var startActivityButton: UIButton!

    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        startActivityButton.setBackgroundImage(UIImage(named: "showering-minion")!, forState: UIControlState.Normal)
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        
        detectMovement()
        
    }
    
    func detectMovement() {
        performSegueWithIdentifier("goodJobSegue", sender: self)
    }
    
}
