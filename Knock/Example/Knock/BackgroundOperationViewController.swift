//
//  BackgroundOperationViewController.swift
//  KnockToReactExampleSwift
//
//  Created by Matheus Cavalca on 6/11/16.
//  Copyright © 2016 Lucas Farah. All rights reserved.
//

import UIKit
import Knock

class BackgroundOperationViewController: UIViewController {

    // MARK: - Properties
    
    var backgroundTask: UIBackgroundTaskIdentifier = UIBackgroundTaskInvalid
    
    let knockManager = Knock.sharedInstance
    
    // MARK: - Life Cycle

    override func viewDidLoad() {
        super.viewDidLoad()
        registerBackgroundTask()
        registerLocalNotification()
        registerApplicationObservers()
        
        knockManager.delegate = self
    }
    
    deinit {
        removeObservers()
    }

    // MARK: - Action
    
    @IBAction func returnButton(sender: AnyObject) {
        dismissViewControllerAnimated(true, completion: nil)
    }
    
    // MARK: - Background Taks
    
    func registerBackgroundTask() {
        backgroundTask = UIApplication.sharedApplication().beginBackgroundTaskWithExpirationHandler {
            [unowned self] in
            self.endBackgroundTask()
        }
        assert(backgroundTask != UIBackgroundTaskInvalid)
    }
    
    func endBackgroundTask() {
        UIApplication.sharedApplication().endBackgroundTask(backgroundTask)
        backgroundTask = UIBackgroundTaskInvalid
    }
    
    // MARK: - Helpers
    
    func registerLocalNotification() {
        let notificationSettings = UIUserNotificationSettings(forTypes: [.Alert, .Badge, .Sound], categories: nil)
        UIApplication.sharedApplication().registerUserNotificationSettings(notificationSettings)
    }
    
    // MARK: - Observers
    
    func registerApplicationObservers() {
        NSNotificationCenter.defaultCenter().addObserver(self, selector: #selector(appDidEnteredBackground), name: UIApplicationDidEnterBackgroundNotification, object: nil)
        NSNotificationCenter.defaultCenter().addObserver(self, selector: #selector(appDidBecomeActive), name: UIApplicationDidBecomeActiveNotification, object: nil)
    }
    
    func removeObservers() {
        NSNotificationCenter.defaultCenter().removeObserver(self, name: UIApplicationDidEnterBackgroundNotification, object: nil)
        NSNotificationCenter.defaultCenter().removeObserver(self, name: UIApplicationDidBecomeActiveNotification, object: nil)
    }
    
    func appDidEnteredBackground() {
        knockManager.startOperation()
    }
    
    func appDidBecomeActive() {
        knockManager.stopOperation()
    }
}

extension BackgroundOperationViewController: KnockDelegate {
    
    func knockEventPerformed() {
        let notification = UILocalNotification()
        notification.alertBody = "Knock event performed"
        notification.alertTitle = "Knock"
        notification.soundName = UILocalNotificationDefaultSoundName
        UIApplication.sharedApplication().scheduleLocalNotification(notification)
    }
    
}
