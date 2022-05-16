//
//  DeviceDetector.swift
//  DeviceDetector
//
//  Created by BaekSungwook on 5/14/22.
//  Copyright © 2022 BaekSungwook. All rights reserved.
//
import Foundation
import UIKit

public final class DeviceDetector {
    public static let current = DeviceDetector()
    public let deviceSet: DeviceSet
    public let deviceName: String
    public let isiPad: Bool
    public let isiPhone: Bool
    public let hasSafeArea: Bool
    private let deviceDict: NSDictionary
    private init() {
        if let appleDevices = Bundle.module.path(forResource: "Device", ofType: "plist"),
           let dict = NSDictionary(contentsOfFile: appleDevices) {
            deviceDict = dict
        }
        else {
            deviceDict = [:]
        }
        deviceName = UIDevice.current.deviceName(dict: deviceDict) ?? ""
        deviceSet = UIDevice.current.device(name: deviceName)
        isiPad = deviceSet.isSubset(of: .iPadSet)
        isiPhone = deviceSet.isSubset(of: .iPhoneSet)
        if isiPhone, deviceSet.isSubset(of: .iPhoneSafeAreaSet) {
            hasSafeArea = true
        }
        else {
            hasSafeArea = false
        }
    }
    
    public func device(id: String) -> DeviceSet {
        guard let deviceName = UIDevice.current.deviceName(id: id, dict: deviceDict) else {
            return .unrecognized
        }
        return UIDevice.current.device(name: deviceName)
    }
}
