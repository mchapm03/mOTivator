//
//  studentViewController.swift
//  mOTivator
//
//  Created by Chapman, Margaret E. on 4/19/16.
//  Copyright © 2016 Tufts. All rights reserved.
//

import UIKit

class studentViewController: UIViewController, UITableViewDataSource, UITableViewDelegate  {
    
    @IBOutlet weak var startActivityButton: UIButton!
    @IBOutlet weak var scheduleTaskButton: UIButton!
    @IBOutlet weak var taskTable: UITableView!
    var tasks = [Task]()

    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        startActivityButton.setBackgroundImage(UIImage(named: "showering-minion")!, forState: UIControlState.Normal)
        scheduleTaskButton.setBackgroundImage(UIImage(named: "schedule-minion")!, forState: UIControlState.Normal)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        taskTable.delegate = self
        taskTable.dataSource = self
        
//        if let loadedTasks = loadTasks() {
//            tasks += loadedTasks
//        }else {
            loadSampleTasks()
//        }
    }
    
    // load tasks from the server for this patient
    func loadTasks() -> [Task] {
        return []
    }
    
    func loadSampleTasks() {
        tasks = [Task(name: "Brush Teeth", icon: UIImage(named: "toothbrush")!, color: UIColor(red: CGFloat(0.96), green: CGFloat( 0.56), blue: CGFloat(0.56), alpha: CGFloat(1.0)), primaryTime: NSDate(timeIntervalSinceNow: 600), secondaryTime: nil, startDate:NSDate(timeIntervalSinceNow: -3600), endDate: NSDate(timeIntervalSinceNow: 3600))!, Task(name: "Eat Lunch", icon: UIImage(named: "lunch")!, color: UIColor(red: CGFloat(0.58), green: CGFloat(0.77), blue: CGFloat(0.49), alpha: CGFloat(1.0)), primaryTime: NSDate(timeIntervalSinceNow: 60), secondaryTime: nil, startDate:NSDate(timeIntervalSinceNow: -3600), endDate: NSDate(timeIntervalSinceNow: 3600))!, Task(name: "Catch the bus", icon: UIImage(named: "schoolbus")!, color: UIColor(red: CGFloat(0.58), green: CGFloat( 0.77), blue: CGFloat(0.49), alpha: CGFloat(1.0)), primaryTime: NSDate(timeIntervalSinceNow: 60), secondaryTime: nil, startDate:NSDate(timeIntervalSinceNow: -3600), endDate: NSDate(timeIntervalSinceNow: 3600))!, Task(name: "Do homework", icon: UIImage(named: "homework")!, color: UIColor(red: CGFloat(1.0), green: CGFloat( 0.90), blue: CGFloat(0.60), alpha: CGFloat(1.0)), primaryTime: NSDate(timeIntervalSinceNow: 60), secondaryTime: nil, startDate:NSDate(timeIntervalSinceNow: -3600), endDate: NSDate(timeIntervalSinceNow: 3600))!]
        
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tasks.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("myTask", forIndexPath: indexPath)
        cell.textLabel?.text = tasks[indexPath.row].name
        cell.imageView?.image = tasks[indexPath.row].icon
        return cell
    }
    
    func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if editingStyle == .Delete {
            // Delete the row from the data source
            tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)
        } else if editingStyle == .Insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }
    }

    
    // MARK: - Navigation
    @IBAction func unwindToTaskList(sender: UIStoryboardSegue) {
        if let sourceViewController = sender.sourceViewController as? NewTaskViewController, task = sourceViewController.task {
            if let selectedIndexPath = taskTable.indexPathForSelectedRow {
                // Update an existing task.
                // TODO: upload in server
                tasks[selectedIndexPath.row] = task
                taskTable.reloadRowsAtIndexPaths([selectedIndexPath], withRowAnimation: .None)
               // task.setNotifications()

            } else {
                // Add a new task.
                // TODO: add new task to server
                let newIndexPath = NSIndexPath(forRow: tasks.count, inSection: 0)
                tasks.append(task)
                print("in tasks")
                print(tasks)
                taskTable.insertRowsAtIndexPaths([newIndexPath], withRowAnimation: .Bottom)                
            }
            // Save the tasks.
            saveTasks()
        }
    }
    
    func saveTasks(){
        //TODO:save tasks here
    }
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "showDetail" {
            let taskDetailViewController = segue.destinationViewController as! NewTaskViewController
            
            // Get the cell that generated this segue.
            if let selectedTask = sender as? UITableViewCell {
                let thisTask = tasks[taskTable.indexPathForCell(selectedTask)!.row]
                taskDetailViewController.task = thisTask
            }
        }
    }
    
}