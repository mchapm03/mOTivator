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
    
    // For graph:
    // TODO: add labels
    @IBOutlet weak var overallGraphView: OverallGraphView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if let p1 = patient {
            navigationItem.title = p1.name
        }
        
        //for graph:
        //        setupGraphDisplay()


    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    
    // MARK: - Navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {

    }
    /*
    // Set up graph:
    // create line graph view
    func setupGraphDisplay() {
        if let maxPoint = overallGraphView.graphPoints.maxElement() {
            if maxPoint > overallGraphView.graphPointsBad.maxElement(){
                maxLabel.text = "\(maxPoint)"
            }
            maxLabel.text = "\(overallGraphView.graphPointsBad.maxElement()!)"
        }
        else {
            maxLabel.text = ""
        }
    }*/

}