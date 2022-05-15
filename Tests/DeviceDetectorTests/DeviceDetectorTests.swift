import XCTest
@testable import DeviceDetector

final class DeviceDetectorTests: XCTestCase {
    private var devicesDict: NSDictionary!
    
    override func setUp() async throws {
        let resourcePath = Bundle.module.path(forResource: "Device", ofType: "plist")
        devicesDict = NSDictionary(
            contentsOfFile: resourcePath ?? ""
        )
    }
    
    func test_all_devices_from_plist() throws {
        devicesDict.allKeys.compactMap { $0 as? String }.forEach {
            XCTAssertNotEqual(DeviceDetector.shared.device(id: $0), .unrecognized)
        }
    }
    
    func test_simulator() throws {
        let simulator = ["x86_64", "i386", "arm64"]
        simulator.forEach {
            let device = DeviceDetector.shared.device(id: $0)
            XCTAssertNotEqual(device, .unrecognized, "Simulator should be detected device")
        }
    }
    
    func test_iPod() throws {
        let iPod7th = "iPod9,1"
        let device = DeviceDetector.shared.device(id: iPod7th)
        XCTAssertEqual(device, .iPod)
    }
    
    func test_iPhoneSE() throws {
        let iPhoneSE1 = "iPhone8,4"
        let iPhoneSE2 = "iPhone12,8"
        let iPhoneSE3 = "iPhone14,6"
        
        let iPhoneSE1Device = DeviceDetector.shared.device(id: iPhoneSE1)
        XCTAssertEqual(iPhoneSE1Device, .iPhoneSE1)
        XCTAssertTrue(DeviceSet.iPhoneSet.contains(iPhoneSE1Device), "iPhone SE (1st generation) should be of iPhone")
        XCTAssertTrue(DeviceSet.iPhoneSESet.contains(iPhoneSE1Device), "iPhone SE (1st generation) should be of iPhoneSE")
        
        let iPhoneSE2Device = DeviceDetector.shared.device(id: iPhoneSE2)
        XCTAssertEqual(iPhoneSE2Device, .iPhoneSE2)
        XCTAssertTrue(DeviceSet.iPhoneSet.contains(iPhoneSE2Device), "iPhone SE (2nd generation) should be of iPhone")
        XCTAssertTrue(DeviceSet.iPhoneSESet.contains(iPhoneSE2Device), "iPhone SE (2nd generation) should be of iPhoneSE")
        
        let iPhoneSE3Device = DeviceDetector.shared.device(id: iPhoneSE3)
        XCTAssertEqual(iPhoneSE3Device, .iPhoneSE3)
        XCTAssertTrue(DeviceSet.iPhoneSet.contains(iPhoneSE3Device), "iPhone SE (3rd generation) should be of iPhone")
        XCTAssertTrue(DeviceSet.iPhoneSESet.contains(iPhoneSE3Device), "iPhone SE (3rd generation) should be of iPhoneSE")
    }
    
    func test_iPhone6() throws {
        let iPhone6 = "iPhone8,1"
        let iPhone6Plus = "iPhone8,2"
        
        let iPhone6Device = DeviceDetector.shared.device(id: iPhone6)
        XCTAssertEqual(iPhone6Device, .iPhone6)
        XCTAssertTrue(DeviceSet.iPhoneSet.contains(iPhone6Device), "iPhone 6 should be of iPhone")
        
        let iPhone6PlusDevice = DeviceDetector.shared.device(id: iPhone6Plus)
        XCTAssertEqual(iPhone6PlusDevice, .iPhone6Plus)
        XCTAssertTrue(DeviceSet.iPhoneSet.contains(iPhone6PlusDevice), "iPhone 6 Plus should be of iPhone")
    }
    
    func test_iPhone7() throws {
        let iPhone7 = ["iPhone9,1", "iPhone9,3"]
        let iPhone7Plus = ["iPhone9,2", "iPhone9,4"]
        iPhone7.forEach {
            let device = DeviceDetector.shared.device(id: $0)
            XCTAssertEqual(device, .iPhone7)
            XCTAssertTrue(DeviceSet.iPhoneSet.contains(device), "iPhone 7 should be of iPhone")
        }
        iPhone7Plus.forEach {
            let device = DeviceDetector.shared.device(id: $0)
            XCTAssertEqual(device, .iPhone7Plus)
            XCTAssertTrue(DeviceSet.iPhoneSet.contains(device), "iPhone 7 Plus should be of iPhone")
        }
    }
    
