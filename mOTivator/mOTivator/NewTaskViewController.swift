//
//  NewTaskViewController.swift
//  mOTivator
//
//  Created by Chapman, Margaret E. on 4/3/16.
//  Copyright © 2016 Tufts. All rights reserved.
//

import UIKit

class NewTaskViewController: UIViewController, UITextFieldDelegate, UIImagePickerControllerDelegate, UINavigationControllerDelegate, UITableViewDelegate, UITableViewDataSource  {

    @IBOutlet weak var cancelButton: UIBarButtonItem!
    @IBOutlet weak var taskImage: UIImageView!
    @IBOutlet weak var saveButton: UIBarButtonItem!

    @IBOutlet weak var newTaskTable: UITableView!
    //to make some cells expandable:
    var selectedIndexPath: NSIndexPath? = nil
    
    /*
    This value is either passed by `TaskListTableViewController` in `prepareForSegue(_:sender:)`
    or constructed as part of adding a new task.
    */
    var task : Task?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        newTaskTable.dataSource = self
        newTaskTable.delegate = self
        self.view.addSubview(self.newTaskTable)

        // Set up views if editing an existing Task.
        if let task = task {
            navigationItem.title = task.name
            taskImage.image = task.icon
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // Table View functions:
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 3
    }
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0 {
            return 1
        }else if section == 1 {
            return 3
        }else {
            return 1
        }
    }

    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        if indexPath.section == 0{
            let cell = newTaskTable.dequeueReusableCellWithIdentifier("nameCell", forIndexPath: indexPath) as! nameCell
            if let task = task {
                cell.nameInput.text = task.name
            }
            return cell
        }else if indexPath.section == 1 {
            let cell = newTaskTable.dequeueReusableCellWithIdentifier("dateCell", forIndexPath: indexPath) as! datepickerCellView
            let dateformatter = NSDateFormatter()
            if indexPath.row == 0 {
                cell.typeLabel.text = "Completion Time"
                dateformatter.dateFormat = "h:mm zzz"
                if let taskPTime = task?.primaryTime {
                    cell.dateLabel.text = dateformatter.stringFromDate(taskPTime)
                    cell.date.date = taskPTime
                }else {
                    cell.dateLabel.text = dateformatter.stringFromDate(NSDate())
                    cell.date.date = NSDate()
                }
            }else if indexPath.row == 1 {
                cell.typeLabel.text = "Start Date"
                cell.date.datePickerMode = UIDatePickerMode.Date
                dateformatter.dateStyle = NSDateFormatterStyle.MediumStyle
                if let tasksDate = task?.startDate {
                    cell.dateLabel.text = dateformatter.stringFromDate(tasksDate)
                    cell.date.date = tasksDate
                }else {
                    cell.dateLabel.text = dateformatter.stringFromDate(NSDate())
                    cell.date.date = NSDate()
                }
            }else if indexPath.row == 2 {
                cell.typeLabel.text = "End Date"
                cell.date.datePickerMode = UIDatePickerMode.Date
                dateformatter.dateStyle = NSDateFormatterStyle.MediumStyle
                if let taskeDate = task?.endDate {
                    cell.dateLabel.text = dateformatter.stringFromDate(taskeDate)
                    cell.date.date = taskeDate
                }else {
                    let endDate = NSDate(timeIntervalSinceNow: 604800)
                    cell.dateLabel.text = dateformatter.stringFromDate(endDate)
                    cell.date.date = endDate
                }
            }
            return cell
        }else {
            let cell = newTaskTable.dequeueReusableCellWithIdentifier("careTakerCell", forIndexPath: indexPath) as! careTakerCell
            if let task = task {
                if task.caretakerNotes != nil {
                    cell.careTakerNotes.text = task.caretakerNotes
                }else {
                    cell.careTakerNotes.textColor = UIColor.lightGrayColor()
                    cell.careTakerNotes.text = "Caretaker Notes."
                }
                if let (cname, cemail) = task.caretaker {
                    cell.caretakerName.text = cname
                    cell.careTakerEmail.text = cemail
                }
            }else {
                cell.careTakerNotes.textColor = UIColor.lightGrayColor()
                cell.careTakerNotes.text = "Caretaker Notes."
            }
            return cell
        }
    }
    
    //to make some expandable:

    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        if indexPath.section == 1 {
            switch selectedIndexPath {
            case nil:
                selectedIndexPath = indexPath
            default:
                if selectedIndexPath! == indexPath {
                    selectedIndexPath = nil
                } else {
                    selectedIndexPath = indexPath
                }
            }
//            tableView.reloadRowsAtIndexPaths([indexPath], withRowAnimation: UITableViewRowAnimation.Automatic)
            tableView.reloadData()
        }
    }
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        if indexPath.section == 0 {
            return 44.0
        }else if indexPath.section == 1{
            if selectedIndexPath != nil {
                if indexPath == selectedIndexPath! {
                    return 240.0
                } else {
                    return 44.0
                }
            } else {
                return 44.0
            }
        }else {
            return 240.0
        }
    }

    // MARK: Navigation

    @IBAction func cancel(sender: UIBarButtonItem) {
        // Depending on style of presentation (modal or push presentation), this view controller needs to be dismissed in two different ways.
        let isPresentingInAddTaskMode = presentingViewController is TaskListTableViewController

        if isPresentingInAddTaskMode {
            dismissViewControllerAnimated(true, completion: nil)
        } else {
            navigationController!.popViewControllerAnimated(true)
        }
    }

    // This method lets you configure a view controller before it's presented.
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if saveButton === sender {
            let namecell = newTaskTable.cellForRowAtIndexPath(NSIndexPath(forRow: 0, inSection: 0)) as! nameCell
            let name = namecell.nameInput.text
            
            let pTimeCell = newTaskTable.cellForRowAtIndexPath(NSIndexPath(forRow: 0, inSection: 1)) as! datepickerCellView
            let pTime = pTimeCell.date.date
            
            let sDateCell = newTaskTable.cellForRowAtIndexPath(NSIndexPath(forRow: 1, inSection: 1)) as! datepickerCellView
            let sDate = sDateCell.date.date
            
            let eDateCell = newTaskTable.cellForRowAtIndexPath(NSIndexPath(forRow: 2, inSection: 1)) as! datepickerCellView
            let eDate = eDateCell.date.date
            
            let photo = taskImage.image
      
            //if user hasn't granted permissions:
//            if let settings = UIApplication.sharedApplication().currentUserNotificationSettings() {
//                
//                if settings.types == .None {
//                    let ac = UIAlertController(title: "Notifications", message: "We don't have permission to schedule notifications, so you won't recieve any.", preferredStyle: .Alert)
//                    ac.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.Default, handler: nil))
//                    self.presentViewController(ac, animated: true, completion: nil)
//                }
//            }
            
            // Set the task to be passed to TaskListViewController after the unwind segue.
            task = Task(name: name!, icon: photo!, primaryTime: pTime, secondaryTime: NSDate(), startDate: sDate, endDate: eDate)
        }
    }

    // MARK: UIImagePickerControllerDelegate
    func imagePickerControllerDidCancel(picker: UIImagePickerController) {
        // Dismiss the picker if the user canceled.
        dismissViewControllerAnimated(true, completion: nil)
    }
    
    func imagePickerController(picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : AnyObject]) {
        // The info dictionary contains multiple representations of the image, and this uses the original.
        let selectedImage = info[UIImagePickerControllerOriginalImage] as! UIImage
        
        // Set photoImageView to display the selected image.
        taskImage.image = selectedImage
        
        // Dismiss the picker.
        dismissViewControllerAnimated(true, completion: nil)
    }
    // Allow user to add pictures from photo library

    @IBAction func selectPhoto(sender: UITapGestureRecognizer) {
                // Hide the keyboard.
        
                // UIImagePickerController is a view controller that lets a user pick media from their photo library.
                let imagePickerController = UIImagePickerController()
        
                // Only allow photos to be picked, not taken.
                imagePickerController.sourceType = .PhotoLibrary
        
                // Make sure ViewController is notified when the user picks an image.
                imagePickerController.delegate = self
        
                presentViewController(imagePickerController, animated: true, completion: nil)
    }
    
    // This lets users return to this screen after doing an activity if they were here before
    @IBAction func unwindToPrevious(sender: UIStoryboardSegue){
    }
    
    
}
