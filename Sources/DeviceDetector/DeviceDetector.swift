//
//  DeviceDetector.swift
//  DeviceDetector
//
//  Created by BaekSungwook on 5/14/22.
//  Copyright © 2022 BaekSungwook. All rights reserved.
//
import Foundation
import UIKit

//https://www.theiphonewiki.com/wiki/Models

public struct DeviceSet: OptionSet {
    public let rawValue: Int
    static let unrecognized   = DeviceSet(rawValue: 1 << 0)
    
    //MARK: iPhone
    static let iPhone6 = DeviceSet(rawValue: 1 << 1)
    static let iPhone6Plus = DeviceSet(rawValue: 1 << 2)
    static let iPhone7 = DeviceSet(rawValue: 1 << 3)
    static let iPhone7Plus = DeviceSet(rawValue: 1 << 4)
    static let iPhone8 = DeviceSet(rawValue: 1 << 5)
    static let iPhone8Plus = DeviceSet(rawValue: 1 << 6)
    
    static let iPhoneX = DeviceSet(rawValue: 1 << 7)
    static let iPhoneXR = DeviceSet(rawValue: 1 << 8)
    static let iPhoneXMax = DeviceSet(rawValue: 1 << 9)
    
    static let iPhone11 = DeviceSet(rawValue: 1 << 10)
    static let iPhone12 = DeviceSet(rawValue: 1 << 11)
    static let iPhone13 = DeviceSet(rawValue: 1 << 12)
    
    static let iPhoneSE1 = DeviceSet(rawValue: 1 << 13)
    static let iPhoneSE2 = DeviceSet(rawValue: 1 << 14)
    static let iPhoneSE3 = DeviceSet(rawValue: 1 << 15)
    
    static let iPhoneMini = DeviceSet(rawValue: 1 << 16)
    static let iPhonePro = DeviceSet(rawValue: 1 << 17)
    static let iPhoneProMax = DeviceSet(rawValue: 1 << 18)
    
    static let iPhoneSE: DeviceSet = [.iPhoneSE1, .iPhoneSE2, .iPhoneSE3]
    static let iPhonePlus: DeviceSet = [.iPhone6Plus, .iPhone7Plus, .iPhone8Plus]
    static let iPhone4_7inch: DeviceSet = [.iPhoneSE2, .iPhoneSE3, .iPhone6, .iPhone7, .iPhone8]
    static let iPhone4inch: DeviceSet = [.iPhoneSE1]
    static let iPhone: DeviceSet = [.iPhoneSE, .iPhonePlus, .iPhone4_7inch, .iPhone4inch, .iPhoneX, .iPhoneXR, .iPhoneXMax, .iPhone11, .iPhone12, .iPhone13, .iPhoneMini, .iPhonePro, .iPhoneProMax]
    
    //MARK: iPad
    static let iPad5    = DeviceSet(rawValue: 1 << 1)
    static let iPad6    = DeviceSet(rawValue: 1 << 1)
    static let iPad7    = DeviceSet(rawValue: 1 << 1)
    static let iPad8    = DeviceSet(rawValue: 1 << 1)
    static let iPad9    = DeviceSet(rawValue: 1 << 1)
    
    static let iPadMini  = DeviceSet(rawValue: 1 << 2)
    
    static let iPadPro9_7inch = DeviceSet(rawValue: 1 << 3)
    static let iPadPro10_5inch = DeviceSet(rawValue: 1 << 3)
    static let iPadPro11inch   = DeviceSet(rawValue: 1 << 3)
    static let iPadPro12_9inch   = DeviceSet(rawValue: 1 << 4)
    
    static let iPad: DeviceSet = [.iPad, .iPadMini, .iPadPro11inch, .iPadPro12_9inch]
    
    public init(rawValue: Int) {
        self.rawValue = rawValue
    }
    
    var name: String {
        switch self {
        case .iPhone:
            return "iPhone"
        case .iPhone6:
            return "iPhone 6"
        case .iPhone7:
            return "iPhone 7"
        case .iPhone8:
            return "iPhone 8"
        case .iPhoneX:
            return "iPhone X"
        case .iPhoneXR:
            return "iPhone XR"
        case .iPhone11:
            return "iPhone 11"
        case .iPhone12:
            return "iPhone 12"
        case .iPhone13:
            return "iPhone 13"
        case .iPhoneSE:
            return "iPhone SE"
        default:
            return ""
        }
    }
}