    func test_iPhone8() throws {
        let iPhone8 = ["iPhone10,1", "iPhone10,4"]
        let iPhone8Plus = ["iPhone10,2", "iPhone10,5"]
        iPhone8.forEach {
            let device = DeviceDetector.shared.device(id: $0)
            XCTAssertEqual(device, .iPhone8)
            XCTAssertTrue(DeviceSet.iPhoneSet.contains(device), "iPhone 8 should be of iPhone")
        }
        iPhone8Plus.forEach {
            let device = DeviceDetector.shared.device(id: $0)
            XCTAssertEqual(device, .iPhone8Plus)
            XCTAssertTrue(DeviceSet.iPhoneSet.contains(device), "iPhone 8 Plus should be of iPhone")
        }
    }
    
    func test_iPhoneX() throws {
        let iPhoneX = ["iPhone10,3", "iPhone10,6"]
        let iPhoneXS = "iPhone11,2"
        let iPhoneXSMax = ["iPhone11,4", "iPhone11,6"]
        let iPhoneXR = "iPhone11,8"
        
        iPhoneX.forEach {
            let device = DeviceDetector.shared.device(id: $0)
            XCTAssertEqual(device, .iPhoneX)
            XCTAssertTrue(DeviceSet.iPhoneSet.contains(device), "iPhone X should be of iPhone")
        }
        
        let iPhoneXSDevice = DeviceDetector.shared.device(id: iPhoneXS)
        XCTAssertEqual(iPhoneXSDevice, .iPhoneX)
        XCTAssertTrue(DeviceSet.iPhoneSet.contains(iPhoneXSDevice), "iPhone XS should be of iPhone")
        
        iPhoneXSMax.forEach {
            let device = DeviceDetector.shared.device(id: $0)
            XCTAssertEqual(device, .iPhoneXMax)
            XCTAssertTrue(DeviceSet.iPhoneSet.contains(device), "iPhone XS Max should be of iPhone")
        }
        
        let iPhoneXRDevice = DeviceDetector.shared.device(id: iPhoneXR)
        XCTAssertEqual(iPhoneXRDevice, .iPhoneXR)
        XCTAssertTrue(DeviceSet.iPhoneSet.contains(iPhoneXRDevice), "iPhone XR should be of iPhone")
    }
    
    
    
    func test_iPhone4_7inch() throws {
        let iPhone6 = "iPhone8,1"
        let iPhone7 = ["iPhone9,1", "iPhone9,3"]
        let iPhone8 = ["iPhone10,1", "iPhone10,4"]
        let iPhoneSE2nd = "iPhone12,8"
        let iPhoneSE3rd = "iPhone14,6"
        
        let iPhone6Device = DeviceDetector.shared.device(id: iPhone6)
        XCTAssertEqual(iPhone6Device, .iPhone6)
        XCTAssertTrue(DeviceSet.iPhone4_7inchSet.contains(iPhone6Device), "iPhone6 should be of iPhone4.7")
        
    }
    
    func test_iPad() throws {
        let iPad5th = ["iPad6,11", "iPad6,12"]
        let iPad6th = ["iPad7,5", "iPad7,6"]
        let iPad7th = ["iPad7,11", "iPad7,12"]
        let iPad8th = ["iPad11,6", "iPad11,7"]
        let iPad9th = ["iPad12,1", "iPad12,1"]
        
        iPad5th.forEach {
            let device = DeviceDetector.shared.device(id: $0)
            XCTAssertEqual(device, .iPad5)
            XCTAssertTrue(DeviceSet.iPad.contains(device), "iPad (5th generation) should be of iPad")
        }
        iPad6th.forEach {
            let device = DeviceDetector.shared.device(id: $0)
            XCTAssertEqual(device, .iPad6)
            XCTAssertTrue(DeviceSet.iPad.contains(device), "iPad (6th generation) should be of iPad")
        }
        iPad7th.forEach {
            let device = DeviceDetector.shared.device(id: $0)
            XCTAssertEqual(device, .iPad7)
            XCTAssertTrue(DeviceSet.iPad.contains(device), "iPad (7th generation) should be of iPad")
        }
        iPad8th.forEach {
            let device = DeviceDetector.shared.device(id: $0)
            XCTAssertEqual(device, .iPad8)
            XCTAssertTrue(DeviceSet.iPad.contains(device), "iPad (8th generation) should be of iPad")
        }
        iPad9th.forEach {
            let device = DeviceDetector.shared.device(id: $0)
            XCTAssertEqual(device, .iPad9)
            XCTAssertTrue(DeviceSet.iPad.contains(device), "iPad (9th generation) should be of iPad")
        }
    }
    
