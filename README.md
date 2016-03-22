# KnockToReact

Example of an iOS Application written in Objective-C. Brings an exclusive feature to interact with users just by receiving and recognizing "knocks" in the device.

Available for iOS 8.0 and higher.

**IMPORTANT**: This project uses background tasks that is not guaranteed to be accepted by Apple in the app submission process.

About
-------
It is an example that shows how to use background tasks to receive accelerometer data and recognize patterns to trigger events in the app when the user "knocks" the phone. To make it work you have to let the Knock app on background and knock the device three times calmly. If everything works properly you will receive a local notification with your current coordinates.

You can adjust the knock resistance inside app to find the perfect sensibility in your device.

**Knock pattern recognition is optimized to capture knocks when the device is in your pocket or on a soft surface like a bed or a sofa**

Once using background tasks, it is not guaranteed that the task will keep running after a few minutes (you can increase this running time by adding background modes such as Location Update).

