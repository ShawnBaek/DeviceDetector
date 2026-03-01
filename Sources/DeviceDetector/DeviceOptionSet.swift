//
//  File.swift
//  
//
//  Created by Sungwook Baek on 2022/05/14.
//

import Foundation

//https://www.theiphonewiki.com/wiki/Models

public struct DeviceOptionSet: OptionSet {
    public let rawValue: Int
    public static let unrecognized   = DeviceOptionSet(rawValue: 1 << 0)
    
    //MARK: iPhone
    public static let iPhone6S = DeviceOptionSet(rawValue: 1 << 1)
    public static let iPhone6SPlus = DeviceOptionSet(rawValue: 1 << 2)
    public static let iPhone7 = DeviceOptionSet(rawValue: 1 << 3)
    public static let iPhone7Plus = DeviceOptionSet(rawValue: 1 << 4)
    public static let iPhone8 = DeviceOptionSet(rawValue: 1 << 5)
    public static let iPhone8Plus = DeviceOptionSet(rawValue: 1 << 6)
    
    public static let iPhoneX = DeviceOptionSet(rawValue: 1 << 7)
    public static let iPhoneXS = DeviceOptionSet(rawValue: 1 << 8)
    public static let iPhoneXR = DeviceOptionSet(rawValue: 1 << 9)
    public static let iPhoneXSMax = DeviceOptionSet(rawValue: 1 << 10)
    
    public static let iPhone11 = DeviceOptionSet(rawValue: 1 << 11)
    public static let iPhone12 = DeviceOptionSet(rawValue: 1 << 12)
    public static let iPhone13 = DeviceOptionSet(rawValue: 1 << 13)
    
    public static let iPhoneSE1 = DeviceOptionSet(rawValue: 1 << 14)
    public static let iPhoneSE2 = DeviceOptionSet(rawValue: 1 << 15)
    public static let iPhoneSE3 = DeviceOptionSet(rawValue: 1 << 16)
    
    public static let iPhoneMini = DeviceOptionSet(rawValue: 1 << 17)
    public static let iPhonePro = DeviceOptionSet(rawValue: 1 << 18)
    public static let iPhoneProMax = DeviceOptionSet(rawValue: 1 << 19)
    
    public static let iPhone14 = DeviceOptionSet(rawValue: 1 << 20)
    public static let iPhone14Plus = DeviceOptionSet(rawValue: 1 << 21)
    public static let iPhone14Pro = DeviceOptionSet(rawValue: 1 << 22)
    public static let iPhone14ProMax = DeviceOptionSet(rawValue: 1 << 23)
    
    public static let iPhone15 = DeviceOptionSet(rawValue: 1 << 24)
    public static let iPhone15Plus = DeviceOptionSet(rawValue: 1 << 25)
    public static let iPhone15Pro = DeviceOptionSet(rawValue: 1 << 26)
    public static let iPhone15ProMax = DeviceOptionSet(rawValue: 1 << 27)
    
    public static let iPhone16 = DeviceOptionSet(rawValue: 1 << 28)
    public static let iPhone16Plus = DeviceOptionSet(rawValue: 1 << 29)
    public static let iPhone16Pro = DeviceOptionSet(rawValue: 1 << 30)
    public static let iPhone16ProMax = DeviceOptionSet(rawValue: 1 << 31)
    public static let iPhone16E = DeviceOptionSet(rawValue: 1 << 32)
    
    public static let iPhone17 = DeviceOptionSet(rawValue: 1 << 33)
    public static let iPhone17Pro = DeviceOptionSet(rawValue: 1 << 34)
    public static let iPhone17ProMax = DeviceOptionSet(rawValue: 1 << 35)
    public static let iPhoneAir = DeviceOptionSet(rawValue: 1 << 36)
    
    public static let iPhoneSESet: DeviceOptionSet = [.iPhoneSE1, .iPhoneSE2, .iPhoneSE3]
    public static let iPhonePlusSet: DeviceOptionSet = [.iPhone6SPlus, .iPhone7Plus, .iPhone8Plus]
    public static let iPhone4_7inchSet: DeviceOptionSet = [.iPhoneSE2, .iPhoneSE3, .iPhone6S, .iPhone7, .iPhone8]
    public static let iPhone4inchSet: DeviceOptionSet = [.iPhoneSE1]
    public static let iPhoneSet: DeviceOptionSet = [
        .iPhoneSESet, .iPhonePlusSet, .iPhone4_7inchSet, .iPhone4inchSet,
        .iPhoneX, .iPhoneXS, .iPhoneXR, .iPhoneXSMax,
        .iPhone11, .iPhone12, .iPhone13, .iPhoneMini, .iPhonePro, .iPhoneProMax,
        .iPhone14, .iPhone14Plus, .iPhone14Pro, .iPhone14ProMax,
        .iPhone15, .iPhone15Plus, .iPhone15Pro, .iPhone15ProMax,
        .iPhone16, .iPhone16Plus, .iPhone16Pro, .iPhone16ProMax, .iPhone16E,
        .iPhone17, .iPhone17Pro, .iPhone17ProMax, .iPhoneAir
    ]
    public static let iPhoneSafeAreaSet: DeviceOptionSet = iPhoneSet.subtracting(iPhone4inchSet).subtracting(iPhone4_7inchSet).subtracting(iPhonePlusSet)
    
