//
//  TaskListTableViewController.swift
//  mOTivator
//
//  Created by Chapman, Margaret E. on 4/3/16.
//  Copyright © 2016 Tufts. All rights reserved.
//
//  This is the View Controller for the tasks list view. The view shows the tasks for the client.
//

import UIKit

class TaskListTableViewController: UITableViewController {

    var tasks = [Task]()
    override func viewDidLoad() {
        super.viewDidLoad()

//        if let loadedTasks = loadTasks() {
//            tasks += loadedTasks
//        }else {
            loadSampleTasks()
//        }
    }
    
    func loadSampleTasks(){
        tasks = [Task(name: "Brush Teeth", icon: UIImage(named: "toothbrush")!, color: UIColor(red: CGFloat(0.96), green: CGFloat( 0.56), blue: CGFloat(0.56), alpha: CGFloat(1.0)), primaryTime: NSDate(timeIntervalSinceNow: 360), secondaryTime: nil, startDate:NSDate(timeIntervalSinceNow: -3600), endDate: NSDate(timeIntervalSince1970: 3600))!, Task(name: "Eat Lunch", icon: UIImage(named: "lunch")!, color: UIColor(red: CGFloat(0.58), green: CGFloat(0.77), blue: CGFloat(0.49), alpha: CGFloat(1.0)), primaryTime: NSDate(timeIntervalSinceNow: 60), secondaryTime: nil, startDate:NSDate(timeIntervalSinceNow: -3600), endDate: NSDate(timeIntervalSinceNow: 3600))!, Task(name: "Catch the bus", icon: UIImage(named: "schoolbus")!, color: UIColor(red: CGFloat(0.58), green: CGFloat( 0.77), blue: CGFloat(0.49), alpha: CGFloat(1.0)), primaryTime: NSDate(timeIntervalSinceNow: 60), secondaryTime: nil, startDate:NSDate(timeIntervalSinceNow: -3600), endDate: NSDate(timeIntervalSinceNow: 3600))!, Task(name: "Do homework", icon: UIImage(named: "homework")!, color: UIColor(red: CGFloat(1.0), green: CGFloat( 0.90), blue: CGFloat(0.60), alpha: CGFloat(1.0)), primaryTime: NSDate(timeIntervalSinceNow: 60), secondaryTime: nil, startDate:NSDate(timeIntervalSinceNow: -3600), endDate: NSDate(timeIntervalSinceNow: 3600))!]
    }
    
    // load tasks for given patient from database
    func loadTasks() -> [Task]? {
        //send query to heroku to get client tasks
        return []
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return tasks.count
    }

    // Update the table cells to show the task names and icons
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("taskCell", forIndexPath: indexPath)
        let thisTask = tasks[indexPath.row]
        cell.textLabel?.text = thisTask.name
        cell.imageView?.image = thisTask.icon

        return cell
    }


    
    // Override to support conditional editing of the table view.
    override func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }


    
    // Override to support editing the table view.
    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if editingStyle == .Delete {
            // Delete the row from the data source
            tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)
        } else if editingStyle == .Insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    

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
    @IBAction func unwindToMealList(sender: UIStoryboardSegue) {
        if let sourceViewController = sender.sourceViewController as? NewTaskViewController, task = sourceViewController.task {
            if let selectedIndexPath = tableView.indexPathForSelectedRow {
                // Update an existing task.
                // TODO: upload in server
                tasks[selectedIndexPath.row] = task
                tableView.reloadRowsAtIndexPaths([selectedIndexPath], withRowAnimation: .None)
            } else {
                // Add a new task.
                // TODO: add new task to server
                let newIndexPath = NSIndexPath(forRow: tasks.count, inSection: 0)
                tasks.append(task)
                tableView.insertRowsAtIndexPaths([newIndexPath], withRowAnimation: .Bottom)
            }
        // Save the meals.
        saveTasks()
        }
    }
    
    func saveTasks(){
        //TODO:save tasks here
    }
    
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "showDetail" {
            let taskDetailViewController = segue.destinationViewController as! NewTaskViewController
            
            // Get the cell that generated this segue.
            if let selectedTask = sender as? UITableViewCell {
                let thisTask = tasks[tableView.indexPathForCell(selectedTask)!.row]
                taskDetailViewController.task = thisTask
            }
        }
    }
    

}
