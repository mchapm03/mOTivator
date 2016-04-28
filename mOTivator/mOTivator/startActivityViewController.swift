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
        let detected = false
        // Movement was detected, take user to Good Job View!
        if detected {
            //performSegueWithIdentifier("goodJobSegue", sender: self)
            startActivityButton.sendActionsForControlEvents(.TouchUpInside)
        }
        // Activity was not detected, alert user, let them try again, or take them to their "home view"
        else {
            let storyboard = UIStoryboard(name: "Main", bundle: nil)
            let viewController: studentViewController = storyboard.instantiateViewControllerWithIdentifier("studentView") as! studentViewController
            
            let alert = UIAlertController(title: "Alert", message: "No task detected", preferredStyle: UIAlertControllerStyle.Alert)
            alert.addAction(UIAlertAction(title: "Ok", style: UIAlertActionStyle.Default, handler: {
                (action: UIAlertAction!) in self.presentViewController(viewController, animated: true, completion: nil)}))
            alert.addAction(UIAlertAction(title: "Try Again", style: UIAlertActionStyle.Default, handler: nil))
            self.presentViewController(alert, animated: true, completion: nil)
        }
    }
    
}
