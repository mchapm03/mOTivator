//
//  ViewController.swift
//  mOTivator
//
//  Created by Margaret Chapman on 3/29/16.
//  Copyright © 2016 Tufts. All rights reserved.
//
//  This view is the first view that users will see. It is the launching point where OTs will be directed to their part of the app, and patients will be directed to their part.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var otButton: UIButton!
    @IBOutlet weak var studentButton: UIButton!
    
    // Make the OT button gru, and the student button a student minion
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        otButton.setBackgroundImage(UIImage(named: "Gru-OT")!, forState: UIControlState.Normal)
        studentButton.setBackgroundImage(UIImage(named: "student-minion")!, forState: UIControlState.Normal)
    }
    
    override func viewDidLoad() {
       
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

