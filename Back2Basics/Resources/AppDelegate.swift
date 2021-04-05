//
//  AppDelegate.swift
//  ExpertChow
//
//  Created by Adam Sterrett on 3/9/21.
//

import UIKit
import CoreData

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    private var appCoordinator: AppFlowCoordinator!

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        window = UIWindow()
        let factory = AppFlowFactory()
        let appCoordinator = AppFlowCoordinator(window: window!, factory: factory)
        
        _ = appCoordinator.start()
        self.appCoordinator = appCoordinator
        return true
    }
}
