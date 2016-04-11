//
//  NewTaskViewController.swift
//  mOTivator
//
//  Created by Chapman, Margaret E. on 4/3/16.
//  Copyright © 2016 Tufts. All rights reserved.
//

import UIKit

class NewTaskViewController: UIViewController, UITextFieldDelegate, UIImagePickerControllerDelegate, UINavigationControllerDelegate  {

    @IBOutlet weak var taskName: UITextField!
    @IBOutlet weak var cancelButton: UIBarButtonItem!
    @IBOutlet weak var taskImage: UIImageView!
    @IBOutlet weak var saveButton: UIBarButtonItem!
    @IBOutlet weak var primaryTime: UIDatePicker!
    @IBOutlet weak var secondaryTime: UIDatePicker!
    @IBOutlet weak var startDate: UIDatePicker!
    @IBOutlet weak var endDate: UIDatePicker!
    @IBOutlet weak var caretaker: UITextField!
    
    /*
    This value is either passed by `TaskListTableViewController` in `prepareForSegue(_:sender:)`
    or constructed as part of adding a new task.
    */
    var task : Task?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        taskName.delegate = self
        // Set up views if editing an existing Task.
        if let task = task {
            navigationItem.title = task.name
            taskName.text   = task.name
            taskImage.image = task.icon
            if let p1 = task.primaryTime{
                primaryTime.setDate(p1, animated: false)
            }
            if(task.secondaryTime != nil){
                secondaryTime.setDate(task.secondaryTime!, animated: false)
            }
            startDate.setDate(task.startDate, animated: false)
            endDate.setDate(task.endDate, animated: false)
        }
    }
    
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        // Hide the keyboard.
        textField.resignFirstResponder()
        return true
    }
    
    func textFieldDidEndEditing(textField: UITextField) {
        taskName.text = textField.text
       
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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
            let name = taskName.text ?? ""
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
            task = Task(name: name, icon: photo!, primaryTime: primaryTime.date, secondaryTime: nil, startDate: startDate.date, endDate: endDate.date)
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
                taskName.resignFirstResponder()
        
                // UIImagePickerController is a view controller that lets a user pick media from their photo library.
                let imagePickerController = UIImagePickerController()
        
                // Only allow photos to be picked, not taken.
                imagePickerController.sourceType = .PhotoLibrary
        
                // Make sure ViewController is notified when the user picks an image.
                imagePickerController.delegate = self
        
                presentViewController(imagePickerController, animated: true, completion: nil)
    }
    
    
}
