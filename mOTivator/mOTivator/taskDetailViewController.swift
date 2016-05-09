//
//  taskDetailViewController.swift
//  mOTivator
//
//  Created by Chapman, Margaret E. on 4/29/16.
//  Copyright © 2016 Tufts. All rights reserved.
//
//  This class shows specific details about each specific task. It shows a graph of the task and some data points.
//

import UIKit

class taskDetailViewController: UIViewController {

    @IBOutlet weak var taskProgressGraph: OverallGraphView!
    var task:Task?
    override func viewDidLoad() {
        super.viewDidLoad()
        if let t1 = task {
            navigationItem.title = t1.name
        }

    }
}