    func test_iPadAir() throws {
        let iPadAir2 = ["iPad5,3", "iPad5,4"]
        let iPadAir3rd = ["iPad11,3", "iPad11,4"]
        let iPadAir4th = ["iPad13,1", "iPad13,2"]
        let iPadAir5th = ["iPad13,16", "iPad13,17"]
        
        iPadAir2.forEach {
            let device = DeviceDetector.shared.device(id: $0)
            XCTAssertEqual(device, .iPadAir)
            XCTAssertTrue(DeviceSet.iPad.contains(device), "iPad Air 2 should be of iPad")
        }
        iPadAir3rd.forEach {
            let device = DeviceDetector.shared.device(id: $0)
            XCTAssertEqual(device, .iPadAir)
            XCTAssertTrue(DeviceSet.iPad.contains(device), "iPad Air (3rd generation) should be of iPad")
        }
        iPadAir4th.forEach {
            let device = DeviceDetector.shared.device(id: $0)
            XCTAssertEqual(device, .iPadAir)
            XCTAssertTrue(DeviceSet.iPad.contains(device), "iPad Air (4th generation) should be of iPad")
        }
        iPadAir5th.forEach {
            let device = DeviceDetector.shared.device(id: $0)
            XCTAssertEqual(device, .iPadAir)
            XCTAssertTrue(DeviceSet.iPad.contains(device), "iPad Air (5th generation) should be of iPad")
        }
    }
    
    func test_iPadMini() throws {
        let iPadMini4 = ["iPad5,1", "iPad5,2"]
        let iPadMini5th = ["iPad11,1", "iPad11,2"]
        let iPadMini6th = ["iPad14,1", "iPad14,2"]
        
        iPadMini4.forEach {
            let device = DeviceDetector.shared.device(id: $0)
            XCTAssertEqual(device, .iPadMini)
            XCTAssertTrue(DeviceSet.iPad.contains(device), "iPad mini 4 should be of iPad")
        }
        iPadMini5th.forEach {
            let device = DeviceDetector.shared.device(id: $0)
            XCTAssertEqual(device, .iPadMini)
            XCTAssertTrue(DeviceSet.iPad.contains(device), "iPad mini (4th generation) should be of iPad")
        }
        iPadMini6th.forEach {
            let device = DeviceDetector.shared.device(id: $0)
            XCTAssertEqual(device, .iPadMini)
            XCTAssertTrue(DeviceSet.iPad.contains(device), "iPad mini (6th generation) should be of iPad")
        }
    }
    
    func test_iPadPro9_7inch() throws {
        let iPadPro9_7inch = ["iPad6,3", "iPad6,4"]
        iPadPro9_7inch.forEach {
            let device = DeviceDetector.shared.device(id: $0)
            XCTAssertEqual(device, .iPadPro9_7inch)
            XCTAssertTrue(DeviceSet.iPadPro.contains(device), "iPad Pro (9.7-inch) should be of iPad Pro")
            XCTAssertTrue(DeviceSet.iPad.contains(device), "iPad Pro (9.7-inch) should be of iPad")
        }
    }
    
    func test_iPadPro10_5inch() throws {
        let iPadPro10_5inch = ["iPad7,3", "iPad7,4"]
        iPadPro10_5inch.forEach {
            let device = DeviceDetector.shared.device(id: $0)
            XCTAssertEqual(device, .iPadPro10_5inch)
            XCTAssertTrue(DeviceSet.iPadPro.contains(device), "iPad Pro (10.5-inch) should be of iPad Pro")
            XCTAssertTrue(DeviceSet.iPad.contains(device), "iPad Pro (10.5-inch) should be of iPad")
        }
    }
    
