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
    @IBOutlet weak var taskImage: UIImageView!
    @IBOutlet var saveButton: UIBarButtonItem!
    @IBOutlet weak var cancelButton: UIBarButtonItem!
    
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
        let isPresentingInAddMealMode = presentingViewController is UINavigationController

        if isPresentingInAddMealMode {
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

            // Set the task to be passed to TaskListViewController after the unwind segue.
            task = Task(name: name, icon: photo!)
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
    @IBOutlet var selectImageFromLibrary: UITapGestureRecognizer!
    
    @IBAction func selectImageFromLib(sender: UITapGestureRecognizer) {
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