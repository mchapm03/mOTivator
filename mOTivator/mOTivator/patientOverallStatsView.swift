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
        tasks = [Task(name: "Brush Teeth", icon: UIImage(named: "toothbrush")!, color: UIColor(red: CGFloat(0.96), green: CGFloat( 0.56), blue: CGFloat(0.56), alpha: CGFloat(1.0)), primaryTime: NSDate(timeIntervalSinceNow: 60), secondaryTime: nil, startDate:NSDate(timeIntervalSinceNow: -3600), endDate: NSDate(timeIntervalSinceNow: 3600))!, Task(name: "Eat Lunch", icon: UIImage(named: "lunch")!, color: UIColor(red: CGFloat(0.58), green: CGFloat(0.77), blue: CGFloat(0.49), alpha: CGFloat(1.0)), primaryTime: NSDate(timeIntervalSinceNow: 60), secondaryTime: nil, startDate:NSDate(timeIntervalSinceNow: -3600), endDate: NSDate(timeIntervalSinceNow: 3600))!, Task(name: "Catch the bus", icon: UIImage(named: "schoolbus")!, color: UIColor(red: CGFloat(0.58), green: CGFloat( 0.77), blue: CGFloat(0.49), alpha: CGFloat(1.0)), primaryTime: NSDate(timeIntervalSinceNow: 60), secondaryTime: nil, startDate:NSDate(timeIntervalSinceNow: -3600), endDate: NSDate(timeIntervalSinceNow: 3600))!, Task(name: "Do homework", icon: UIImage(named: "homework")!, color: UIColor(red: CGFloat(1.0), green: CGFloat( 0.90), blue: CGFloat(0.60), alpha: CGFloat(1.0)), primaryTime: NSDate(timeIntervalSinceNow: 60), secondaryTime: nil, startDate:NSDate(timeIntervalSinceNow: -3600), endDate: NSDate(timeIntervalSinceNow: 3600))!]

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
        cell.textLabel?.textColor = tasks[indexPath.row].color
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