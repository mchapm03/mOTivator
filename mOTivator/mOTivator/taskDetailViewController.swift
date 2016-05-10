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

class taskDetailViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {

    @IBOutlet weak var dateList: UITableView!
    @IBOutlet weak var taskProgressGraph: OverallGraphView!
    var task:Task?
    override func viewDidLoad() {
        super.viewDidLoad()
        //set tableview delegate
        dateList.delegate = self
        dateList.dataSource = self
        if let t1 = task {
            navigationItem.title = t1.name
        }
        loadSampleTask()
    }
    
    func loadSampleTask() {
        task = Task(name: "Brush Teeth", icon: UIImage(named: "brush teeth")!, color: UIColor(red: CGFloat(0.96), green: CGFloat( 0.56), blue: CGFloat(0.56), alpha: CGFloat(1.0)), primaryTime: NSDate(timeIntervalSinceNow: 1), secondaryTime: nil, startDate:NSDate(timeIntervalSinceNow: -3600), endDate: NSDate(timeIntervalSinceNow: 3600))
        if task != nil{
            task!.record = [(NSDate(timeIntervalSinceNow: -3600), true), (NSDate(timeIntervalSinceNow: -64000), false), (NSDate(timeIntervalSinceNow: -200000), false), (NSDate(timeIntervalSinceNow: -300000), true), (NSDate(timeIntervalSinceNow: -400000), false)]
        }
        
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if task != nil{
            return task!.record.count
        }else {
            return 1
        }
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("taskCompletedCell", forIndexPath: indexPath) as! taskCompletedCell
        let (day, compl) = (task?.record[indexPath.row])!
        let dateformat = NSDateFormatter()
        dateformat.dateStyle = NSDateFormatterStyle.MediumStyle
        cell.dateLabel.text = dateformat.stringFromDate(day)
        if compl == true {
            cell.completedLabel.textColor = UIColor(red: CGFloat(0.58), green: CGFloat(0.77), blue: CGFloat(0.49), alpha: CGFloat(1.0))
            cell.completedLabel.text = "Completed"
        }else{
            cell.completedLabel.textColor = UIColor(red: 0.96, green: 0.56, blue: 0.56, alpha: 1.0)
            cell.completedLabel.text = "Not completed"
        }
        return cell
    }
}
