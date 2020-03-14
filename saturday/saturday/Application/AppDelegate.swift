//
//  AppDelegate.swift
//  saturday
//
//  Copyright © none. All rights reserved.
//

import UIKit

class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    lazy private var router = RootRouter()
    lazy private var deeplinkHandler = DeeplinkHandler()
    lazy private var notificationsHandler = NotificationsHandler()

    func application(_ application: UIApplication,
                     didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        window = UIWindow(frame: UIScreen.main.bounds)
        window?.makeKeyAndVisible()

        // App structure
        router.loadMainAppStructureWithStoryboard()

        return true
    }
}
