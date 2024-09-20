//
//  FlavorShare_iOSApp.swift
//  FlavorShare_iOS
//
//  Created by Benjamin Lefebvre on 2024-09-12.
//

import SwiftUI
import FirebaseCore

class AppDelegate: UIResponder, UIApplicationDelegate {
    // Manage User Auth
    func application(_ application: UIApplication,
                     didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        FirebaseApp.configure()
        return true
    }
}

@main
struct FlavorShare_iOSApp: App {
    // Register app delegate for Firebase setup
    @UIApplicationDelegateAdaptor(AppDelegate.self) var delegate
    
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
    }
}
