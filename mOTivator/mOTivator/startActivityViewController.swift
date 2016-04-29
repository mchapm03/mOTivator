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
    
    var task: String?

    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        startActivityButton.setBackgroundImage(UIImage(named: "showering-minion")!, forState: UIControlState.Normal)
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        
        detectMovement()
        
    }
    
    func detectMovement() {
        let detected = true
        // Movement was detected, take user to Good Job View!
        if detected {
            //performSegueWithIdentifier("goodJobSegue", sender: self)
            startActivityButton.sendActionsForControlEvents(.TouchUpInside)
        }
        // Activity was not detected, alert user, let them try again, or take them to their "home view"
        else {
            let alert = UIAlertController(title: "Alert", message: "No task detected", preferredStyle: UIAlertControllerStyle.Alert)

            alert.addAction(UIAlertAction(title: "Ok", style: UIAlertActionStyle.Default, handler: {
                                (action: UIAlertAction!) in self.performSegueWithIdentifier("unwindSeg", sender: self) }))

            alert.addAction(UIAlertAction(title: "Try Again", style: UIAlertActionStyle.Default, handler: nil))
            self.presentViewController(alert, animated: true, completion: nil)
        }
    }
    
    override func canPerformUnwindSegueAction(action: Selector, fromViewController: UIViewController, withSender sender: AnyObject) -> Bool {
        return false
    }
}
