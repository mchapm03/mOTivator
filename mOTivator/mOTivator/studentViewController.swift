//
//  studentViewController.swift
//  mOTivator
//
//  Created by Chapman, Margaret E. on 4/19/16.
//  Copyright © 2016 Tufts. All rights reserved.
//
//  This is the view controller for the first view that patients see upon opening the app. It displays all of their scheduled tasks, and has a button to allow them to add new tasks.
//  

import UIKit

class studentViewController: UIViewController, UITableViewDataSource, UITableViewDelegate  {
    
    @IBOutlet weak var scheduleTaskButton: UIButton!
    @IBOutlet weak var taskTable: UITableView!
    var tasks = [Task]()

    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
//        startActivityButton.setBackgroundImage(UIImage(named: "showering-minion")!, forState: UIControlState.Normal)
        scheduleTaskButton.setBackgroundImage(UIImage(named: "schedule-minion")!, forState: UIControlState.Normal)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        taskTable.delegate = self
        taskTable.dataSource = self
        
        
        
//        if let loadedTasks = loadTasks() as? [Task] {
            tasks += loadTasks()
//        }else {
//            loadSampleTasks()
//        }
    }
    
    // load tasks from the server for this patient
    func loadTasks() -> [Task] {
        var loadedTasks = []
        // THIS REQUEST GETS STUFF
        if let url = NSURL(string: "http://192.168.43.34:3000/getTasks"){
            let session = NSURLSession.sharedSession()
            let request = NSMutableURLRequest(URL: url)
            request.HTTPMethod = "POST"
            let task = session.dataTaskWithRequest(request){
                (let data, let response, let error) -> Void in
                
                if error != nil {
                    print ("whoops, something went wrong! Details: \(error!.localizedDescription); \(error!.userInfo)")
                }
                
                if data != nil {
                    do{
                        let raw = try NSJSONSerialization.JSONObjectWithData(data!, options: .MutableContainers)
                        
                        if let json = raw as? [[String: AnyObject]] {
                            for entry in json {
                                print("entry: \(entry["type"])")
                                // Add new task to loadedTasks
                                //Task(name: entry["type"], icon: UIImage(named: entry["icon"], color: entry["colorAll"], primaryTime: entry["completionTime"], secondaryTime: nil, startDate: entry["startDate"], endDate: entry["endDate"])
                                //                                print("json: \(entry[""])")
                            }
                        }
                    }
                        
                    catch{
                        print("other object")
                    }
                }
            }
            task.resume()
            
        
        }
        return loadedTasks as! [Task]
    }
    
    // load sample tasks
    func loadSampleTasks() {
        tasks = [Task(name: "Brush Teeth", icon: UIImage(named: "toothbrush")!, color: UIColor(red: CGFloat(0.96), green: CGFloat( 0.56), blue: CGFloat(0.56), alpha: CGFloat(1.0)), primaryTime: NSDate(timeIntervalSinceNow: 600), secondaryTime: nil, startDate:NSDate(timeIntervalSinceNow: -3600), endDate: NSDate(timeIntervalSinceNow: 3600))!, Task(name: "Eat Lunch", icon: UIImage(named: "lunch")!, color: UIColor(red: CGFloat(0.58), green: CGFloat(0.77), blue: CGFloat(0.49), alpha: CGFloat(1.0)), primaryTime: NSDate(timeIntervalSinceNow: 10), secondaryTime: nil, startDate:NSDate(timeIntervalSinceNow: -3600), endDate: NSDate(timeIntervalSinceNow: 3600))!, Task(name: "Catch the bus", icon: UIImage(named: "schoolbus")!, color: UIColor(red: CGFloat(0.58), green: CGFloat( 0.77), blue: CGFloat(0.49), alpha: CGFloat(1.0)), primaryTime: NSDate(timeIntervalSinceNow: 60), secondaryTime: nil, startDate:NSDate(timeIntervalSinceNow: -3600), endDate: NSDate(timeIntervalSinceNow: 3600))!, Task(name: "Do homework", icon: UIImage(named: "homework")!, color: UIColor(red: CGFloat(1.0), green: CGFloat( 0.90), blue: CGFloat(0.60), alpha: CGFloat(1.0)), primaryTime: NSDate(timeIntervalSinceNow: 60), secondaryTime: nil, startDate:NSDate(timeIntervalSinceNow: -3600), endDate: NSDate(timeIntervalSinceNow: 3600))!]
        tasks[1].setNotifications()
        
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
                tasks[selectedIndexPath.row] = task
                taskTable.reloadRowsAtIndexPaths([selectedIndexPath], withRowAnimation: .None)
                task.setNotifications()

            } else {
                // Add a new task.
                let newIndexPath = NSIndexPath(forRow: tasks.count, inSection: 0)
                tasks.append(task)
                print("in tasks")
                print(tasks)
                taskTable.insertRowsAtIndexPaths([newIndexPath], withRowAnimation: .Bottom)
                
                // Save the task to the server
                if let url = NSURL(string: "http://192.168.43.34:3000/addTask"){
                    let session = NSURLSession.sharedSession()
                    let request = NSMutableURLRequest(URL: url)
                    request.HTTPMethod = "POST"
                    // PUT IN THE PARAMS
                    let paramString = "type=\(task.name)&startDate=\(task.startDate)&endDate=\(task.endDate)&completionTime=\(task.primaryTime)&icon=\(task.icon.accessibilityIdentifier!)&caretakerInfo=\(task.caretaker)&caretakerNotes=\(task.caretakerNotes)"
                    request.HTTPBody = paramString.dataUsingEncoding(NSUTF8StringEncoding)
                    let task = session.dataTaskWithRequest(request){
                        (let data, let response, let error) -> Void in
                        
                        if error != nil {
                            print ("whoops, something went wrong! Details: \(error!.localizedDescription); \(error!.userInfo)")
                        }
                        
                        if data != nil {
                            do{
                                let raw = try NSJSONSerialization.JSONObjectWithData(data!, options: .MutableContainers)
                                
                                if let json = raw as? [[String: AnyObject]] {
                                    for entry in json {
                                        print("entry: \(entry)")
                                        //                                print("json: \(entry[""])")
                                    }
                                }
                            }
                                
                            catch{
                                print("other object")
                            }
                        }
                    }
                    task.resume()
                    
                }   //end if let url
            }
        }
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

    // This lets users return to this screen after doing an activity
    @IBAction func unwindToPrevious(sender: UIStoryboardSegue){
    }
    
}