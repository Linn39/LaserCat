//
//  AppDelegate.swift
//  LaserCat
//
//  Created by Lin Zhou on 08.02.26.
//

#if os(iOS)
import UIKit

/// Keys for preferred orientation (portrait vs one landscape).
enum OrientationPreference {
    static let useLandscapeKey = "LaserCat.PreferredOrientationIsLandscape"

    static var mask: UIInterfaceOrientationMask {
        UserDefaults.standard.bool(forKey: useLandscapeKey) ? .landscapeRight : .portrait
    }

    static func setLandscape(_ useLandscape: Bool) {
        UserDefaults.standard.set(useLandscape, forKey: useLandscapeKey)
    }

    static var isLandscape: Bool {
        UserDefaults.standard.bool(forKey: useLandscapeKey)
    }
}

class AppDelegate: NSObject, UIApplicationDelegate {
    func application(
        _ application: UIApplication,
        supportedInterfaceOrientationsFor window: UIWindow?
    ) -> UIInterfaceOrientationMask {
        OrientationPreference.mask
    }
}
#endif