    //MARK: iPad
    public static let iPad5    = DeviceOptionSet(rawValue: 1 << 50)
    public static let iPad6    = DeviceOptionSet(rawValue: 1 << 51)
    public static let iPad7    = DeviceOptionSet(rawValue: 1 << 52)
    public static let iPad8    = DeviceOptionSet(rawValue: 1 << 53)
    public static let iPad9    = DeviceOptionSet(rawValue: 1 << 54)
    
    public static let iPadMini  = DeviceOptionSet(rawValue: 1 << 55)
    public static let iPadAir = DeviceOptionSet(rawValue: 1 << 56)
    
    public static let iPadPro9_7inch = DeviceOptionSet(rawValue: 1 << 57)
    public static let iPadPro10_5inch = DeviceOptionSet(rawValue: 1 << 58)
    public static let iPadPro11inch   = DeviceOptionSet(rawValue: 1 << 59)
    public static let iPadPro12_9inch   = DeviceOptionSet(rawValue: 1 << 60)
    public static let iPadPro13inch    = DeviceOptionSet(rawValue: 1 << 61)
    public static let iPad10           = DeviceOptionSet(rawValue: 1 << 62)
    public static let iPad11           = DeviceOptionSet(rawValue: 1 << 63)

    public static let iPadProSet: DeviceOptionSet = [.iPadPro9_7inch, .iPadPro10_5inch, .iPadPro11inch, .iPadPro12_9inch, .iPadPro13inch]
    public static let iPadSet: DeviceOptionSet = [.iPad5, .iPad6, .iPad7, .iPad8, .iPad9, .iPad10, .iPad11, .iPadAir, .iPadMini, .iPadProSet]
    
    //MARK: iPod
    public static let iPod = DeviceOptionSet(rawValue: 1<<80)
    
    public init(rawValue: Int) {
        self.rawValue = rawValue
    }
    
    var name: String {
        switch self {
        case .iPhoneSet:
            return "iPhone"
        case .iPhone6S:
            return "iPhone 6S"
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
        case .iPhoneSESet:
            return "iPhone SE"
        case .iPhoneSE1:
            return "iPhone SE (1st generation)"
        case .iPhoneSE2:
            return "iPhone SE (2nd generation)"
        case .iPhoneSE3:
            return "iPhone SE (3rd generation)"
        case .iPadSet:
            return "iPad"
        case .iPad5:
            return "iPad (5th generation)"
        case .iPad6:
            return "iPad (6th generation)"
        case .iPad7:
            return "iPad (7th generation)"
        case .iPad8:
            return "iPad (8th generation)"
        case .iPad9:
            return "iPad (9th generation)"
        case .iPad10:
            return "iPad (10th generation)"
        case .iPad11:
            return "iPad (11th generation)"
        case .iPhone14:
            return "iPhone 14"
        case .iPhone14Plus:
            return "iPhone 14 Plus"
        case .iPhone14Pro:
            return "iPhone 14 Pro"
        case .iPhone14ProMax:
            return "iPhone 14 Pro Max"
        case .iPhone15:
            return "iPhone 15"
        case .iPhone15Plus:
            return "iPhone 15 Plus"
        case .iPhone15Pro:
            return "iPhone 15 Pro"
        case .iPhone15ProMax:
            return "iPhone 15 Pro Max"
        case .iPhone16:
            return "iPhone 16"
        case .iPhone16Plus:
            return "iPhone 16 Plus"
        case .iPhone16Pro:
            return "iPhone 16 Pro"
        case .iPhone16ProMax:
            return "iPhone 16 Pro Max"
        case .iPhone16E:
            return "iPhone 16e"
        case .iPhone17:
            return "iPhone 17"
        case .iPhone17Pro:
            return "iPhone 17 Pro"
        case .iPhone17ProMax:
            return "iPhone 17 Pro Max"
        case .iPhoneAir:
            return "iPhone Air"
        case .iPadPro13inch:
            return "iPad Pro (13-inch)"
        case .iPod:
            return "iPod"
        default:
            return ""
        }
    }
}
