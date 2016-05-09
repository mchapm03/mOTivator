//
//  patientOverallStats.swift
//  mOTivator
//
//  Created by Margaret Chapman on 3/31/16.
//  Copyright © 2016 Tufts. All rights reserved.
//
//  This shows an overview of patient records to the OT. It has a graph with the trend of % of tasks completed, 
//  and a list of the tasks. Tasks are colored according to how well a patient is doing them.
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
        
        if patient?.name == "Ron"{
            loadTasks()
        }else{
            loadSampleTasks()
        }
        taskTable.delegate = self
        taskTable.dataSource = self
    }
    

    // load tasks from the server for this patient
    func loadTasks() {
        // THIS REQUEST GETS STUFF
        if let url = NSURL(string: "http://192.168.108.13:3000/getTasks"){
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
                                //                                if entry["icon"] != nil {
                                //                                    if UIImage(named: entry["icon"]! as! String) != nil{
                                //                                        taskIcon = UIImage(named: entry["icon"]! as! String)!
                                //                                    }else {
                                //                                        taskIcon = UIImage(named: "motivator_iconcopy")!
                                //
                                //                                    }
                                //                                }else {
                                //                                    taskIcon = UIImage(named: "motivator_iconcopy")!
                                //                                }
                                
                                if UIImage(named: entry["task"]!.lowercaseString as String) != nil{
                                    taskIcon = UIImage(named: entry["task"]!.lowercaseString as String)!
                                }else {
                                    taskIcon = UIImage(named: "motivator_iconcopy")!
                                    
                                }
                                
                                
                                // Get Caretaker stuff
                                //                                var caretaker : (String, String) = ("", "")
                                //                                var caretakerNotes: String = ""
                                //                                if entry["caretaker"] != nil {
                                //                                    let raw = try NSJSONSerialization.JSONObjectWithData(entry["caretaker"]!, options: .MutableContainers)
                                //
                                //                                    if let caretakerjson = raw as? [[String: String]] {                                    caretaker = (caretakerjson["contactInfo"])
                                //                                        caretakerNotes = caretakerjson["notes"]
                                //                                    }
                                //                                    catch{
                                //                                        print("cannot parse caretaker stuff as json")
                                //                                    }
                                //                                }
                                var taskName = ""
                                if let entryName = entry["type"] as? String {
                                    taskName = entryName
                                }
                                
                                var ctime = ""
                                var cnum = 0.0
                                if let etime = entry["completionTime"] as? String {
                                    ctime = etime
                                    if Double(ctime) != nil {
                                        cnum = Double(ctime)!
                                    }
                                }
                                
                                var stime = ""
                                var snum = 0.0
                                if let estime = entry["startDate"] as? String {
                                    stime = estime
                                    if Double(stime) != nil {
                                        snum = Double(stime)!
                                    }
                                }
                                
                                var etime = ""
                                var endnum = 0.0
                                if let eetime = entry["endDate"] as? String {
                                    etime = eetime
                                    if Double(etime) != nil {
                                        endnum = Double(etime)!
                                    }
                                }
                                let newTask = Task(name: taskName, icon: taskIcon, color: taskColor, primaryTime: NSDate(timeIntervalSince1970:cnum), secondaryTime: nil, startDate: NSDate(timeIntervalSince1970: snum), endDate: NSDate(timeIntervalSince1970: endnum))
                                if newTask != nil{
                                    
                                    self.tasks += [newTask!]
                                    print(self.tasks.count)
                                    self.taskTable.reloadData()
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
    

    
    func loadSampleTasks() {
        tasks = [Task(name: "Brush Teeth", icon: UIImage(named: "brush teeth")!, color: UIColor(red: CGFloat(0.96), green: CGFloat( 0.56), blue: CGFloat(0.56), alpha: CGFloat(1.0)), primaryTime: NSDate(timeIntervalSinceNow: 600), secondaryTime: nil, startDate:NSDate(timeIntervalSinceNow: -3600), endDate: NSDate(timeIntervalSinceNow: 3600))!, Task(name: "Eat Lunch", icon: UIImage(named: "eat lunch")!, color: UIColor(red: CGFloat(0.58), green: CGFloat(0.77), blue: CGFloat(0.49), alpha: CGFloat(1.0)), primaryTime: NSDate(timeIntervalSinceNow: 10), secondaryTime: nil, startDate:NSDate(timeIntervalSinceNow: -3600), endDate: NSDate(timeIntervalSinceNow: 3600))!, Task(name: "Catch the Bus", icon: UIImage(named: "catch the bus")!, color: UIColor(red: CGFloat(0.58), green: CGFloat( 0.77), blue: CGFloat(0.49), alpha: CGFloat(1.0)), primaryTime: NSDate(timeIntervalSinceNow: 60), secondaryTime: nil, startDate:NSDate(timeIntervalSinceNow: -3600), endDate: NSDate(timeIntervalSinceNow: 3600))!, Task(name: "Homework", icon: UIImage(named: "homework")!, color: UIColor(red: CGFloat(1.0), green: CGFloat( 0.90), blue: CGFloat(0.60), alpha: CGFloat(1.0)), primaryTime: NSDate(timeIntervalSinceNow: 60), secondaryTime: nil, startDate:NSDate(timeIntervalSinceNow: -3600), endDate: NSDate(timeIntervalSinceNow: 3600))!]

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
        if segue.identifier == "taskDetailSegue" {
            let taskDetailVC = segue.destinationViewController as! taskDetailViewController
            if let selectedTask = sender as? UITableViewCell {
                taskDetailVC.task = tasks[taskTable.indexPathForCell(selectedTask)!.row]
            }
        }
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