public final class DeviceDetector {
    public static let shared = DeviceDetector()
    private init() {}
    lazy var product: DeviceSet = {
        return .iPad
    }()
}

extension UIDevice {
    private enum Identifier {
        static let simulator = "Simulator"
        enum iPhone {
            static let plus = "Plus"
            static let old = ["6", "7", "8"]
            static let x = ["X", "XS"]
            static let pro = "Pro"
            static let max = "Max"
            static let mini = "mini"
        }
    }
    
    var product: DeviceSet {
        var systemInfo = utsname()
        uname(&systemInfo)
        guard let appleDevices = Bundle.main.path(forResource: "Device", ofType: "plist"),
            let devicesDict = NSDictionary(contentsOfFile: appleDevices)
        else {
            return .unrecognized
        }
        let machineMirror = Mirror(reflecting: systemInfo.machine)
        let identifier = machineMirror.children.reduce("") { identifier, element in
            guard let value = element.value as? Int8, value != 0 else { return identifier }
            return identifier + String(UnicodeScalar(UInt8(value)))
        }
        guard var deviceName = devicesDict.value(forKey: identifier) as? String else {
            return .unrecognized
        }
        if deviceName == UIDevice.Identifier.simulator, let simulatorDeviceName = ProcessInfo().environment["SIMULATOR_MODEL_IDENTIFIER"] {
            deviceName = simulatorDeviceName
        }
        
        switch deviceName.lowercased() {
        case let model where model.starts(with: DeviceSet.iPhone.name):
            return iPhone(model: model)
        default:
            break
        }
        
        return .unrecognized
    }
    
    private func iPhone(model: String) -> DeviceSet {
        if model.starts(with: DeviceSet.iPhoneSE.name) {
            if model == DeviceSet.iPhoneSE.name {
                return .iPhoneSE1
            }
            else {
                return .iPhoneSE2
            }
        }
        else if Identifier.iPhone.old.filter({ model.contains($0) }).count > 0 {
            if Identifier.iPhone.plus.filter( { model.contains($0)}).count > 0 {
                if model.starts(with: DeviceSet.iPhone6.name) {
                    return .iPhone6Plus
                }
                else if model.starts(with: DeviceSet.iPhone7.name) {
                    return .iPhone7Plus
                }
                else {
                    return .iPhone8Plus
                }
            }
            else {
                if model == DeviceSet.iPhone6.name {
                    return .iPhone6
                }
                else if model == DeviceSet.iPhone7.name {
                    return .iPhone7
                }
                else {
                    return .iPhone8
                }
            }
        }
        else if model.starts(with: DeviceSet.iPhoneX.name) {
            if model == DeviceSet.iPhoneXR.name {
                return .iPhoneXR
            }
            else if model.contains(Identifier.iPhone.max) {
                return .iPhoneXMax
            }
            else {
                return .iPhoneX
            }
        }
        else if model.starts(with: DeviceSet.iPhone11.name) {
            if model == DeviceSet.iPhone11.name {
                return .iPhone11
            }
            else if model.contains(Identifier.iPhone.max) {
                return .iPhoneProMax
            }
            else {
                return .iPhonePro
            }
        }
        else if model.starts(with: DeviceSet.iPhone12.name) {
            if model == DeviceSet.iPhone11.name {
                return .iPhone11
            }
            else if model.contains(Identifier.iPhone.mini) {
                return .iPhoneMini
            }
            else if model.contains(Identifier.iPhone.max) {
                return .iPhoneProMax
            }
            else {
                return .iPhonePro
            }
        }
        else if model.starts(with: DeviceSet.iPhone13.name) {
            if model == DeviceSet.iPhone11.name {
                return .iPhone11
            }
            else if model.contains(Identifier.iPhone.mini) {
                return .iPhoneMini
            }
            else if model.contains(Identifier.iPhone.max) {
                return .iPhoneProMax
            }
            else {
                return .iPhonePro
            }
        }
        return .unrecognized
    }
}
