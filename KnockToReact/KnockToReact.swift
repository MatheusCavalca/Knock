//
//  KnockToReact.swift
//  KnockToReactExampleSwift
//
//  Created by Lucas Farah on 3/22/16.
//  Copyright © 2016 Lucas Farah. All rights reserved.
//

import UIKit
import CoreMotion

protocol KnockToReactProtocol: class {
  func knockEventPerformed()
}

public class KnockToReact: NSObject {
    
    // MARK: - Static Properties
    
    static let sharedInstance = KnockToReact()

    // MARK: - Public Properties
    
    public var limitDifference = 2.5 {
        didSet {
            if limitDifference < 1.0 {
                limitDifference = 1.0
            } else if limitDifference > 4.0 {
                limitDifference = 4.0
            }
        }
    }
    
    public var numberOfKnockNeeded: Int! = 3 {
        didSet {
            if numberOfKnockNeeded < 1 {
                numberOfKnockNeeded = 1
            }
        }
    }
    
    var delegate: KnockToReactProtocol?
    
    public var minimumTimeBetweenSingleKnocks: NSTimeInterval! = 0.3
    public var maximumTimeBetweenSingleKnocks: NSTimeInterval! = 1.0
    public var timeNeededBetweenKnockOccurances: NSTimeInterval! = 5.0
    
    // MARK: - Private Properties
    
    let DEBUG = true
    
    private var motionManager = CMMotionManager()
    
    private var lastCapturedData: CMAccelerometerData!
    
    private var timeKnocks = [NSTimeInterval]()
    private var lastKnockOccurance: NSTimeInterval! = 0.0
  
    // MARK: - Life Cycle
    
    private override init() {
        super.init()
        motionManager.accelerometerUpdateInterval = 0.025
    }
    
    // MARK: - Public functions
    
    public func startOperation() {
        motionManager.startAccelerometerUpdatesToQueue(NSOperationQueue.currentQueue()!) { (data, error) -> Void in
            self.accelerometerIteration(data!)
        }
    }
    
    public func incrementLimitDifference(incrementValue: Double) {
        limitDifference += incrementValue
    }
    
    public func decrementLimitDifference(incrementValue: Double) {
        limitDifference -= incrementValue
    }

    // MARK: - Private functions
    
    private func accelerometerIteration(data: CMAccelerometerData) {
        let currentTime = NSDate.timeIntervalSinceReferenceDate()
        
        if lastCapturedData == nil {
            lastCapturedData = data
            return
        }
        
        if timeKnocks.count > 0 {
            let lastKnockTime = timeKnocks[timeKnocks.count - 1]
            if currentTime - lastKnockTime > maximumTimeBetweenSingleKnocks {
                timeKnocks = [NSTimeInterval]()
            }
        }
        
        if currentTime - lastKnockOccurance > timeNeededBetweenKnockOccurances {
            let differenceZ = data.acceleration.z - lastCapturedData.acceleration.z
            lastCapturedData = data
            
            if DEBUG {
               print(differenceZ)
            }
            
            if differenceZ > limitDifference || differenceZ < -limitDifference{
                if timeKnocks.count > 0 {
                    let lastKnockTime = timeKnocks[timeKnocks.count - 1]
                    
                    if currentTime - lastKnockTime < maximumTimeBetweenSingleKnocks && currentTime - lastKnockTime > minimumTimeBetweenSingleKnocks {
                        
                        if DEBUG {
                            print("SINGLE KNOCK PERFORMED")
                        }
                        
                        if timeKnocks.count + 1 == numberOfKnockNeeded {
                            delegate?.knockEventPerformed()
                            timeKnocks = [NSTimeInterval]()
                        } else {
                            timeKnocks.append(currentTime)
                        }
                    }
                } else {
                    if timeKnocks.count + 1 == numberOfKnockNeeded {
                        delegate?.knockEventPerformed()
                        timeKnocks = [NSTimeInterval]()
                    } else {
                        timeKnocks.append(currentTime)
                    }
                }
                
            }
        }
    }
    
    
}
