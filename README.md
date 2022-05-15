# DeviceDetector

DeviceDetector detect apple's devices(iPhone and iPad) model name by using identifier code. 
I refered this [wiki](https://www.theiphonewiki.com/wiki/Models). It is not support old models that can't install iOS 13

## Features
You can check the device model not only physical device but also simulator.

1. Check the current device
```swift
//DeviceSet.iPhone11
DeviceDetector.shared.currentDevice
```

2. Check whether iPhone or iPad
```swift
DeviceDetector.shared.isiPhone //true or false
DeviceDetector.shared.isiPad //true or false
```

3. Device Groups
It uses OptionSet. You can check Is your model subset of the device groups.

- iPhoneSESet (iPhoneSE1, iPhoneSE2, iPhoneSE3)
```swift
if DeviceSet.iPhoneSESet.contains(DeviceDetector.shared.currentDevice) {
  print("This is iPhoneSE series")
}
```

- iPhonePlusSet (iPhone6Plus, iPhone7Plus, iPhone8Plus)
```swift
if DeviceSet.iPhonePlusSet.contains(DeviceDetector.shared.currentDevice) {
  print("This is iPhonePlus series")
}
```

- iPhone4_7inchSet (iPhoneSE2, iPhoneSE3, iPhone6, iPhone7, iPhone8)


## Environment
Above iOS 13

## TODO
Support Mac and Apple Watch
