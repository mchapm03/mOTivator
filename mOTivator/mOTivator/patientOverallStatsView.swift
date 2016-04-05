//
//  patientOverallStats.swift
//  mOTivator
//
//  Created by Margaret Chapman on 3/31/16.
//  Copyright © 2016 Tufts. All rights reserved.
//

import UIKit

class patientOverallStatsView: UIViewController, UITableViewDataSource, UITableViewDelegate  {
    
    var patient : Patient?
    var tasks = [Task]()
    // For graph:
    // TODO: add labels
    @IBOutlet weak var overallGraphView: OverallGraphView!
    @IBOutlet weak var taskTable: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if let p1 = patient {
            navigationItem.title = p1.name
        }
        
        //for graph:
        //        setupGraphDisplay()
        
        //TODO: get all this user's tasks
//        if let tasklist = loadTasks(){
//            tasks += tasklist
//        }else{
            loadSampleTasks()
//        }
        taskTable.delegate = self
        taskTable.dataSource = self
    }
    
    // load tasks from the server for this patient
    func loadTasks() -> [Task] {
        return []
    }
    
    func loadSampleTasks() {
        tasks = [Task(name: "Brush Teeth", icon: UIImage(named: "toothbrush")!)!]
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tasks.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("ptTask", forIndexPath: indexPath)
        cell.textLabel?.text = tasks[indexPath.row].name
        cell.imageView?.image = tasks[indexPath.row].icon
        return cell
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