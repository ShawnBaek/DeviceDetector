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
            XCTAssertNotEqual(DeviceDetector(id: $0)?.device, .unrecognized)
        }
    }
    
    func test_simulator() throws {
        let simulator = ["x86_64", "i386", "arm64"]
        simulator.forEach {
            let device = DeviceDetector(id: $0)?.device
            XCTAssertNotEqual(device, .unrecognized, "Simulator should be detected device")
        }
    }
    
    func test_iPod() throws {
        let iPod7th = "iPod9,1"
        let device = DeviceDetector(id: iPod7th)?.device
        XCTAssertEqual(device, .iPod)
    }
    
    func test_iPhoneSE() throws {
        let iPhoneSE1 = "iPhone8,4"
        let iPhoneSE2 = "iPhone12,8"
        let iPhoneSE3 = "iPhone14,6"
        
        let iPhoneSE1Device = DeviceDetector(id: iPhoneSE1)!.device
        XCTAssertEqual(iPhoneSE1Device, .iPhoneSE1)
        XCTAssertTrue(DeviceOptionSet.iPhoneSet.contains(iPhoneSE1Device), "iPhone SE (1st generation) should be of iPhone")
        XCTAssertTrue(DeviceOptionSet.iPhoneSESet.contains(iPhoneSE1Device), "iPhone SE (1st generation) should be of iPhoneSE")
        
        let iPhoneSE2Device = DeviceDetector(id: iPhoneSE2)!.device
        XCTAssertEqual(iPhoneSE2Device, .iPhoneSE2)
        XCTAssertTrue(DeviceOptionSet.iPhoneSet.contains(iPhoneSE2Device), "iPhone SE (2nd generation) should be of iPhone")
        XCTAssertTrue(DeviceOptionSet.iPhoneSESet.contains(iPhoneSE2Device), "iPhone SE (2nd generation) should be of iPhoneSE")
        
        let iPhoneSE3Device = DeviceDetector(id: iPhoneSE3)!.device
        XCTAssertEqual(iPhoneSE3Device, .iPhoneSE3)
        XCTAssertTrue(DeviceOptionSet.iPhoneSet.contains(iPhoneSE3Device), "iPhone SE (3rd generation) should be of iPhone")
        XCTAssertTrue(DeviceOptionSet.iPhoneSESet.contains(iPhoneSE3Device), "iPhone SE (3rd generation) should be of iPhoneSE")
    }
    
    func test_iPhone6() throws {
        let iPhone6 = "iPhone8,1"
        let iPhone6Plus = "iPhone8,2"
        
        let iPhone6Device = DeviceDetector(id: iPhone6)!.device
        XCTAssertEqual(iPhone6Device, .iPhone6S)
        XCTAssertTrue(DeviceOptionSet.iPhoneSet.contains(iPhone6Device), "iPhone 6 should be of iPhone")
        
        let iPhone6PlusDevice = DeviceDetector(id: iPhone6Plus)!.device
        XCTAssertEqual(iPhone6PlusDevice, .iPhone6SPlus)
        XCTAssertTrue(DeviceOptionSet.iPhoneSet.contains(iPhone6PlusDevice), "iPhone 6 Plus should be of iPhone")
    }
    
    func test_iPhone7() throws {
        let iPhone7 = ["iPhone9,1", "iPhone9,3"]
        let iPhone7Plus = ["iPhone9,2", "iPhone9,4"]
        iPhone7.forEach {
            let device = DeviceDetector(id: $0)!.device
            XCTAssertEqual(device, .iPhone7)
            XCTAssertTrue(DeviceOptionSet.iPhoneSet.contains(device), "iPhone 7 should be of iPhone")
        }
        iPhone7Plus.forEach {
            let device = DeviceDetector(id: $0)!.device
            XCTAssertEqual(device, .iPhone7Plus)
            XCTAssertTrue(DeviceOptionSet.iPhoneSet.contains(device), "iPhone 7 Plus should be of iPhone")
        }
    }
    
    func test_iPhone8() throws {
        let iPhone8 = ["iPhone10,1", "iPhone10,4"]
        let iPhone8Plus = ["iPhone10,2", "iPhone10,5"]
        iPhone8.forEach {
            let device = DeviceDetector(id: $0)!.device
            XCTAssertEqual(device, .iPhone8)
            XCTAssertTrue(DeviceOptionSet.iPhoneSet.contains(device), "iPhone 8 should be of iPhone")
        }
        iPhone8Plus.forEach {
            let device = DeviceDetector(id: $0)!.device
            XCTAssertEqual(device, .iPhone8Plus)
            XCTAssertTrue(DeviceOptionSet.iPhoneSet.contains(device), "iPhone 8 Plus should be of iPhone")
        }
    }
    
    func test_iPhoneX() throws {
        let iPhoneX = ["iPhone10,3", "iPhone10,6"]
        let iPhoneXS = "iPhone11,2"
        let iPhoneXSMax = ["iPhone11,4", "iPhone11,6"]
        let iPhoneXR = "iPhone11,8"
        
        iPhoneX.forEach {
            let device = DeviceDetector(id: $0)!.device
            XCTAssertEqual(device, .iPhoneX)
            XCTAssertTrue(DeviceOptionSet.iPhoneSet.contains(device), "iPhone X should be of iPhone")
        }
        
        let iPhoneXSDevice = DeviceDetector(id: iPhoneXS)!.device
        XCTAssertEqual(iPhoneXSDevice, .iPhoneXS)
        XCTAssertTrue(DeviceOptionSet.iPhoneSet.contains(iPhoneXSDevice), "iPhone XS should be of iPhone")
        
        iPhoneXSMax.forEach {
            let device = DeviceDetector(id: $0)!.device
            XCTAssertEqual(device, .iPhoneXSMax)
            XCTAssertTrue(DeviceOptionSet.iPhoneSet.contains(device), "iPhone XS Max should be of iPhone")
        }
        
        let iPhoneXRDevice = DeviceDetector(id: iPhoneXR)!.device
        XCTAssertEqual(iPhoneXRDevice, .iPhoneXR)
        XCTAssertTrue(DeviceOptionSet.iPhoneSet.contains(iPhoneXRDevice), "iPhone XR should be of iPhone")
    }
    
    func test_iPhone11() throws {
        let iPhone11 = "iPhone12,1"
        let iPhone11Pro = "iPhone12,3"
        let iPhone11ProMax = "iPhone12,5"
        
        let iPhone11Device = DeviceDetector(id: iPhone11)!.device
        XCTAssertEqual(iPhone11Device, .iPhone11)
        XCTAssertTrue(DeviceOptionSet.iPhoneSet.contains(iPhone11Device), "iPhone 11 should be of iPhone")
        
        let iPhone11ProDevice = DeviceDetector(id: iPhone11Pro)!.device
        XCTAssertEqual(iPhone11ProDevice, .iPhonePro)
        XCTAssertTrue(DeviceOptionSet.iPhoneSet.contains(iPhone11ProDevice), "iPhone 11 Pro should be of iPhone")
        
        let iPhone11ProMaxDevice = DeviceDetector(id: iPhone11ProMax)!.device
        XCTAssertEqual(iPhone11ProMaxDevice, .iPhoneProMax)
        XCTAssertTrue(DeviceOptionSet.iPhoneSet.contains(iPhone11ProMaxDevice), "iPhone 11 Pro Max should be of iPhone")
    }
    
    func test_iPhone12() throws {
        let iPhone12Mini = "iPhone13,1"
        let iPhone12 = "iPhone13,2"
        let iPhone12Pro = "iPhone13,3"
        let iPhone12ProMax = "iPhone13,4"
        
        let iPhone12MiniDevice = DeviceDetector(id: iPhone12Mini)!.device
        XCTAssertEqual(iPhone12MiniDevice, .iPhoneMini)
        XCTAssertTrue(DeviceOptionSet.iPhoneSet.contains(iPhone12MiniDevice), "iPhone 12 mini should be of iPhone")
        
        let iPhone12Device = DeviceDetector(id: iPhone12)!.device
        XCTAssertEqual(iPhone12Device, .iPhone12)
        XCTAssertTrue(DeviceOptionSet.iPhoneSet.contains(iPhone12Device), "iPhone 12 should be of iPhone")
        
        let iPhone12ProDevice = DeviceDetector(id: iPhone12Pro)!.device
        XCTAssertEqual(iPhone12ProDevice, .iPhonePro)
        XCTAssertTrue(DeviceOptionSet.iPhoneSet.contains(iPhone12ProDevice), "iPhone 12 Pro should be of iPhone")
        
        let iPhone12ProMaxDevice = DeviceDetector(id: iPhone12ProMax)!.device
        XCTAssertEqual(iPhone12ProMaxDevice, .iPhoneProMax)
        XCTAssertTrue(DeviceOptionSet.iPhoneSet.contains(iPhone12ProMaxDevice), "iPhone 12 Pro Max should be of iPhone")
    }
    
    func test_iPhone13() throws {
        let iPhone13Mini = "iPhone14,4"
        let iPhone13 = "iPhone14,5"
        let iPhone13Pro = "iPhone14,2"
        let iPhone13ProMax = "iPhone14,3"
        
        let iPhone13MiniDevice = DeviceDetector(id: iPhone13Mini)!.device
        XCTAssertEqual(iPhone13MiniDevice, .iPhoneMini)
        XCTAssertTrue(DeviceOptionSet.iPhoneSet.contains(iPhone13MiniDevice), "iPhone 13 mini should be of iPhone")
        
        let iPhone13Device = DeviceDetector(id: iPhone13)!.device
        XCTAssertEqual(iPhone13Device, .iPhone13)
        XCTAssertTrue(DeviceOptionSet.iPhoneSet.contains(iPhone13Device), "iPhone 13 should be of iPhone")
        
        let iPhone13ProDevice = DeviceDetector(id: iPhone13Pro)!.device
        XCTAssertEqual(iPhone13ProDevice, .iPhonePro)
        XCTAssertTrue(DeviceOptionSet.iPhoneSet.contains(iPhone13ProDevice), "iPhone 13 Pro should be of iPhone")
        
        let iPhone13ProMaxDevice = DeviceDetector(id: iPhone13ProMax)!.device
        XCTAssertEqual(iPhone13ProMaxDevice, .iPhoneProMax)
        XCTAssertTrue(DeviceOptionSet.iPhoneSet.contains(iPhone13ProMaxDevice), "iPhone 13 Pro Max should be of iPhone")
    }
    
    func test_iPhone4inch() throws {
        let iPhoneSE1 = "iPhone8,4"
        let iPhoneSE1Device = DeviceDetector(id: iPhoneSE1)!.device
        XCTAssertEqual(iPhoneSE1Device, .iPhoneSE1)
        XCTAssertTrue(DeviceOptionSet.iPhone4inchSet.contains(iPhoneSE1Device), "iPhone SE (1st generation) should be of iPhone 4inch")
    }
    
    func test_iPhone4_7inch() throws {
        let iPhone6S = "iPhone8,1"
        let iPhone7 = ["iPhone9,1", "iPhone9,3"]
        let iPhone8 = ["iPhone10,1", "iPhone10,4"]
        let iPhoneSE2nd = "iPhone12,8"
        let iPhoneSE3rd = "iPhone14,6"
        
        let iPhone6SDevice = DeviceDetector(id: iPhone6S)!.device
        XCTAssertEqual(iPhone6SDevice, .iPhone6S)
        XCTAssertTrue(DeviceOptionSet.iPhone4_7inchSet.contains(iPhone6SDevice), "iPhone 6 should be of iPhone4.7")
        
        iPhone7.forEach {
            let device = DeviceDetector(id: $0)!.device
            XCTAssertEqual(device, .iPhone7)
            XCTAssertTrue(DeviceOptionSet.iPhone4_7inchSet.contains(device), "iPhone 7 should be of iPhone4.7")
        }
        
        iPhone8.forEach {
            let device = DeviceDetector(id: $0)!.device
            XCTAssertEqual(device, .iPhone8)
            XCTAssertTrue(DeviceOptionSet.iPhone4_7inchSet.contains(device), "iPhone 8 should be of iPhone4.7")
        }
        
        [iPhoneSE2nd, iPhoneSE3rd].forEach {
            let device = DeviceDetector(id: $0)!.device
            XCTAssertTrue(DeviceOptionSet.iPhoneSESet.contains(device), "iPhone SE should be of iPhoneSE")
            XCTAssertTrue(DeviceOptionSet.iPhone4_7inchSet.contains(device), "iPhone 8 should be of iPhone4.7")
        }
    }
    
    func test_iPhonePlus() throws {
        let iPhone6Plus = ["iPhone8,2"]
        let iPhone7Plus = ["iPhone9,2", "iPhone9,4"]
        let iPhone8Plus = ["iPhone10,2", "iPhone10,5"]
        let iPhonePlus = [iPhone6Plus + iPhone7Plus + iPhone8Plus].flatMap { $0 }
        iPhonePlus.forEach {
            let device = DeviceDetector(id: $0)!.device
            XCTAssertTrue(DeviceOptionSet.iPhonePlusSet.contains(device), "iPhone Plus should be of iPhone Plus")
        }
    }
    
    func test_iPhone14() throws {
        let iPhone14 = ["iPhone14,7"]
        let iPhone14Plus = ["iPhone14,8"]
        let iPhone14Pro = ["iPhone15,2"]
        let iPhone14ProMax = ["iPhone15,3"]

        iPhone14.forEach {
            let device = DeviceDetector(id: $0)!.device
            XCTAssertEqual(device, .iPhone14)
            XCTAssertTrue(DeviceOptionSet.iPhoneSet.contains(device), "iPhone 14 should be of iPhone")
        }
        iPhone14Plus.forEach {
            let device = DeviceDetector(id: $0)!.device
            XCTAssertEqual(device, .iPhone14Plus)
            XCTAssertTrue(DeviceOptionSet.iPhoneSet.contains(device), "iPhone 14 Plus should be of iPhone")
        }
        iPhone14Pro.forEach {
            let device = DeviceDetector(id: $0)!.device
            XCTAssertEqual(device, .iPhone14Pro)
            XCTAssertTrue(DeviceOptionSet.iPhoneSet.contains(device), "iPhone 14 Pro should be of iPhone")
        }
        iPhone14ProMax.forEach {
            let device = DeviceDetector(id: $0)!.device
            XCTAssertEqual(device, .iPhone14ProMax)
            XCTAssertTrue(DeviceOptionSet.iPhoneSet.contains(device), "iPhone 14 Pro Max should be of iPhone")
        }
    }

    func test_iPhone15() throws {
        let iPhone15 = ["iPhone15,4"]
        let iPhone15Plus = ["iPhone15,5"]
        let iPhone15Pro = ["iPhone16,1"]
        let iPhone15ProMax = ["iPhone16,2"]

        iPhone15.forEach {
            let device = DeviceDetector(id: $0)!.device
            XCTAssertEqual(device, .iPhone15)
            XCTAssertTrue(DeviceOptionSet.iPhoneSet.contains(device), "iPhone 15 should be of iPhone")
        }
        iPhone15Plus.forEach {
            let device = DeviceDetector(id: $0)!.device
            XCTAssertEqual(device, .iPhone15Plus)
            XCTAssertTrue(DeviceOptionSet.iPhoneSet.contains(device), "iPhone 15 Plus should be of iPhone")
        }
        iPhone15Pro.forEach {
            let device = DeviceDetector(id: $0)!.device
            XCTAssertEqual(device, .iPhone15Pro)
            XCTAssertTrue(DeviceOptionSet.iPhoneSet.contains(device), "iPhone 15 Pro should be of iPhone")
        }
        iPhone15ProMax.forEach {
            let device = DeviceDetector(id: $0)!.device
            XCTAssertEqual(device, .iPhone15ProMax)
            XCTAssertTrue(DeviceOptionSet.iPhoneSet.contains(device), "iPhone 15 Pro Max should be of iPhone")
        }
    }

    func test_iPhone16() throws {
        let iPhone16 = ["iPhone17,3"]
        let iPhone16Plus = ["iPhone17,4"]
        let iPhone16Pro = ["iPhone17,1"]
        let iPhone16ProMax = ["iPhone17,2"]

        iPhone16.forEach {
            let device = DeviceDetector(id: $0)!.device
            XCTAssertEqual(device, .iPhone16)
            XCTAssertTrue(DeviceOptionSet.iPhoneSet.contains(device), "iPhone 16 should be of iPhone")
        }
        iPhone16Plus.forEach {
            let device = DeviceDetector(id: $0)!.device
            XCTAssertEqual(device, .iPhone16Plus)
            XCTAssertTrue(DeviceOptionSet.iPhoneSet.contains(device), "iPhone 16 Plus should be of iPhone")
        }
        iPhone16Pro.forEach {
            let device = DeviceDetector(id: $0)!.device
            XCTAssertEqual(device, .iPhone16Pro)
            XCTAssertTrue(DeviceOptionSet.iPhoneSet.contains(device), "iPhone 16 Pro should be of iPhone")
        }
        iPhone16ProMax.forEach {
            let device = DeviceDetector(id: $0)!.device
            XCTAssertEqual(device, .iPhone16ProMax)
            XCTAssertTrue(DeviceOptionSet.iPhoneSet.contains(device), "iPhone 16 Pro Max should be of iPhone")
        }
    }

    func test_iPhone16e() throws {
        let iPhone16e = "iPhone17,5"
        let device = DeviceDetector(id: iPhone16e)!.device
        XCTAssertEqual(device, .iPhone16E)
        XCTAssertTrue(DeviceOptionSet.iPhoneSet.contains(device), "iPhone 16e should be of iPhone")
    }

    func test_iPhone17() throws {
        let iPhone17 = ["iPhone18,3"]
        let iPhone17Pro = ["iPhone18,1"]
        let iPhone17ProMax = ["iPhone18,2"]

        iPhone17.forEach {
            let device = DeviceDetector(id: $0)!.device
            XCTAssertEqual(device, .iPhone17)
            XCTAssertTrue(DeviceOptionSet.iPhoneSet.contains(device), "iPhone 17 should be of iPhone")
        }
        iPhone17Pro.forEach {
            let device = DeviceDetector(id: $0)!.device
            XCTAssertEqual(device, .iPhone17Pro)
            XCTAssertTrue(DeviceOptionSet.iPhoneSet.contains(device), "iPhone 17 Pro should be of iPhone")
        }
        iPhone17ProMax.forEach {
            let device = DeviceDetector(id: $0)!.device
            XCTAssertEqual(device, .iPhone17ProMax)
            XCTAssertTrue(DeviceOptionSet.iPhoneSet.contains(device), "iPhone 17 Pro Max should be of iPhone")
        }
    }

    func test_iPhoneAir() throws {
        let iPhoneAir = "iPhone18,4"
        let device = DeviceDetector(id: iPhoneAir)!.device
        XCTAssertEqual(device, .iPhoneAir)
        XCTAssertTrue(DeviceOptionSet.iPhoneSet.contains(device), "iPhone Air should be of iPhone")
    }

    func test_iPhone14_hasSafeArea() throws {
        let iPhone14Series = ["iPhone14,7", "iPhone14,8", "iPhone15,2", "iPhone15,3"]
        let iPhone15Series = ["iPhone15,4", "iPhone15,5", "iPhone16,1", "iPhone16,2"]
        let iPhone16Series = ["iPhone17,3", "iPhone17,4", "iPhone17,1", "iPhone17,2", "iPhone17,5"]
        let iPhone17Series = ["iPhone18,3", "iPhone18,1", "iPhone18,2"]
        let iPhoneAir = ["iPhone18,4"]

        let allNew = [iPhone14Series, iPhone15Series, iPhone16Series, iPhone17Series, iPhoneAir].flatMap { $0 }

        allNew.forEach {
            let device = DeviceDetector(id: $0)!.device
            XCTAssertTrue(DeviceOptionSet.iPhoneSafeAreaSet.contains(device), "\($0) should have safeArea")
        }
    }

    func test_iPhone_hasSafeArea() throws {
        let iPhoneX = ["iPhone10,3", "iPhone10,6"]
        let iPhoneXS = ["iPhone11,2"]
        let iPhoneXSMax = ["iPhone11,4", "iPhone11,6"]
        let iPhoneXR = ["iPhone11,8"]
        let iPhoneXSeries = [iPhoneX, iPhoneXS, iPhoneXSMax, iPhoneXR].flatMap { $0 }
        
        let iPhone11 = ["iPhone12,1"]
        let iPhone11Pro = ["iPhone12,3"]
        let iPhone11ProMax = ["iPhone12,5"]
        let iPhone11Series = [iPhone11, iPhone11Pro, iPhone11ProMax].flatMap { $0 }
        
        let iPhone12Mini = ["iPhone13,1"]
        let iPhone12 = ["iPhone13,2"]
        let iPhone12Pro = ["iPhone13,3"]
        let iPhone12ProMax = ["iPhone13,4"]
        let iPhone12Series = [iPhone12, iPhone12Pro, iPhone12ProMax, iPhone12Mini].flatMap { $0 }
        
        
        let iPhone13Mini = ["iPhone14,4"]
        let iPhone13 = ["iPhone14,5"]
        let iPhone13Pro = ["iPhone14,2"]
        let iPhone13ProMax = ["iPhone14,3"]
        let iPhone13Series = [iPhone13, iPhone13Pro, iPhone13ProMax, iPhone13Mini].flatMap { $0 }
        
        let safeAreaModel = [iPhoneXSeries, iPhone11Series, iPhone12Series, iPhone13Series].flatMap { $0 }
        
        safeAreaModel.forEach {
            let device = DeviceDetector(id: $0)!.device
            XCTAssertTrue(DeviceOptionSet.iPhoneSafeAreaSet.contains(device), "iPhone should have safeArea")
        }
    }
    
    func test_iPhone_has_no_SafeArea() throws {
        let iPhoneSE1 = "iPhone8,4"
        let iPhoneSE2 = "iPhone12,8"
        let iPhoneSE3 = "iPhone14,6"
        let iPhoneSESeries = [iPhoneSE1, iPhoneSE2, iPhoneSE3]
        
        let iPhone6 = "iPhone8,1"
        let iPhone6Plus = "iPhone8,2"
        let iPhone6Series = [iPhone6, iPhone6Plus]
        
        let iPhone7 = ["iPhone9,1", "iPhone9,3"]
        let iPhone7Plus = ["iPhone9,2", "iPhone9,4"]
        let iPhone7Series = [iPhone7, iPhone7Plus].flatMap { $0 }
        
        let iPhone8 = ["iPhone10,1", "iPhone10,4"]
        let iPhone8Plus = ["iPhone10,2", "iPhone10,5"]
        let iPhone8Series = [iPhone8, iPhone8Plus].flatMap { $0 }
        
        let oldModel = [iPhoneSESeries, iPhone6Series, iPhone7Series, iPhone8Series].flatMap { $0 }
        
        oldModel.forEach {
            let device = DeviceDetector(id: $0)!.device
            XCTAssertFalse(DeviceOptionSet.iPhoneSafeAreaSet.contains(device), "iPhone should has no safeArea")
        }
    }
    
    func test_iPad() throws {
        let iPad5th = ["iPad6,11", "iPad6,12"]
        let iPad6th = ["iPad7,5", "iPad7,6"]
        let iPad7th = ["iPad7,11", "iPad7,12"]
        let iPad8th = ["iPad11,6", "iPad11,7"]
        let iPad9th = ["iPad12,1", "iPad12,1"]
        
        iPad5th.forEach {
            let device = DeviceDetector(id: $0)!.device
            XCTAssertEqual(device, .iPad5)
            XCTAssertTrue(DeviceOptionSet.iPadSet.contains(device), "iPad (5th generation) should be of iPad")
        }
        iPad6th.forEach {
            let device = DeviceDetector(id: $0)!.device
            XCTAssertEqual(device, .iPad6)
            XCTAssertTrue(DeviceOptionSet.iPadSet.contains(device), "iPad (6th generation) should be of iPad")
        }
        iPad7th.forEach {
            let device = DeviceDetector(id: $0)!.device
            XCTAssertEqual(device, .iPad7)
            XCTAssertTrue(DeviceOptionSet.iPadSet.contains(device), "iPad (7th generation) should be of iPad")
        }
        iPad8th.forEach {
            let device = DeviceDetector(id: $0)!.device
            XCTAssertEqual(device, .iPad8)
            XCTAssertTrue(DeviceOptionSet.iPadSet.contains(device), "iPad (8th generation) should be of iPad")
        }
        iPad9th.forEach {
            let device = DeviceDetector(id: $0)!.device
            XCTAssertEqual(device, .iPad9)
            XCTAssertTrue(DeviceOptionSet.iPadSet.contains(device), "iPad (9th generation) should be of iPad")
        }
    }
    
    func test_iPadAir() throws {
        let iPadAir2 = ["iPad5,3", "iPad5,4"]
        let iPadAir3rd = ["iPad11,3", "iPad11,4"]
        let iPadAir4th = ["iPad13,1", "iPad13,2"]
        let iPadAir5th = ["iPad13,16", "iPad13,17"]
        
        iPadAir2.forEach {
            let device = DeviceDetector(id: $0)!.device
            XCTAssertEqual(device, .iPadAir)
            XCTAssertTrue(DeviceOptionSet.iPadSet.contains(device), "iPad Air 2 should be of iPad")
        }
        iPadAir3rd.forEach {
            let device = DeviceDetector(id: $0)!.device
            XCTAssertEqual(device, .iPadAir)
            XCTAssertTrue(DeviceOptionSet.iPadSet.contains(device), "iPad Air (3rd generation) should be of iPad")
        }
        iPadAir4th.forEach {
            let device = DeviceDetector(id: $0)!.device
            XCTAssertEqual(device, .iPadAir)
            XCTAssertTrue(DeviceOptionSet.iPadSet.contains(device), "iPad Air (4th generation) should be of iPad")
        }
        iPadAir5th.forEach {
            let device = DeviceDetector(id: $0)!.device
            XCTAssertEqual(device, .iPadAir)
            XCTAssertTrue(DeviceOptionSet.iPadSet.contains(device), "iPad Air (5th generation) should be of iPad")
        }
    }
    
    func test_iPadMini() throws {
        let iPadMini4 = ["iPad5,1", "iPad5,2"]
        let iPadMini5th = ["iPad11,1", "iPad11,2"]
        let iPadMini6th = ["iPad14,1", "iPad14,2"]
        
        iPadMini4.forEach {
            let device = DeviceDetector(id: $0)!.device
            XCTAssertEqual(device, .iPadMini)
            XCTAssertTrue(DeviceOptionSet.iPadSet.contains(device), "iPad mini 4 should be of iPad")
        }
        iPadMini5th.forEach {
            let device = DeviceDetector(id: $0)!.device
            XCTAssertEqual(device, .iPadMini)
            XCTAssertTrue(DeviceOptionSet.iPadSet.contains(device), "iPad mini (4th generation) should be of iPad")
        }
        iPadMini6th.forEach {
            let device = DeviceDetector(id: $0)!.device
            XCTAssertEqual(device, .iPadMini)
            XCTAssertTrue(DeviceOptionSet.iPadSet.contains(device), "iPad mini (6th generation) should be of iPad")
        }
    }
    
    func test_iPadPro9_7inch() throws {
        let iPadPro9_7inch = ["iPad6,3", "iPad6,4"]
        iPadPro9_7inch.forEach {
            let device = DeviceDetector(id: $0)!.device
            XCTAssertEqual(device, .iPadPro9_7inch)
            XCTAssertTrue(DeviceOptionSet.iPadProSet.contains(device), "iPad Pro (9.7-inch) should be of iPad Pro")
            XCTAssertTrue(DeviceOptionSet.iPadSet.contains(device), "iPad Pro (9.7-inch) should be of iPad")
        }
    }
    
    func test_iPadPro10_5inch() throws {
        let iPadPro10_5inch = ["iPad7,3", "iPad7,4"]
        iPadPro10_5inch.forEach {
            let device = DeviceDetector(id: $0)!.device
            XCTAssertEqual(device, .iPadPro10_5inch)
            XCTAssertTrue(DeviceOptionSet.iPadProSet.contains(device), "iPad Pro (10.5-inch) should be of iPad Pro")
            XCTAssertTrue(DeviceOptionSet.iPadSet.contains(device), "iPad Pro (10.5-inch) should be of iPad")
        }
    }
    
    func test_iPadPro11inch() throws {
        let iPadPro11inch = ["iPad8,1", "iPad8,2", "iPad8,3", "iPad8,4"]
        let iPadPro11inch2nd = ["iPad8,9", "iPad8,10"]
        let iPadPro11inch3rd = ["iPad13,4", "iPad13,5", "iPad13,6", "iPad13,7"]
        
        iPadPro11inch.forEach {
            let device = DeviceDetector(id: $0)!.device
            XCTAssertEqual(device, .iPadPro11inch)
            XCTAssertTrue(DeviceOptionSet.iPadProSet.contains(device), "iPad Pro (11-inch) should be of iPad Pro")
            XCTAssertTrue(DeviceOptionSet.iPadSet.contains(device), "iPad Pro (11-inch) should be of iPad")
        }
        
        iPadPro11inch2nd.forEach {
            let device = DeviceDetector(id: $0)!.device
            XCTAssertEqual(device, .iPadPro11inch)
            XCTAssertTrue(DeviceOptionSet.iPadProSet.contains(device), "iPad Pro (11-inch)(2nd generation) should be of iPad Pro")
            XCTAssertTrue(DeviceOptionSet.iPadSet.contains(device), "iPad Pro (11-inch)(2nd generation) should be of iPad")
        }
        
        iPadPro11inch3rd.forEach {
            let device = DeviceDetector(id: $0)!.device
            XCTAssertEqual(device, .iPadPro11inch)
            XCTAssertTrue(DeviceOptionSet.iPadProSet.contains(device), "iPad Pro (11-inch)(3rd generation) should be of iPad Pro")
            XCTAssertTrue(DeviceOptionSet.iPadSet.contains(device), "iPad Pro (11-inch)(3rd generation) should be of iPad")
        }
    }
    
    func test_iPadPro12_9inch() throws {
        let iPadPro12_9inch = ["iPad6,7", "iPad6,8"]
        let iPadPro12_9inch2nd = ["iPad7,1", "iPad7,2"]
        let iPadPro12_9inch3rd = ["iPad8,5", "iPad8,6", "iPad8,7", "iPad8,8"]
        let iPadPro12_9inch4th = ["iPad8,11", "iPad8,12"]
        let iPadPro12_9inch5th = ["iPad13,8", "iPad13,9", "iPad13,10", "iPad13,11"]
        
        iPadPro12_9inch.forEach {
            let device = DeviceDetector(id: $0)!.device
            XCTAssertEqual(device, .iPadPro12_9inch)
            XCTAssertTrue(DeviceOptionSet.iPadProSet.contains(device), "iPad Pro (12.9-inch) should be of iPad Pro")
            XCTAssertTrue(DeviceOptionSet.iPadSet.contains(device), "iPad Pro (12.9-inch) should be of iPad")
        }
        
        iPadPro12_9inch2nd.forEach {
            let device = DeviceDetector(id: $0)!.device
            XCTAssertEqual(device, .iPadPro12_9inch)
            XCTAssertTrue(DeviceOptionSet.iPadProSet.contains(device), "iPad Pro (12.9-inch)(2nd generation) should be of iPad Pro")
            XCTAssertTrue(DeviceOptionSet.iPadSet.contains(device), "iPad Pro (12.9-inch)(2nd generation) should be of iPad")
        }
        
        iPadPro12_9inch3rd.forEach {
            let device = DeviceDetector(id: $0)!.device
            XCTAssertEqual(device, .iPadPro12_9inch)
            XCTAssertTrue(DeviceOptionSet.iPadProSet.contains(device), "iPad Pro (12.9-inch)(3rd generation) should be of iPad Pro")
            XCTAssertTrue(DeviceOptionSet.iPadSet.contains(device), "iPad Pro (12.9-inch)(3rd generation) should be of iPad")
        }
        
        iPadPro12_9inch4th.forEach {
            let device = DeviceDetector(id: $0)!.device
            XCTAssertEqual(device, .iPadPro12_9inch)
            XCTAssertTrue(DeviceOptionSet.iPadProSet.contains(device), "iPad Pro (12.9-inch)(4th generation) should be of iPad Pro")
            XCTAssertTrue(DeviceOptionSet.iPadSet.contains(device), "iPad Pro (12.9-inch)(4th generation) should be of iPad")
        }
        
        iPadPro12_9inch5th.forEach {
            let device = DeviceDetector(id: $0)!.device
            XCTAssertEqual(device, .iPadPro12_9inch)
            XCTAssertTrue(DeviceOptionSet.iPadProSet.contains(device), "iPad Pro (12.9-inch)(5th generation) should be of iPad Pro")
            XCTAssertTrue(DeviceOptionSet.iPadSet.contains(device), "iPad Pro (12.9-inch)(5th generation) should be of iPad")
        }
    }

    func test_iPad10() throws {
        let iPad10th = ["iPad13,18", "iPad13,19"]
        iPad10th.forEach {
            let device = DeviceDetector(id: $0)!.device
            XCTAssertEqual(device, .iPad10)
            XCTAssertTrue(DeviceOptionSet.iPadSet.contains(device), "iPad (10th generation) should be of iPad")
        }
    }

    func test_iPad11() throws {
        let iPad11th = ["iPad15,7", "iPad15,8"]
        iPad11th.forEach {
            let device = DeviceDetector(id: $0)!.device
            XCTAssertEqual(device, .iPad11)
            XCTAssertTrue(DeviceOptionSet.iPadSet.contains(device), "iPad (11th generation) should be of iPad")
        }
    }

    func test_iPadMini7() throws {
        let iPadMini7th = ["iPad16,1", "iPad16,2"]
        iPadMini7th.forEach {
            let device = DeviceDetector(id: $0)!.device
            XCTAssertEqual(device, .iPadMini)
            XCTAssertTrue(DeviceOptionSet.iPadSet.contains(device), "iPad mini (7th generation) should be of iPad")
        }
    }

    func test_iPadAir_M2() throws {
        let iPadAirM2_11 = ["iPad14,8", "iPad14,9"]
        let iPadAirM2_13 = ["iPad14,10", "iPad14,11"]

        iPadAirM2_11.forEach {
            let device = DeviceDetector(id: $0)!.device
            XCTAssertEqual(device, .iPadAir)
            XCTAssertTrue(DeviceOptionSet.iPadSet.contains(device), "iPad Air 11-inch (M2) should be of iPad")
        }
        iPadAirM2_13.forEach {
            let device = DeviceDetector(id: $0)!.device
            XCTAssertEqual(device, .iPadAir)
            XCTAssertTrue(DeviceOptionSet.iPadSet.contains(device), "iPad Air 13-inch (M2) should be of iPad")
        }
    }

    func test_iPadAir_M3() throws {
        let iPadAirM3_11 = ["iPad15,3", "iPad15,4"]
        let iPadAirM3_13 = ["iPad15,5", "iPad15,6"]

        iPadAirM3_11.forEach {
            let device = DeviceDetector(id: $0)!.device
            XCTAssertEqual(device, .iPadAir)
            XCTAssertTrue(DeviceOptionSet.iPadSet.contains(device), "iPad Air 11-inch (M3) should be of iPad")
        }
        iPadAirM3_13.forEach {
            let device = DeviceDetector(id: $0)!.device
            XCTAssertEqual(device, .iPadAir)
            XCTAssertTrue(DeviceOptionSet.iPadSet.contains(device), "iPad Air 13-inch (M3) should be of iPad")
        }
    }

    func test_iPadPro11inch_4th_5th() throws {
        let iPadPro11inch4th = ["iPad14,3", "iPad14,4"]
        let iPadPro11inch5th = ["iPad16,3", "iPad16,4"]

        iPadPro11inch4th.forEach {
            let device = DeviceDetector(id: $0)!.device
            XCTAssertEqual(device, .iPadPro11inch)
            XCTAssertTrue(DeviceOptionSet.iPadProSet.contains(device), "iPad Pro (11-inch)(4th generation) should be of iPad Pro")
            XCTAssertTrue(DeviceOptionSet.iPadSet.contains(device), "iPad Pro (11-inch)(4th generation) should be of iPad")
        }
        iPadPro11inch5th.forEach {
            let device = DeviceDetector(id: $0)!.device
            XCTAssertEqual(device, .iPadPro11inch)
            XCTAssertTrue(DeviceOptionSet.iPadProSet.contains(device), "iPad Pro (11-inch)(5th generation) should be of iPad Pro")
            XCTAssertTrue(DeviceOptionSet.iPadSet.contains(device), "iPad Pro (11-inch)(5th generation) should be of iPad")
        }
    }

    func test_iPadPro12_9inch_6th() throws {
        let iPadPro12_9inch6th = ["iPad14,5", "iPad14,6"]
        iPadPro12_9inch6th.forEach {
            let device = DeviceDetector(id: $0)!.device
            XCTAssertEqual(device, .iPadPro12_9inch)
            XCTAssertTrue(DeviceOptionSet.iPadProSet.contains(device), "iPad Pro (12.9-inch)(6th generation) should be of iPad Pro")
            XCTAssertTrue(DeviceOptionSet.iPadSet.contains(device), "iPad Pro (12.9-inch)(6th generation) should be of iPad")
        }
    }

    func test_iPadPro13inch() throws {
        let iPadPro13inch = ["iPad16,5", "iPad16,6"]
        iPadPro13inch.forEach {
            let device = DeviceDetector(id: $0)!.device
            XCTAssertEqual(device, .iPadPro13inch)
            XCTAssertTrue(DeviceOptionSet.iPadProSet.contains(device), "iPad Pro (13-inch) should be of iPad Pro")
            XCTAssertTrue(DeviceOptionSet.iPadSet.contains(device), "iPad Pro (13-inch) should be of iPad")
        }
    }
}
