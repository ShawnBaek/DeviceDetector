//
//  File.swift
//
//
//  Created by Sungwook Baek on 2022/05/14.
//

import Foundation

enum DeviceParser {
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
        enum iPad {
            static let air = "Air"
            static let pro = "Pro"
            static let mini = "mini"
            static let pro9_7 = "9.7"
            static let pro10_5 = "10.5"
            static let pro12_9 = "12.9"
            static let pro11 = "11"
            static let pro13 = "13"
        }
    }

    static func deviceName(id: String? = nil, dict: NSDictionary) -> String? {
        var identifier = ""
        if let id = id {
            identifier = id
        }
        else {
            var systemInfo = utsname()
            uname(&systemInfo)
            let machineMirror = Mirror(reflecting: systemInfo.machine)
            identifier = machineMirror.children.reduce("") { identifier, element in
                guard let value = element.value as? Int8, value != 0 else { return identifier }
                return identifier + String(UnicodeScalar(UInt8(value)))
            }
        }
        guard var deviceName = dict.value(forKey: identifier) as? String else {
            return nil
        }
        #if canImport(UIKit)
        if deviceName == Identifier.simulator, let simulatorDeviceIdentifier = ProcessInfo().environment["SIMULATOR_MODEL_IDENTIFIER"] {
            if let simulatorDeviceName = dict.value(forKey: simulatorDeviceIdentifier) as? String {
                deviceName = simulatorDeviceName
            }
            else {
                return nil
            }
        }
        #endif
        return deviceName
    }

    static func device(name: String?) -> DeviceOptionSet {
        guard let deviceName = name else {
            return .unrecognized
        }
        switch deviceName {
        case let model where model.starts(with: DeviceOptionSet.iPhoneSet.name):
            return iPhone(model: model)
        case let model where model.starts(with: DeviceOptionSet.iPadSet.name):
            return iPad(model: model)
        case let model where model.starts(with: DeviceOptionSet.iPod.name):
            return .iPod
        default:
            return .unrecognized
        }
    }

    private static func iPhone(model: String) -> DeviceOptionSet {
        if model.starts(with: DeviceOptionSet.iPhoneSESet.name) {
            if model == DeviceOptionSet.iPhoneSE1.name {
                return .iPhoneSE1
            }
            else if model == DeviceOptionSet.iPhoneSE2.name {
                return .iPhoneSE2
            }
            else {
                return .iPhoneSE3
            }
        }
        else if model == "iPhone Air" { return .iPhoneAir }
        else if model.starts(with: "iPhone 17") {
            if model == "iPhone 17" { return .iPhone17 }
            else if model.contains(Identifier.iPhone.max) { return .iPhone17ProMax }
            else { return .iPhone17Pro }
        }
        else if model.starts(with: "iPhone 16") {
            if model == "iPhone 16" { return .iPhone16 }
            else if model == "iPhone 16e" { return .iPhone16E }
            else if model.contains(Identifier.iPhone.plus) { return .iPhone16Plus }
            else if model.contains(Identifier.iPhone.max) { return .iPhone16ProMax }
            else { return .iPhone16Pro }
        }
        else if model.starts(with: "iPhone 15") {
            if model == "iPhone 15" { return .iPhone15 }
            else if model.contains(Identifier.iPhone.plus) { return .iPhone15Plus }
            else if model.contains(Identifier.iPhone.max) { return .iPhone15ProMax }
            else { return .iPhone15Pro }
        }
        else if model.starts(with: "iPhone 14") {
            if model == "iPhone 14" { return .iPhone14 }
            else if model.contains(Identifier.iPhone.plus) { return .iPhone14Plus }
            else if model.contains(Identifier.iPhone.max) { return .iPhone14ProMax }
            else { return .iPhone14Pro }
        }
        else if Identifier.iPhone.old.filter({ model.contains($0) }).count > 0 {
            if model.contains(Identifier.iPhone.plus) {
                if model.starts(with: DeviceOptionSet.iPhone6S.name) {
                    return .iPhone6SPlus
                }
                else if model.starts(with: DeviceOptionSet.iPhone7.name) {
                    return .iPhone7Plus
                }
                else {
                    return .iPhone8Plus
                }
            }
            else {
                if model == DeviceOptionSet.iPhone6S.name {
                    return .iPhone6S
                }
                else if model == DeviceOptionSet.iPhone7.name {
                    return .iPhone7
                }
                else {
                    return .iPhone8
                }
            }
        }
        else if model.starts(with: DeviceOptionSet.iPhoneX.name) {
            if model == DeviceOptionSet.iPhoneXR.name {
                return .iPhoneXR
            }
            else if model.contains(Identifier.iPhone.max) {
                return .iPhoneXSMax
            }
            else {
                if model == DeviceOptionSet.iPhoneX.name {
                    return .iPhoneX
                }
                else {
                    return .iPhoneXS
                }
            }
        }
        else if model.starts(with: DeviceOptionSet.iPhone11.name) {
            if model == DeviceOptionSet.iPhone11.name {
                return .iPhone11
            }
            else if model.contains(Identifier.iPhone.max) {
                return .iPhoneProMax
            }
            else {
                return .iPhonePro
            }
        }
        else if model.starts(with: DeviceOptionSet.iPhone12.name) {
            if model == DeviceOptionSet.iPhone12.name {
                return .iPhone12
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
        else if model.starts(with: DeviceOptionSet.iPhone13.name) {
            if model == DeviceOptionSet.iPhone13.name {
                return .iPhone13
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

    private static func iPad(model: String) -> DeviceOptionSet {
        if model.contains(Identifier.iPad.air) {
            return .iPadAir
        }
        else if model.contains(Identifier.iPad.pro) {
            if model.contains(Identifier.iPad.pro9_7) {
                return .iPadPro9_7inch
            }
            else if model.contains(Identifier.iPad.pro10_5) {
                return .iPadPro10_5inch
            }
            else if model.contains(Identifier.iPad.pro11) {
                return .iPadPro11inch
            }
            else if model.contains(Identifier.iPad.pro12_9) {
                return .iPadPro12_9inch
            }
            else if model.contains(Identifier.iPad.pro13) {
                return .iPadPro13inch
            }
        }
        else if model.contains(Identifier.iPad.mini) {
            return .iPadMini
        }
        else {
            if model == DeviceOptionSet.iPad5.name {
                return .iPad5
            }
            else if model == DeviceOptionSet.iPad6.name {
                return .iPad6
            }
            else if model == DeviceOptionSet.iPad7.name {
                return .iPad7
            }
            else if model == DeviceOptionSet.iPad8.name {
                return .iPad8
            }
            else if model == DeviceOptionSet.iPad9.name {
                return .iPad9
            }
            else if model == DeviceOptionSet.iPad10.name {
                return .iPad10
            }
            else if model == DeviceOptionSet.iPad11.name {
                return .iPad11
            }
        }
        return .unrecognized
    }
}

#if canImport(UIKit)
import UIKit

extension UIDevice {
    func deviceName(id: String? = nil, dict: NSDictionary) -> String? {
        DeviceParser.deviceName(id: id, dict: dict)
    }
    func device(name: String?) -> DeviceOptionSet {
        DeviceParser.device(name: name)
    }
}
#endif
