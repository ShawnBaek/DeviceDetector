//
//  File.swift
//  
//
//  Created by Sungwook Baek on 2022/05/14.
//

import Foundation

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
    
    static let iPhoneSESet: DeviceSet = [.iPhoneSE1, .iPhoneSE2, .iPhoneSE3]
    static let iPhonePlusSet: DeviceSet = [.iPhone6Plus, .iPhone7Plus, .iPhone8Plus]
    static let iPhone4_7inchSet: DeviceSet = [.iPhoneSE2, .iPhoneSE3, .iPhone6, .iPhone7, .iPhone8]
    static let iPhone4inchSet: DeviceSet = [.iPhoneSE1]
    static let iPhoneSet: DeviceSet = [.iPhoneSESet, .iPhonePlusSet, .iPhone4_7inchSet, .iPhone4inchSet, .iPhoneX, .iPhoneXR, .iPhoneXMax, .iPhone11, .iPhone12, .iPhone13, .iPhoneMini, .iPhonePro, .iPhoneProMax]
    
    //MARK: iPad
    static let iPad5    = DeviceSet(rawValue: 1 << 50)
    static let iPad6    = DeviceSet(rawValue: 1 << 51)
    static let iPad7    = DeviceSet(rawValue: 1 << 52)
    static let iPad8    = DeviceSet(rawValue: 1 << 53)
    static let iPad9    = DeviceSet(rawValue: 1 << 54)
    
    static let iPadMini  = DeviceSet(rawValue: 1 << 55)
    static let iPadAir = DeviceSet(rawValue: 1 << 56)
    
    static let iPadPro9_7inch = DeviceSet(rawValue: 1 << 57)
    static let iPadPro10_5inch = DeviceSet(rawValue: 1 << 58)
    static let iPadPro11inch   = DeviceSet(rawValue: 1 << 59)
    static let iPadPro12_9inch   = DeviceSet(rawValue: 1 << 60)
    
    static let iPadPro: DeviceSet = [.iPadPro9_7inch, .iPadPro10_5inch, .iPadPro11inch, .iPadPro12_9inch]
    static let iPad: DeviceSet = [.iPad5, .iPad6, .iPad7, .iPad8, .iPad9, .iPadAir, .iPadMini, .iPadPro]
    
    //MARK: iPod
    static let iPod = DeviceSet(rawValue: 1<<80)
    
    public init(rawValue: Int) {
        self.rawValue = rawValue
    }
    
    var name: String {
        switch self {
        case .iPhoneSet:
            return "iPhone"
        case .iPhone6:
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
        case .iPad:
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
