//
//  clientTableViewController.swift
//  mOTivator
//
//  Created by Margaret Chapman on 3/31/16.
//  Copyright © 2016 Tufts. All rights reserved.
//

import UIKit

class clientTableViewController: UITableViewController {
    
    var patients = [Patient]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // load all patients to table
        if let loadedPatients = loadPatients() {
            patients += loadedPatients
        }else {
            loadSamplePatients()
        }
    }
    
    // loadPatients gets all patients stored on the server, and returns them in an array
    func loadPatients() -> [Patient]?{
        return []
    }
    
    // loadSamplePatients populates the patients array with fake patients
    func loadSamplePatients() {
        patients += [Patient(name: "Ron")!, Patient(name: "Ming")!]
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: - Table view data source
    
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        // return the number of sections
        return 1
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // return the number of rows
        return patients.count
    }
    
    /*
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCellWithIdentifier("reuseIdentifier", forIndexPath: indexPath)
    
    // Configure the cell...
    
    return cell
    }
    */
    
    /*
    // Override to support conditional editing of the table view.
    override func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
    // Return false if you do not want the specified item to be editable.
    return true
    }
    */
    
    /*
    // Override to support editing the table view.
    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
    if editingStyle == .Delete {
    // Delete the row from the data source
    tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)
    } else if editingStyle == .Insert {
    // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }
    }
    */
    
    /*
    // Override to support rearranging the table view.
    override func tableView(tableView: UITableView, moveRowAtIndexPath fromIndexPath: NSIndexPath, toIndexPath: NSIndexPath) {
    
    }
    */
    
    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(tableView: UITableView, canMoveRowAtIndexPath indexPath: NSIndexPath) -> Bool {
    // Return false if you do not want the item to be re-orderable.
    return true
    }
    */
    
    
    // MARK: - Navigation
    
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // If segue for a patient stats view, set that patient to the selected one
        if segue.identifier == "showClientDetails" {
            let patientViewController = segue.destinationViewController as! patientOverallStatsView
            if let selectedpatient = sender as? Patient {
                patientViewController.patient = selectedpatient
            }
        }
    }

    
}