    func test_iPadPro11inch() throws {
        let iPadPro11inch = ["iPad8,1", "iPad8,2", "iPad8,3", "iPad8,4"]
        let iPadPro11inch2nd = ["iPad8,9", "iPad8,10"]
        let iPadPro11inch3rd = ["iPad13,4", "iPad13,5", "iPad13,6", "iPad13,7"]
        
        iPadPro11inch.forEach {
            let device = DeviceDetector.shared.device(id: $0)
            XCTAssertEqual(device, .iPadPro11inch)
            XCTAssertTrue(DeviceSet.iPadPro.contains(device), "iPad Pro (11-inch) should be of iPad Pro")
            XCTAssertTrue(DeviceSet.iPad.contains(device), "iPad Pro (11-inch) should be of iPad")
        }
        
        iPadPro11inch2nd.forEach {
            let device = DeviceDetector.shared.device(id: $0)
            XCTAssertEqual(device, .iPadPro11inch)
            XCTAssertTrue(DeviceSet.iPadPro.contains(device), "iPad Pro (11-inch)(2nd generation) should be of iPad Pro")
            XCTAssertTrue(DeviceSet.iPad.contains(device), "iPad Pro (11-inch)(2nd generation) should be of iPad")
        }
        
        iPadPro11inch3rd.forEach {
            let device = DeviceDetector.shared.device(id: $0)
            XCTAssertEqual(device, .iPadPro11inch)
            XCTAssertTrue(DeviceSet.iPadPro.contains(device), "iPad Pro (11-inch)(3rd generation) should be of iPad Pro")
            XCTAssertTrue(DeviceSet.iPad.contains(device), "iPad Pro (11-inch)(3rd generation) should be of iPad")
        }
    }
    
    func test_iPadPro12_9inch() throws {
        let iPadPro12_9inch = ["iPad6,7", "iPad6,8"]
        let iPadPro12_9inch2nd = ["iPad7,1", "iPad7,2"]
        let iPadPro12_9inch3rd = ["iPad8,5", "iPad8,6", "iPad8,7", "iPad8,8"]
        let iPadPro12_9inch4th = ["iPad8,11", "iPad8,12"]
        let iPadPro12_9inch5th = ["iPad13,8", "iPad13,9", "iPad13,10", "iPad13,11"]
        
        iPadPro12_9inch.forEach {
            let device = DeviceDetector.shared.device(id: $0)
            XCTAssertEqual(device, .iPadPro12_9inch)
            XCTAssertTrue(DeviceSet.iPadPro.contains(device), "iPad Pro (12.9-inch) should be of iPad Pro")
            XCTAssertTrue(DeviceSet.iPad.contains(device), "iPad Pro (12.9-inch) should be of iPad")
        }
        
        iPadPro12_9inch2nd.forEach {
            let device = DeviceDetector.shared.device(id: $0)
            XCTAssertEqual(device, .iPadPro12_9inch)
            XCTAssertTrue(DeviceSet.iPadPro.contains(device), "iPad Pro (12.9-inch)(2nd generation) should be of iPad Pro")
            XCTAssertTrue(DeviceSet.iPad.contains(device), "iPad Pro (12.9-inch)(2nd generation) should be of iPad")
        }
        
        iPadPro12_9inch3rd.forEach {
            let device = DeviceDetector.shared.device(id: $0)
            XCTAssertEqual(device, .iPadPro12_9inch)
            XCTAssertTrue(DeviceSet.iPadPro.contains(device), "iPad Pro (12.9-inch)(3rd generation) should be of iPad Pro")
            XCTAssertTrue(DeviceSet.iPad.contains(device), "iPad Pro (12.9-inch)(3rd generation) should be of iPad")
        }
        
        iPadPro12_9inch4th.forEach {
            let device = DeviceDetector.shared.device(id: $0)
            XCTAssertEqual(device, .iPadPro12_9inch)
            XCTAssertTrue(DeviceSet.iPadPro.contains(device), "iPad Pro (12.9-inch)(4th generation) should be of iPad Pro")
            XCTAssertTrue(DeviceSet.iPad.contains(device), "iPad Pro (12.9-inch)(4th generation) should be of iPad")
        }
        
        iPadPro12_9inch5th.forEach {
            let device = DeviceDetector.shared.device(id: $0)
            XCTAssertEqual(device, .iPadPro12_9inch)
            XCTAssertTrue(DeviceSet.iPadPro.contains(device), "iPad Pro (12.9-inch)(5th generation) should be of iPad Pro")
            XCTAssertTrue(DeviceSet.iPad.contains(device), "iPad Pro (12.9-inch)(5th generation) should be of iPad")
        }
    }
}
