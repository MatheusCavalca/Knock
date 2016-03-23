//
//  KnockToReact.swift
//  KnockToReactExampleSwift
//
//  Created by Lucas Farah on 3/22/16.
//  Copyright © 2016 Lucas Farah. All rights reserved.
//

import UIKit
import CoreMotion

protocol KnockHelperProtocol: AnyObject
{
  func knockPerformed()
  
}

class KnockToReact: AnyObject {
  
  var accelerometerActive: Bool?
  var backgroundAccelerometerTask: UIBackgroundTaskIdentifier?
  var delegate: KnockHelperProtocol?
  
  var motionManager:CMMotionManager?
  var mlsFirst: Double = 0
  var mlsSecond: Double = 0
  var mlsThird: Double = 0
  var lastPush: Double = 0
  var limitDifference: Double = 0
  var lastCapturedData: CMAccelerometerData?
  
  func incrementLimitDifference(incrementValue:Double)
  {
    self.setLimitDifference(self.limitDifference + incrementValue)
  }
  func decrementLimitDifference(decrementValue:Double)
  {
    self.setLimitDifference(self.limitDifference - decrementValue)
  }
  
  
  func initializeLimitDifference(limit:Double)
  {
    if NSUserDefaults.standardUserDefaults().objectForKey("limitDifference") == nil
    {
      self.setLimitDifference(2.5)
    }
    else
    {
      let limit = NSUserDefaults.standardUserDefaults().objectForKey("limitDifference") as! Double
      self.setLimitDifference(limit)
    }
  }
  func setLimitDifference(limit:Double)
  {
    self.limitDifference = limit
    NSUserDefaults.standardUserDefaults().setObject(limit, forKey: "limitDifference")
    NSUserDefaults.standardUserDefaults().synchronize()
  }
  
  //MARK: - Singleton Methods
  init()
  {
    self.initializeLimitDifference(2.5)
  }
  
  //MARK: Motion Methods
  func startMotion()
  {
    self.motionManager = CMMotionManager()
    self.motionManager?.accelerometerUpdateInterval = 0.025
    self.startBackgroundInteractionWithMotion()
  }
  func stopMotion()
  {
    UIApplication.sharedApplication().endBackgroundTask(self.backgroundAccelerometerTask!)
    self.motionManager?.stopAccelerometerUpdates()
  }
  
  func startBackgroundInteractionWithMotion()
  {
    self.backgroundAccelerometerTask = UIApplication.sharedApplication().beginBackgroundTaskWithExpirationHandler(nil)
    
    self.motionManager?.startAccelerometerUpdatesToQueue(NSOperationQueue(), withHandler: { (data, error) in
      dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0))
      {
        // Task
        self.methodToBackgroundInteraction(data!)
      }
    })
  }
  
  func methodToBackgroundInteraction(data:CMAccelerometerData)
  {
    let seconds = NSDate.timeIntervalSinceReferenceDate()
    let milliseconds = seconds * 1000
    
    //pause between two attempts to give 3 knocks
    if milliseconds - self.lastPush > 5000
    {
      var differenceZ = 0.0
      if let lastCapturedData = self.lastCapturedData
      {
        differenceZ = data.acceleration.z - lastCapturedData.acceleration.z
      }
      else
      {
        differenceZ = data.acceleration.z
      }
      
      self.lastCapturedData = data
      let limitDifference = self.limitDifference
      print(differenceZ)

      if differenceZ > limitDifference || differenceZ < -limitDifference
      {
        if(milliseconds - self.mlsFirst < 2000 && milliseconds - self.mlsFirst > 300){
          if(milliseconds - self.mlsSecond < 1000 && milliseconds - self.mlsSecond > 300){
            if(milliseconds - self.mlsThird > 300){
              self.lastPush = milliseconds
              self.mlsThird = milliseconds
              self.delegate?.knockPerformed()
            }
            else if milliseconds - self.mlsSecond > 300
            {
              self.mlsSecond = milliseconds
              print(data)
            }
            else if milliseconds - self.mlsFirst > 300
            {
              self.mlsFirst = milliseconds
              print(data)

            }
          }
        }
      }
    }
    func handleAccelerometerData(data:CMAccelerometerData)
    {
      let seconds = NSDate.timeIntervalSinceReferenceDate()
      let milliseconds = seconds * 1000
    }
  }
}
