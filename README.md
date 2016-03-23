# KnockToReact
KnockToReact is an iOS library written in Swift and Objective-C that brings an exclusive feature to interact with users just by receiving and recognizing "knocks" in the device.

Available for iOS 8.0 and higher.

**IMPORTANT**: This project uses background tasks that is not guaranteed to be accepted by Apple in the app submission process.


### About
It is an example that shows how to use background tasks to receive accelerometer data and recognize patterns to trigger events in the app when the user "knocks" the phone. To make it work you have to let the Knock app on background and knock the device three times calmly. If everything works properly you will receive a local notification with your current coordinates.

You can adjust the knock resistance inside app to find the perfect sensibility in your device.

**Knock pattern recognition is optimized to capture knocks when the device is in your pocket or on a soft surface like a bed or a sofa**

Once using background tasks, it is not guaranteed that the task will keep running after a few minutes (you can increase this running time by adding background modes such as Location Update).

### Screenshots

![Alt text](https://github.com/MatheusCavalca/KnockToReact/blob/master/KnockToReactExampleObjC/KnockToReactExampleObjC/Assets.xcassets/appScreen.imageset/appScreen.png "Optional Title") ![Alt text](https://github.com/MatheusCavalca/KnockToReact/blob/master/KnockToReactExampleObjC/KnockToReactExampleObjC/Assets.xcassets/appNotification.imageset/appNotification.png "Optional Title")

### How to install

##### Swift
Drag and drop the ```KnockToReact.swift``` file to your project
##### Objective-C
Drag and drop both ```KnockHelper.h``` and ```KnockHelper.m``` file to your project

### How to use

##### Swift
``` swift
class ViewController: UIViewController,KnockHelperProtocol {

  override func viewDidLoad() {
    super.viewDidLoad()
    
    let knock = KnockToReact()
    
    knock.delegate = self
    knock.startMotion()
    knock.decrementLimitDifference(10)

  }

  func knockPerformed() {
    print("knock")
  }
}
```

##### Objective-C
In your .h file:
``` objc
#import <UIKit/UIKit.h>
#import "SingletonLocation.h"
#import "KnockHelper.h"

@interface ViewController : UIViewController <KnockHelperProtocol>

@end
```
In your .m file:
``` objc
- (void)viewDidLoad {
  [super viewDidLoad];
  // Do any additional setup after loading the view, typically from a nib.
  
  [SingletonLocation sharedInstance];
  [KnockHelper sharedInstance].delegate = self;
}

#pragma mark - KnockHelperDelegate

- (void)knockPerformed {
  UILocalNotification *notification = [[UILocalNotification alloc]init];
  NSString *message = [NSString stringWithFormat: @"Latitude: %f - Longitude: %f", [SingletonLocation sharedInstance].currentLocation.coordinate.latitude, [SingletonLocation sharedInstance].currentLocation.coordinate.longitude];
  [notification setAlertBody:message];
  [notification setSoundName:UILocalNotificationDefaultSoundName];
  [[UIApplication sharedApplication]  setScheduledLocalNotifications:[NSArray arrayWithObject:notification]];
}
```

### License
KnockToReact is available under the MIT license. See the LICENSE file for more info.
