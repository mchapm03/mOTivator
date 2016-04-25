//
//  Task.swift
//  mOTivator
//
//  Created by Margaret Chapman on 3/31/16.
//  Copyright © 2016 Tufts. All rights reserved.
//

import UIKit
import Foundation

class Task {
    // Mark: Properties
    var name: String
    // TODO: figure out type of icon
    var icon: UIImage
    // TODO: figure time format
    var primaryTime:NSDate?
    var secondaryTime:NSDate?
    var timeAssigned = [NSDate]()
    var startDate: NSDate
    var endDate: NSDate
    var caretaker : (String, Int)?
    var record = [(NSDate, Bool)]()
    var color: UIColor?
    
    init?(name: String, icon: UIImage, primaryTime: NSDate, secondaryTime: NSDate?, startDate: NSDate, endDate: NSDate) {
        self.name = name
        self.icon = icon
        self.startDate = startDate
        self.endDate = endDate
        self.primaryTime = primaryTime
        
        if secondaryTime != nil{
            self.secondaryTime = secondaryTime
        }
        setNotifications()
    }
    
    init?(name: String, icon: UIImage, color: UIColor, primaryTime: NSDate, secondaryTime: NSDate?, startDate: NSDate, endDate: NSDate){
        self.name = name
        self.icon = icon
        self.color = color
        self.startDate = startDate
        self.endDate = endDate
        self.primaryTime = primaryTime

        if secondaryTime != nil {
            self.secondaryTime = secondaryTime
        }
        setNotifications()
    }

    func setNotifications(){
        //if user hasn't granted permissions:
        guard let settings = UIApplication.sharedApplication().currentUserNotificationSettings() else { return }
        
        if settings.types == .None {
//            let ac = UIAlertController(title: "Can't schedule", message: "Either we don't have permission to schedule notifications, or we haven't asked yet.", preferredStyle: .Alert)
//            ac.addAction(UIAlertAction(title: "OK", style: .Default, handler: nil))
            //self.presentViewController(ac, animated: true)
            return
        }
        let notification = UILocalNotification()
        notification.fireDate = NSDate(timeIntervalSinceNow: 5)
        notification.alertBody = "Do your task! " + name
        UIApplication.sharedApplication().scheduleLocalNotification(notification)
    }
    
    func setColor(color: UIColor){
        self.color = color
    }
    func setPTime(time: NSDate){
        self.primaryTime = time;
    }
}
