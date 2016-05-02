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
    var caretaker : (String, String)?
    var caretakerNotes : String?
    var record = [(NSDate, Bool)]()
    var color: UIColor?
    var notification = UILocalNotification()
    
    init?(name: String, icon: UIImage, primaryTime: NSDate, secondaryTime: NSDate?, startDate: NSDate, endDate: NSDate){
        self.name = name
        self.icon = icon
        self.startDate = startDate
        self.endDate = endDate
        self.primaryTime = primaryTime
        
        if secondaryTime != nil{
            self.secondaryTime = secondaryTime
        }
//        setNotifications()
        
        if (name.isEmpty){
            return nil
        }
    }
    
    init?(name: String, icon: UIImage, color: UIColor, primaryTime: NSDate, secondaryTime: NSDate?, startDate: NSDate, endDate: NSDate){
        self.name = name
        self.icon = icon
        self.color = color
        self.startDate = startDate
        self.endDate = endDate
        self.primaryTime = primaryTime
        
        if (name.isEmpty){
            return nil
        }
        if secondaryTime != nil {
            self.secondaryTime = secondaryTime
        }
//        setNotifications()
    }

    // Set the notification to the time that the user specifies
    func setNotifications(){
        //if user hasn't granted permissions, do nothing
        guard let settings = UIApplication.sharedApplication().currentUserNotificationSettings() else { return }
        if settings.types == .None {
            return
        }
        
        // If the user has granted permissions to get notifications:
        UIApplication.sharedApplication().cancelLocalNotification(notification)
        self.notification.fireDate = self.primaryTime!
        self.notification.alertBody = "Time for your task: " + name

        self.notification.userInfo = ["taskName" : name]
//        self.notification.userInfo = ["task": self]
        UIApplication.sharedApplication().scheduleLocalNotification(notification)
    }
    
    func setColor(color: UIColor){
        self.color = color
    }
    func setPTime(time: NSDate){
        self.primaryTime = time;
    }
}
