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
    
    public static let iPhoneSESet: DeviceOptionSet = [.iPhoneSE1, .iPhoneSE2, .iPhoneSE3]
    public static let iPhonePlusSet: DeviceOptionSet = [.iPhone6SPlus, .iPhone7Plus, .iPhone8Plus]
    public static let iPhone4_7inchSet: DeviceOptionSet = [.iPhoneSE2, .iPhoneSE3, .iPhone6S, .iPhone7, .iPhone8]
    public static let iPhone4inchSet: DeviceOptionSet = [.iPhoneSE1]
    public static let iPhoneSet: DeviceOptionSet = [.iPhoneSESet, .iPhonePlusSet, .iPhone4_7inchSet, .iPhone4inchSet, .iPhoneX, .iPhoneXS, .iPhoneXR, .iPhoneXSMax, .iPhone11, .iPhone12, .iPhone13, .iPhoneMini, .iPhonePro, .iPhoneProMax]
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
    
    public static let iPadProSet: DeviceOptionSet = [.iPadPro9_7inch, .iPadPro10_5inch, .iPadPro11inch, .iPadPro12_9inch]
    public static let iPadSet: DeviceOptionSet = [.iPad5, .iPad6, .iPad7, .iPad8, .iPad9, .iPadAir, .iPadMini, .iPadProSet]
    
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
        case .iPod:
            return "iPod"
        default:
            return ""
        }
    }
}
