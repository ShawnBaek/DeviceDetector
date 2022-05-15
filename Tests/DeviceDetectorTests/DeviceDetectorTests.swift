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
}
