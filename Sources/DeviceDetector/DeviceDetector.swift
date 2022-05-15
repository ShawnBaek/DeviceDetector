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
    public static let shared = DeviceDetector()
    public let currentDevice: DeviceSet
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
        currentDevice = UIDevice.current.device(dict: deviceDict)
        isiPad = DeviceSet.iPadSet.contains(currentDevice)
        isiPhone = DeviceSet.iPhoneSet.contains(currentDevice)
        if isiPhone, DeviceSet.iPhoneSafeAreaSet.contains(currentDevice) {
            hasSafeArea = true
        }
        else {
            hasSafeArea = false
        }
    }
    
    public func device(id: String) -> DeviceSet {
        UIDevice.current.device(id: id, dict: deviceDict)
    }
}
