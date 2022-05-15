# DeviceDetector

DeviceDetector detects apple's devices(iPhone and iPad) model names by using identifier code. I referred to this [wiki](https://www.theiphonewiki.com/wiki/Models). It does not support old models that can't install iOS 13

## Features
You can check the device model not only physical device but also simulator.

1. Check the current device
```swift
import DeviceDetector
DeviceDetector.shared.currentDevice //DeviceSet.iPhone11
```

2. Check whether iPhone or iPad
```swift
import DeviceDetector
DeviceDetector.shared.isiPhone //true or false
DeviceDetector.shared.isiPad //true or false
```

3. Device Groups
It uses OptionSet. You can check Is your model subset of the device groups.

- iPhoneSESet (iPhoneSE1, iPhoneSE2, iPhoneSE3)
```swift
import DeviceDetector
if DeviceSet.iPhoneSESet.contains(DeviceDetector.shared.currentDevice) {
  print("This is iPhoneSE")
}
```

- iPhonePlusSet (iPhone6Plus, iPhone7Plus, iPhone8Plus)
```swift
import DeviceDetector
if DeviceSet.iPhonePlusSet.contains(DeviceDetector.shared.currentDevice) {
  print("This is iPhonePlus")
}
```

- iPhone4_7inchSet (iPhoneSE2, iPhoneSE3, iPhone6, iPhone7, iPhone8)
```swift
import DeviceDetector
if DeviceSet.iPhone4_7inchSet.contains(DeviceDetector.shared.currentDevice) {
  print("This is 4.7inch")
}
```

- iPhone4inchSet (iPhoneSE1)
```swift
import DeviceDetector
if DeviceSet.iPhone4inchSet.contains(DeviceDetector.shared.currentDevice) {
  print("This is 4inch")
}
```

- iPhoneSafeAreaSet
```swift
import DeviceDetector
//Option 1. Use DeviceSet.iPhoneSafeAreaSet
if DeviceSet.iPhoneSafeAreaSet.contains(DeviceDetector.shared.currentDevice) {
  print("This iPhone has safeArea")
}

//Option 2. DeviceDetector.shared.hasSafeArea
DeviceDetector.shared.hasSafeArea //true or false
```
- iPadProSet (iPadPro9_7inch, iPadPro10_5inch, iPadPro11inch, iPadPro12_9inch)
```swift
import DeviceDetector
if DeviceSet.iPadProSet.contains(DeviceDetector.shared.currentDevice) {
  print("This is iPad Pro")
}
```

## Environment
Above iOS 13

## How to install, SPM
Use Swift Package Manager

## UnitTest (23 tests)
<img width="263" alt="tests" src="https://user-images.githubusercontent.com/12643700/168467179-b70c0117-4bc1-476b-8b99-dfaa8df051fe.png">


## TODO
Support Mac and Apple Watch
