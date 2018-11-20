//
//  TFAppRotation.swift
//  AppRotationDemo
//
//  Created by Chung Duong on 11/20/18.
//  Copyright © 2018 Chung Duong. All rights reserved.
//

import UIKit

class TFAppRotation: NSObject {
    static func isIpad() -> Bool {
        return UIDevice.current.userInterfaceIdiom == UIUserInterfaceIdiom.pad
    }
    
    static func shouldAutorotate() -> Bool {
        if isIpad() {
            return true
        } else {
            return false
        }
    }
    
    static func supportedInterfaceOrientations() -> UIInterfaceOrientationMask {
        if isIpad() {
            return .all
        } else {
            return .portrait
        }
    }
    
    static func forceLandscapeRight() {
        let value = UIInterfaceOrientation.landscapeRight.rawValue
        UIDevice.current.setValue(value, forKey: "orientation")
    }
    
    private static func lockOrientation(_ orientation: UIInterfaceOrientationMask) {
        guard let delegate = UIApplication.shared.delegate as? AppDelegate else { return }
        
        delegate.orientationLock = orientation
    }
    
    static func lockOrientationDefault() {
        lockOrientation(supportedInterfaceOrientations())
    }
    
    static func lockOrientationLandscapeRight() {
        lockOrientation(.landscapeRight)
    }
    
    static func lockOrientationAll() {
        lockOrientation(.all)
    }
    
    /// Return DeviceType. Example: iPhone5,2
    static func deviceType() -> String {
        var sysinfo = utsname()
        uname(&sysinfo)
        return String(bytes: Data(bytes: &sysinfo.machine, count: Int(_SYS_NAMELEN)), encoding: .ascii)!.trimmingCharacters(in: .controlCharacters)
    }
    
    static func isSimulator() -> Bool {
        var isSim = false
        #if arch(i386) || arch(x86_64)
        isSim = true
        #endif
        return isSim
    }
}
