//
//  AppDelegate.swift
//  mOTivator
//
//  Created by Margaret Chapman on 3/29/16.
//  Copyright © 2016 Tufts. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?


    func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool {
        // Override point for customization after application launch.
        
        let notificationSettings = UIUserNotificationSettings(forTypes: [.Alert, .Badge, .Sound], categories: nil)
        UIApplication.sharedApplication().registerUserNotificationSettings(notificationSettings)
        
        return true
    }

    func applicationWillResignActive(application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
    }

    func applicationDidEnterBackground(application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }

    func applicationWillEnterForeground(application: UIApplication) {
        // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
    }

    func applicationDidBecomeActive(application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }

    func applicationWillTerminate(application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }
    // When the user is notified to do a task, the app takes them to the "startActivity" view. 
    // If the notification comes and the user is using the app, an alert pops up, otherwise it is just a normal notification.
    func application(application: UIApplication, didReceiveLocalNotification notification: UILocalNotification) {
        // When local notification received, alert user, take them to the startActivity view
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let viewController: startActivityViewController = storyboard.instantiateViewControllerWithIdentifier("startAct") as! startActivityViewController
        viewController.task = notification.userInfo!["taskName"] as? String
        let rvc = self.window!.rootViewController as! UINavigationController

        // The user is using another app or no app, but they slide the notification to open the app
        if application.applicationState == UIApplicationState.Background || application.applicationState == UIApplicationState.Inactive {
            rvc.pushViewController(viewController, animated: true)
        }
        // The user is currently using the app:
        else {
              var taskName = "."
            if let taskN = notification.userInfo!["taskName"] as? String {
                taskName = ": "+taskN
            }
            // Alert the user to complete their task, opening the "startActivity" view if they agree
            let alert = UIAlertController(title: "Alert", message: "Time to complete task" + taskName, preferredStyle: UIAlertControllerStyle.Alert)
            alert.addAction(UIAlertAction(title: "Start Task", style: UIAlertActionStyle.Default, handler: {
                (action: UIAlertAction!) in
                rvc.pushViewController(viewController, animated: true)}))
            // Allow user to "snooze the alert"
            alert.addAction(UIAlertAction(title: "Snooze", style: UIAlertActionStyle.Default, handler: {action in
                // right now snooze is for 15 seconds. 900 would be 15 minutes
                notification.fireDate = NSDate(timeIntervalSinceNow: 15)
                notification.alertBody = "Snooze complete. Time to complete your task: " + (notification.userInfo!["taskName"] as! String)
                application.scheduleLocalNotification(notification)
                }))
            alert.addAction(UIAlertAction(title: "Cancel", style: UIAlertActionStyle.Cancel, handler: nil))
            self.window?.rootViewController?.presentViewController(alert, animated: true, completion: nil)
        }
    }


}

