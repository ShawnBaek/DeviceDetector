# DeviceDetector

DeviceDetector detects apple's devices(iPhone and iPad) model by using identifier code. I referred to this [wiki](https://theapplewiki.com/wiki/). It does not support old models that can't install iOS 13

```swift
public final class DeviceDetector {
    public static let current = DeviceDetector()
    public let device: DeviceOptionSet
    public let deviceName: String
    public let isiPad: Bool
    public let isiPhone: Bool
    public let hasSafeArea: Bool
    private let deviceDict: NSDictionary
    private init(identifier: String? = nil) {
        if let appleDevices = Bundle.module.path(forResource: "Device", ofType: "plist"),
           let dict = NSDictionary(contentsOfFile: appleDevices) {
            deviceDict = dict
        }
        else {
            deviceDict = [:]
        }
        deviceName = UIDevice.current.deviceName(id: identifier, dict: deviceDict) ?? ""
        device = UIDevice.current.device(name: deviceName)
        isiPad = device.isSubset(of: .iPadSet)
        isiPhone = device.isSubset(of: .iPhoneSet)
        if isiPhone, device.isSubset(of: .iPhoneSafeAreaSet) {
            hasSafeArea = true
        }
        else {
            hasSafeArea = false
        }
    }
    
    public convenience init?(id identifier: String) {
        self.init(identifier: identifier)
    }
}
```

## Sample

|<img width="577" alt="test3" src="https://user-images.githubusercontent.com/12643700/168486396-d028e8f3-1698-4c54-9dc8-fbbd93a15af3.png">|<img width="620" alt="test4" src="https://user-images.githubusercontent.com/12643700/168486399-5b476abb-41b0-49fb-9b67-2d7bfc7b8405.png">|<img width="359" alt="test1" src="https://user-images.githubusercontent.com/12643700/168486335-7c5aa1b1-f74d-4905-8a41-0cb8cd84ce8b.png">|<img width="375" alt="test2" src="https://user-images.githubusercontent.com/12643700/168486341-21b1214c-63bb-4749-bcf4-c81108c3b3fa.png">|
|---|---|---|---|


```swift
import UIKit
import DeviceDetector
class ViewController: UIViewController {
    @IBOutlet weak var label: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let detector = DeviceDetector.current
        let deviceName = detector.deviceName
        let device = detector.device
        
        let information = """
        Model: \(deviceName)
        iPhone?: \(detector.isiPhone)
        iPad?: \(detector.isiPad)
        Notch?: \(detector.hasSafeArea)
        
        4inch?: \(device.isSubset(of: .iPhone4inchSet))
        4.7inch?: \(device.isSubset(of: .iPhone4_7inchSet))
        iPhoneSE?: \(device.isSubset(of: .iPhoneSESet))
        iPhonePlus?: \(device.isSubset(of: .iPhonePlusSet))
        iPadPro?: \(device.isSubset(of: .iPadProSet))
        """
        label.text = information
    }
}
```

## Features
You can check the device model not only physical device but also simulator.

1. Check the current device
```swift
import DeviceDetector
DeviceDetector.current.device //DeviceOptionSet.iPhone11
```

2. Check the current device name (String)
```swift
import DeviceDetector
DeviceDetector.current.deviceName //iPhone11
```

3. Check whether iPhone or iPad
```swift
import DeviceDetector
DeviceDetector.current.isiPhone //true or false
DeviceDetector.current.isiPad //true or false
```

4. Device Groups
It uses OptionSet. You can check Is your model subset of the device groups.

- iPhoneSESet (iPhoneSE1, iPhoneSE2, iPhoneSE3)
```swift
import DeviceDetector
if DeviceDetector.current.device.isSubset(of: .iPhoneSESet) {
  print("This is iPhoneSE")
}
```

- iPhonePlusSet (iPhone6Plus, iPhone7Plus, iPhone8Plus)
```swift
import DeviceDetector
if DeviceDetector.current.device.isSubset(of: .iPhonePlusSet) {
  print("This is iPhonePlus")
}
```

- iPhone4_7inchSet (iPhoneSE2, iPhoneSE3, iPhone6, iPhone7, iPhone8)
```swift
import DeviceDetector
if DeviceDetector.current.device.isSubset(of: .iPhone4_7inchSet) {
  print("This is 4.7inch")
}
```

- iPhone4inchSet (iPhoneSE1)
```swift
import DeviceDetector
if DeviceDetector.current.device.isSubset(of: .iPhone4inchSet) {
  print("This is 4inch")
}
```

- iPhoneSafeAreaSet
```swift
import DeviceDetector
//Option 1. Use DeviceSet.iPhoneSafeAreaSet
if DeviceDetector.current.device.isSubset(of: .iPhoneSafeAreaSet) {
  print("This iPhone has safeArea")
}

//Option 2. DeviceDetector.shared.hasSafeArea
DeviceDetector.current.hasSafeArea //true or false
```
- iPadProSet (iPadPro9_7inch, iPadPro10_5inch, iPadPro11inch, iPadPro12_9inch)
```swift
import DeviceDetector
if DeviceDetector.current.device.isSubset(of: .iPadProSet) {
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
