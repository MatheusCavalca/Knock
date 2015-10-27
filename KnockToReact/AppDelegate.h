//
//  AppDelegate.h
//  KnockToReact
//
//  Created by Matheus Cavalca on 10/26/15.
//  Copyright © 2015 Matheus Cavalca. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "KnockHelper.h"

@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;
@property (nonatomic,strong) CMMotionActivityManager *motionActivityManager;

@end

