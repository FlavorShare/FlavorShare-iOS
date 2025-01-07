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
        FoodItemsList.shared.loadFoodItems()
        return true
    }
        
//    static var orientationLock = UIInterfaceOrientationMask.portrait {
//        didSet {
//            if #available(iOS 16.0, *) {
//                UIApplication.shared.connectedScenes.forEach { scene in
//                    if let windowScene = scene as? UIWindowScene {
//                        windowScene.requestGeometryUpdate(.iOS(interfaceOrientations: orientationLock))
//                    }
//                }
//                UIViewController.attemptRotationToDeviceOrientation()
//            } else {
//                if orientationLock == .landscape {
//                    UIDevice.current.setValue(UIInterfaceOrientation.landscapeRight.rawValue, forKey: "orientation")
//                } else {
//                    UIDevice.current.setValue(UIInterfaceOrientation.portrait.rawValue, forKey: "orientation")
//                }
//            }
//        }
//    }
//
//    func application(_ application: UIApplication, supportedInterfaceOrientationsFor window: UIWindow?) -> UIInterfaceOrientationMask {
//        return AppDelegate.orientationLock
//    }
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
