//
//  KnockHelper.h
//  KnockToReact
//
//  Created by Matheus Cavalca on 10/26/15.
//  Copyright © 2015 Matheus Cavalca. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "CoreMotion/CoreMotion.h"
#import <CoreLocation/CoreLocation.h>
#import <UIKit/UIKit.h>

@protocol KnockHelperProtocol <NSObject>

- (void)knockPerformed;

@end

@interface KnockHelper : NSObject <UIAccelerometerDelegate>

@property BOOL accelerometerActive;
@property UIBackgroundTaskIdentifier backgroundAccelerometerTask;
@property(nonatomic, weak) id<KnockHelperProtocol> delegate;
+(KnockHelper *) sharedInstance;

@property (nonatomic, strong) CMMotionManager *motionManager;
@property double mlsFirst;
@property double mlsSecond;
@property double mlsThird;
@property double lastPush;
@property (nonatomic) double limitDifference;
@property (nonatomic, strong) CMAccelerometerData *lastCapturedData;

- (void)startMotion;
- (void)stopMotion;
- (void)incrementLimitDifference:(double)incrementValue;
- (void)decrementLimitDifference:(double)incrementValue;
@end
