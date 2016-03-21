//
//  KnockHelper.m
//  KnockToReact
//
//  Created by Matheus Cavalca on 10/26/15.
//  Copyright © 2015 Matheus Cavalca. All rights reserved.
//

#import "KnockHelper.h"


@implementation KnockHelper

#pragma mark - LimitDifference handlers

@synthesize limitDifference;

- (void)initializeLimitDifference:(double)limit {
    if(![[NSUserDefaults standardUserDefaults] objectForKey:@"limitDifference"]){
        [self setLimitDifference:2.5];
    }
    else{
        double limit = [[[NSUserDefaults standardUserDefaults] objectForKey:@"limitDifference"] doubleValue];
        limitDifference = limit;
    }
}

- (void)setLimitDifference:(double)limit {
    limitDifference = limit;
    [[NSUserDefaults standardUserDefaults] setObject:[NSNumber numberWithDouble: limit] forKey:@"limitDifference"];
    [[NSUserDefaults standardUserDefaults] synchronize];
}

- (double)limitDifference {
    if(limitDifference < 1){
        return 1;
    }
    else{
        return limitDifference;
    }
}

- (void)incrementLimitDifference:(double)incrementValue {
    [self setLimitDifference:[self limitDifference] + incrementValue];
}

- (void)decrementLimitDifference:(double)incrementValue {
    [self setLimitDifference:[self limitDifference] - incrementValue];
}

#pragma mark - Singleton Methods

+(KnockHelper *) sharedInstance {
    static KnockHelper *instance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        instance = [[self alloc]init];
        
    });
    return instance;
}

- (id)init {
    self = [super init];
    if(self != nil) {
        [self initializeLimitDifference:2.5];
    }
    return self;
}

#pragma mark - Motion Methods

- (void)startMotion {
    self.motionManager = [[CMMotionManager alloc] init];
    self.motionManager.accelerometerUpdateInterval = .025;
    [self startBackgroundInteractionWithMotion];
}

- (void)stopMotion {
    [[UIApplication sharedApplication] endBackgroundTask:self.backgroundAccelerometerTask];
    [self.motionManager stopAccelerometerUpdates];
}

- (void)startBackgroundInteractionWithMotion {
    UIApplication *application = [UIApplication sharedApplication];
    
    self.backgroundAccelerometerTask = [application beginBackgroundTaskWithExpirationHandler:nil];
    
    [self.motionManager startAccelerometerUpdatesToQueue:[[NSOperationQueue alloc] init]
                                             withHandler:^(CMAccelerometerData *data, NSError *error) {
         dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_HIGH, 0), ^{
             [self methodToBackgroundInteraction:data];
         });
     }];
}

- (void)methodToBackgroundInteraction : (CMAccelerometerData*)data {
    NSTimeInterval seconds = [NSDate timeIntervalSinceReferenceDate];
    double milliseconds = seconds*1000;
    
    //pause between two attempts to give 3 knocks
    if(milliseconds - self.lastPush > 5000){
        float diferenceZ = data.acceleration.z - self.lastCapturedData.acceleration.z;
        self.lastCapturedData = data;
        NSLog(@"%f", diferenceZ);
        
        double limitDiference = [self limitDifference];
        
        if(diferenceZ > limitDiference || diferenceZ < -limitDiference){
            //NSLog(@"Z: %f",diferenceZ);
            if(milliseconds - self.mlsFirst < 2000 && milliseconds - self.mlsFirst > 300){
                if(milliseconds - self.mlsSecond < 1000 && milliseconds - self.mlsSecond > 300){
                    if(milliseconds - self.mlsThird > 300){
                        self.lastPush = milliseconds;
                        self.mlsThird = milliseconds;
                        NSLog(@"Third knock: %f (operation succeded)",diferenceZ);
                        [self.delegate knockPerformed];
                    }
                }
                else if(milliseconds - self.mlsSecond > 300){
                    NSLog(@"Second knock: %f",diferenceZ);
                    self.mlsSecond = milliseconds;
                }
            }
            else if(milliseconds - self.mlsFirst > 300){
                self.mlsFirst = milliseconds;
                NSLog(@"First knock: %f",diferenceZ);
            }
        }
    }
}

@end
