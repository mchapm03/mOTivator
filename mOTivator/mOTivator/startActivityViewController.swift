//
//  startActivityViewController.swift
//  mOTivator
//
//  Created by Chapman, Margaret E. on 4/17/16.
//  Copyright © 2016 Tufts. All rights reserved.
//

import UIKit

class startActivityViewController: UIViewController {
    @IBOutlet weak var startActivityButton: UIButton!
    
    var task: String?

    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        startActivityButton.setBackgroundImage(UIImage(named: "showering-minion")!, forState: UIControlState.Normal)
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        if (task != nil){
            navigationItem.title = task
        }
        NSTimer.scheduledTimerWithTimeInterval(2, target: self, selector: #selector(startActivityViewController.movementDetected), userInfo: nil, repeats: false)
        
    }
    
    func movementDetected() {
        // Movement was detected, take user to Good Job View!
            if let url = NSURL(string: "https://192.168.43.34:3000/updateRecord"){
                let session = NSURLSession.sharedSession()
                let request = NSMutableURLRequest(URL: url)
                request.HTTPMethod = "POST"
                let timeNow = NSDate().description
                let paramString = "type=\(self.task)&record=[\(timeNow),1]"
                request.HTTPBody = paramString.dataUsingEncoding(NSUTF8StringEncoding)
                let thistask = session.dataTaskWithRequest(request){
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
                thistask.resume()
                
            }   //end if let url...

            startActivityButton.sendActionsForControlEvents(.TouchUpInside)
    }
    
    // Activity was not detected, alert user, let them try again, or take them to their "home view"
    
    func notDetected() {
        let alert = UIAlertController(title: "Alert", message: "No task detected", preferredStyle: UIAlertControllerStyle.Alert)

        alert.addAction(UIAlertAction(title: "Ok", style: UIAlertActionStyle.Default, handler: {
                            (action: UIAlertAction!) in
            self.performSegueWithIdentifier("unwindSeg", sender: self)
            //send update to the server that task was not completed
            if let url = NSURL(string: "https://192.168.43.34:3000/updateRecord"){
                let session = NSURLSession.sharedSession()
                let request = NSMutableURLRequest(URL: url)
                request.HTTPMethod = "POST"
                let timeNow = NSDate().description
                let paramString = "type=\(self.task)&record=[\(timeNow),0]"
                request.HTTPBody = paramString.dataUsingEncoding(NSUTF8StringEncoding)
                let thistask = session.dataTaskWithRequest(request){
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
                thistask.resume()
                
            }   //end if let url...
        }))

        alert.addAction(UIAlertAction(title: "Try Again", style: UIAlertActionStyle.Default, handler: nil))
        self.presentViewController(alert, animated: true, completion: nil)
    }

    
    override func canPerformUnwindSegueAction(action: Selector, fromViewController: UIViewController, withSender sender: AnyObject) -> Bool {
        return false
    }
}
