//
//  startActivityViewController.swift
//  mOTivator
//
//  Created by Chapman, Margaret E. on 4/17/16.
//  Copyright © 2016 Tufts. All rights reserved.
//
//  This view is shown when an activity is started. The arduino sensor data is read in and sent to the Kalman Filter. 
//  The data is checked for either teeth brushing or hair brushing, depending on what activity is sent. 
//  If the correct activity is detected, the goodJobViewController is shown. Otherwise an alert tells the user that the correct motion was not detected.
//

import UIKit

class startActivityViewController: UIViewController {
    @IBOutlet weak var startActivityButton: UIButton!
    
    var task: String?
    
    var taskFound = false

    // initialize a kalman filter class
    let KFilter = kalmanFilterViewController()
    
    var taskTimer: NSTimer?

    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        // Show the showering minion
        startActivityButton.setBackgroundImage(UIImage(named: "showering-minion")!, forState: UIControlState.Normal)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if (task != nil){
            navigationItem.title = task
        }
        NSTimer.scheduledTimerWithTimeInterval(10, target: self, selector: #selector(startActivityViewController.notDetected), userInfo: nil, repeats: false)
        
        taskTimer = NSTimer.scheduledTimerWithTimeInterval(1, target: self, selector: #selector(startActivityViewController.checkData), userInfo: nil, repeats: true)
        
        // Animate the background so that the user knows something is happening
        UIView.animateWithDuration(2, delay: 0.0, options:[UIViewAnimationOptions.Repeat, UIViewAnimationOptions.Autoreverse], animations: {
            self.view.backgroundColor = UIColor.orangeColor()
            self.view.backgroundColor = UIColor.whiteColor()
            }, completion: nil)
    }
    

    
    func checkData()
    {
        //make post request to get raw data from server
        //is this data already arranged into column form?
        loadRawData()
        
        //once task found, stop timer
        if(taskFound)
        {
            taskTimer!.invalidate()
        }
    }
    
    func loadRawData(){
        var loadedAccelData : ABMatrix = ABMatrix(row: 0, col: 0)
        var loadedGyroData : ABMatrix = ABMatrix(row: 0, col: 0)
        if let url = NSURL(string: "http://192.168.43.243:3000/getData"){
            let session = NSURLSession.sharedSession()
            let request = NSMutableURLRequest(URL: url)
            request.HTTPMethod = "POST"
            let rawData = session.dataTaskWithRequest(request){
                (let data, let response, let error) -> Void in
                
                if error != nil {
                    print ("whoops, something went wrong! Details: \(error!.localizedDescription); \(error!.userInfo)")
                }
                
                if data != nil {
                    do{
                        let raw = try NSJSONSerialization.JSONObjectWithData(data!, options: .MutableContainers)
                        let accelData = String((raw["accel"])!)
                        let gyroData = String(raw["gyro"])
                        
                        //check what task is being searched for
                        if(self.task?.lowercaseString == "brush teeth"){
                            loadedAccelData = self.parsetoArray(accelData)
                            // Teeth brushing algorithm called here with accel data
                            self.taskFound = self.KFilter.toothBrushingDetected(loadedAccelData)
                        }
                    
                        if(self.task?.lowercaseString == "brush hair"){
                            loadedGyroData = self.parsetoArray(gyroData)
                            // Hair brushing algoithm called here with gyro data
                            self.taskFound = self.KFilter.hairBrushingDetected(loadedGyroData)
                        }
                        
    
                    }
                        
                    catch{
                        print("other object")
                    }
                    

                }
            }
            rawData.resume()
            
        }
    }
    
    func movementDetected() {
        // Movement was detected, take user to Good Job View!
            if let url = NSURL(string: "http://192.168.43.243:3000/updateRecord"){
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
            if let url = NSURL(string: "http://192.168.43.243:3000/updateRecord"){
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

    func parsetoArray(dataString: String) -> ABMatrix {
        print(dataString)
        var currentNum = ""
        var allValues = [Double]()
        var i = dataString.startIndex
        while (i != dataString.endIndex){
            if dataString[i] == " " || dataString[i] == "\n"{
                if let num = Double(currentNum){
                    allValues += [num]
                }
                
                currentNum = ""
                i = i.successor()
            }else if (dataString[i] >= "0" && dataString[i] <= "9") || dataString[i] == "."{
                currentNum.append(dataString[i])
                i = i.successor()
            }else {
                i = i.successor()
            }
        }
        print("matrix: \(allValues), row: \(allValues.count/3)")
        return ABMatrix(matrix: allValues, row: (allValues.count/3), col: 3)
    }
    
    override func canPerformUnwindSegueAction(action: Selector, fromViewController: UIViewController, withSender sender: AnyObject) -> Bool {
        return false
    }
}
