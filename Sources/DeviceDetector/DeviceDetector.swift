//
//  DeviceDetector.swift
//  DeviceDetector
//
//  Created by BaekSungwook on 5/14/22.
//  Copyright © 2022 BaekSungwook. All rights reserved.
//
import Foundation
#if canImport(UIKit)
import UIKit
#endif

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
        #if canImport(UIKit)
        deviceName = UIDevice.current.deviceName(id: identifier, dict: deviceDict) ?? ""
        device = UIDevice.current.device(name: deviceName)
        #else
        deviceName = DeviceParser.deviceName(id: identifier, dict: deviceDict) ?? ""
        device = DeviceParser.device(name: deviceName)
        #endif
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
