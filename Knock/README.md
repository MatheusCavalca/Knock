**UNDER CONSTRUCTION**

# Knock

[![CI Status](http://img.shields.io/travis/matheuscavalca/Knock.svg?style=flat)](https://travis-ci.org/matheuscavalca/Knock)
[![Version](https://img.shields.io/cocoapods/v/Knock.svg?style=flat)](http://cocoapods.org/pods/Knock)
[![License](https://img.shields.io/cocoapods/l/Knock.svg?style=flat)](http://cocoapods.org/pods/Knock)
[![Platform](https://img.shields.io/cocoapods/p/Knock.svg?style=flat)](http://cocoapods.org/pods/Knock)

KnockToReact is an iOS library written in Swift and Objective-C that brings an exclusive feature to interact with users just by receiving and recognizing "knocks" in the device.

Available for iOS 8.0 and higher.

## About

It is an example that shows how to use background tasks to receive accelerometer data and recognize patterns to trigger events in the app when the user "knocks" the phone. To make it work you have to let the Knock app on background and knock the device three times calmly. If everything works properly you will receive a local notification with your current coordinates.

You can adjust the knock resistance inside app to find the perfect sensibility in your device.

**Knock pattern recognition is optimized to capture knocks when the device is in your pocket or on a soft surface.**

Once using background tasks, it is not guaranteed that the task will keep running after a few minutes (you can increase this running time by adding background modes such as Location Update).

## Example

To run the example project, clone the repo, and run `pod install` from the Example directory first.

## Installation

Knock is available through [CocoaPods](http://cocoapods.org). To install
it, simply add the following line to your Podfile:

```ruby
pod "Knock"
```

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

## Author

matheuscavalca, matheus.cavalca@acad.pucrs.br

## License

Knock is available under the MIT license. See the LICENSE file for more info.
