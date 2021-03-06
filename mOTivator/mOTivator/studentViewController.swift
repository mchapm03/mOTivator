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
        
        // for tableview subview:
        taskTable.delegate = self
        taskTable.dataSource = self
        
        
        // Get tasks from server:
        loadTasks()
        
        // Get static hardcoded tasks:
        //loadSampleTasks()
    }
    
    // load tasks from the server for this patient
    func loadTasks() {
        // THIS REQUEST GETS STUFF
        if let url = NSURL(string: "http://192.168.43.243:3000/getTasks"){
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
                                
                                // Get color
                                var taskColor = UIColor.blackColor()
                                if let thisColor = entry["colorAll"] as? String {
                                    if thisColor == "green" {
                                        taskColor = UIColor.greenColor()
                                    }else if thisColor == "red"{
                                        taskColor = UIColor.redColor()
                                    }else if thisColor == "yellow" {
                                        taskColor = UIColor.yellowColor()
                                    }
                                }
                                
                                // Get icon
                                var taskIcon: UIImage
                                
                                if UIImage(named: entry["type"]!.lowercaseString as String) != nil{
                                    taskIcon = UIImage(named: entry["type"]!.lowercaseString as String)!
                                }else {
                                    taskIcon = UIImage(named: "motivator_iconcopy")!

                                }

                                // get name of task
                                var taskName = ""
                                if let entryName = entry["type"] as? String {
                                    taskName = entryName
                                }
                                
                                // get task completion time
                                var ctime = ""
                                var cnum = 0.0
                                if let etime = entry["completionTime"] as? String {
                                    ctime = etime
                                    if Double(ctime) != nil {
                                        cnum = Double(ctime)!
                                    }
                                }
                                
                                // get task start date
                                var stime = ""
                                var snum = 0.0
                                if let estime = entry["startDate"] as? String {
                                    stime = estime
                                    if Double(stime) != nil {
                                        snum = Double(stime)!
                                    }
                                }
                                
                                // get task end date
                                var etime = ""
                                var endnum = 0.0
                                if let eetime = entry["endDate"] as? String {
                                    etime = eetime
                                    if Double(etime) != nil {
                                        endnum = Double(etime)!
                                    }
                                }
                                
                                // create the new task with the info gotten from the server
                                let newTask = Task(name: taskName, icon: taskIcon, color: taskColor, primaryTime: NSDate(timeIntervalSince1970:cnum), secondaryTime: nil, startDate: NSDate(timeIntervalSince1970: snum), endDate: NSDate(timeIntervalSince1970: endnum))
                                // if the task creation was successful, add it to the overall tasks
                                // and display it in the table
                                if newTask != nil{
                                    var inList = false
                                    if self.tasks.count>0{
                                        for index in 1...self.tasks.count{
                                            if self.tasks[index-1].name == newTask!.name{
                                                inList = true
                                            }
                                        }
                                    }
                                    if inList == false{
                                        self.tasks += [newTask!]
                                        print(self.tasks.count)
                                        self.taskTable.reloadData()
                                    }
                                }
                            }
                        }

                    }
                        
                    catch{
                        print("other object")
                    }
                }
            }
            task.resume()
            
        
        }else {
            print("cannot get url")
        }

    }
    
    // load sample tasks
    func loadSampleTasks() {
        tasks = [Task(name: "Brush Teeth", icon: UIImage(named: "brush teeth")!, color: UIColor(red: CGFloat(0.96), green: CGFloat( 0.56), blue: CGFloat(0.56), alpha: CGFloat(1.0)), primaryTime: NSDate(timeIntervalSinceNow: 1), secondaryTime: nil, startDate:NSDate(timeIntervalSinceNow: -3600), endDate: NSDate(timeIntervalSinceNow: 3600))!]
        tasks[0].setNotifications()
        
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
    
    // Populate the table with tasks at each row
    // each cell has a name label and an icon image view
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("myTask", forIndexPath: indexPath)
        cell.textLabel?.text = tasks[indexPath.row].name
        cell.imageView?.image = tasks[indexPath.row].icon
        return cell
    }
    
    
    // Allow users to edit and delete rows
    func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if editingStyle == .Delete {
            // Delete the row from the data source
            // TODO: delete the task from the database
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
                if let url = NSURL(string: "http://192.168.43.243:3000/addTask"){
                    print("in url")
                    let session = NSURLSession.sharedSession()
                    let request = NSMutableURLRequest(URL: url)
                    request.HTTPMethod = "POST"
                    // PUT IN THE PARAMS
                    var paramString = "type=\(task.name)&startDate=\(task.startDate.timeIntervalSince1970)&endDate=\(task.endDate.timeIntervalSince1970)&completionTime=\(task.primaryTime?.timeIntervalSince1970)"
                    if task.icon.accessibilityIdentifier != nil {
                        paramString += "&icon=\(task.icon.accessibilityIdentifier)"
                    }else{
                        paramString += "&icon="
                    }
                    if task.caretaker != nil {
                        paramString += "&caretakerInfo=\(task.caretaker)"
                    }else {
                        paramString += "&caretakerInfo="

                    }
                    if task.caretakerNotes != nil {
                        paramString += "&caretakerNotes=\(task.caretakerNotes)"
                    }else{
                        paramString += "&caretakerNotes="
                    }
                    request.HTTPBody = paramString.dataUsingEncoding(NSUTF8StringEncoding)
                    let task = session.dataTaskWithRequest(request){
                        (let data, let response, let error) -> Void in
                        
                        if error != nil {
                            print ("whoops, something went wrong! Details: \(error!.localizedDescription); \(error!.userInfo)")
                        }
//                        print(response)
//                        if response["status"] != 200 {
//                            print("server not working")
//                        }
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