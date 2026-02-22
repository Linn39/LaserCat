//
//  LaserCatApp.swift
//  LaserCat
//
//  Created by Lin Zhou on 08.02.26.
//

import SwiftUI
#if os(iOS)
import UIKit
#endif

@main
struct LaserCat: App {
    #if os(iOS)
    @UIApplicationDelegateAdaptor(AppDelegate.self) var appDelegate
    #endif

    var body: some Scene {
        WindowGroup {
            ContentView()
        }
    }
}
