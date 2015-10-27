//
//  SingletonLocation.m
//  KnockToReact
//
//  Created by Matheus Cavalca on 10/26/15.
//  Copyright © 2015 Matheus Cavalca. All rights reserved.
//

#import "SingletonLocation.h"

@implementation SingletonLocation
{
    BOOL isUpdatingLocation;
}

+(SingletonLocation *) sharedInstance
{
    static SingletonLocation *instance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        instance = [[self alloc]init];
    });
    return instance;
}

- (id)init {
    self = [super init];
    if(self != nil) {
        self.locationManager = [[CLLocationManager alloc] init];
        self.locationManager.delegate = self;
        self.locationManager.pausesLocationUpdatesAutomatically = NO;
        self.locationManager.activityType = CLActivityTypeOther;

        [self.locationManager requestAlwaysAuthorization];
        [self.locationManager startUpdatingLocation];
        
        isUpdatingLocation = YES;
    }
    return self;
}

- (void)stopUpdatingLocation{
    [self.locationManager stopUpdatingLocation];
    isUpdatingLocation = NO;
}

- (void)locationManager:(CLLocationManager *)manager
     didUpdateLocations:(NSArray*)locations
{
    CLLocation *location = [locations lastObject];
    self.currentLocation = location;
}

@end
