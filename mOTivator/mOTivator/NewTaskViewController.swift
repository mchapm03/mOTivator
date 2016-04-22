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

//        taskName.delegate = self
        // Set up views if editing an existing Task.
//        if let task = task {
//            navigationItem.title = task.name
//            taskName.text   = task.name
//            taskImage.image = task.icon
//            if let p1 = task.primaryTime{
//                primaryTime.setDate(p1, animated: false)
//            }
//            if(task.secondaryTime != nil){
//                secondaryTime.setDate(task.secondaryTime!, animated: false)
//            }
//            startDate.setDate(task.startDate, animated: false)
//            endDate.setDate(task.endDate, animated: false)
//        }
    }
    
//    func textFieldShouldReturn(textField: UITextField) -> Bool {
//        // Hide the keyboard.
//        textField.resignFirstResponder()
//        return true
//    }
    
//    func textFieldDidEndEditing(textField: UITextField) {
//        taskName.text = textField.text
//       
//    }

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
    func tableView(tableView: UITableView!, titleForHeaderInSection section: Int) -> String!{
        return "section header here"
    }
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        if indexPath.section == 0 && indexPath.row == 0 {
            let cell = newTaskTable.dequeueReusableCellWithIdentifier("nameCell", forIndexPath: indexPath) as! nameCell
            if let task = task {
                cell.nameInput.text = task.name
            }
            return cell
        }else if indexPath.section == 1 {
            let cell = newTaskTable.dequeueReusableCellWithIdentifier("dateCell", forIndexPath: indexPath) as! datepickerCellView
            let dateformatter = NSDateFormatter()
            if indexPath.row == 1 {
                cell.typeLabel.text = "Completion Time"
                dateformatter.dateFormat = "HH:mm zzz"
                if let task = task {
                    cell.dateLabel.text = dateformatter.stringFromDate(task.primaryTime!)
                }else {
                    cell.dateLabel.text = dateformatter.stringFromDate(NSDate())
                }
            }else if indexPath.row == 2{
                cell.typeLabel.text = "Start Date"
                cell.date.datePickerMode = UIDatePickerMode.Date
                dateformatter.dateStyle = NSDateFormatterStyle.MediumStyle
                if let task = task {
                    cell.dateLabel.text = dateformatter.stringFromDate(task.startDate)
                }else {
                    cell.dateLabel.text = dateformatter.stringFromDate(NSDate())
                }
            }else if indexPath.row == 3{
                cell.typeLabel.text = "End Date"
                cell.date.datePickerMode = UIDatePickerMode.Date
                dateformatter.dateStyle = NSDateFormatterStyle.MediumStyle
                if let task = task {
                    cell.dateLabel.text = dateformatter.stringFromDate(task.endDate)
                }else {
                    cell.dateLabel.text = dateformatter.stringFromDate(NSDate())
                }
                return cell
            }
        }else {
            let cell = newTaskTable.dequeueReusableCellWithIdentifier("careTakerCell", forIndexPath: indexPath) as! careTakerCell
            if let task = task {
                if task.caretakerNotes != nil {
                    cell.careTakerNotes.text = task.caretakerNotes
                }else {
                    cell.careTakerNotes.textColor = UIColor.lightGrayColor()
                    cell.careTakerNotes.text = "Caretaker Notes."
                }
                let (cname, cemail) = task.caretaker!
                cell.caretakerName.text = cname
                cell.careTakerEmail.text = cemail
            }else {
                cell.careTakerNotes.textColor = UIColor.lightGrayColor()
                cell.careTakerNotes.text = "Caretaker Notes."
            }
            return cell
        }
        return newTaskTable.dequeueReusableCellWithIdentifier("nameCell", forIndexPath: indexPath)
    }
    //to make some expandable:
//
//    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
//        if indexPath.section == 2 {
//            var _ = tableView.cellForRowAtIndexPath(indexPath) as! datepickerCellView
//            switch selectedIndexPath {
//            case nil:
//                selectedIndexPath = indexPath
//            default:
//                if selectedIndexPath! == indexPath {
//                    selectedIndexPath = nil
//                } else {
//                    selectedIndexPath = indexPath
//                }
//            }
//            tableView.reloadRowsAtIndexPaths([indexPath], withRowAnimation: UITableViewRowAnimation.Automatic)
//        }
//    }
//    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
//
//        if selectedIndexPath != nil {
//            if indexPath == selectedIndexPath! {
//                return 240.0
//            } else {
//                return 44.0
//            }
//        } else {
//            return 44.0
//        }
//    }

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
//            let name = taskName.text ?? ""
//            let photo = taskImage.image
      
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
//            task = Task(name: name, icon: photo!, primaryTime: primaryTime.date, secondaryTime: nil, startDate: startDate.date, endDate: endDate.date)
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
    
    
}
