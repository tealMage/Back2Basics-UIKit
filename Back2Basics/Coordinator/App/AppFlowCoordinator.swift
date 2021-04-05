//
//  AppCoordinator.swift
//  arskyline
//
//  Created by Adam Sterrett on 2/9/21.
//

import Foundation
import UIKit

class AppFlowCoordinator: AppCoordinator {
 
    let window: UIWindow
    let factory: AppFlowFactory
    var childCoordinators: [Coordinator] = []
    var navigationController: UINavigationController

    init(window: UIWindow, factory: AppFlowFactory) {
        self.window = window
        self.factory = factory
        self.navigationController = UINavigationController()
    }

    func start() -> Bool {
        setupRootView()
        return true
    }

    func setupRootView() {
        setWindowRootViewController(navigationController)
        showHomeView()
    }

    func setWindowRootViewController(_ rootViewController: UIViewController) {
        window.rootViewController = rootViewController
        window.makeKeyAndVisible()
    }

    func showHomeView() {
        let homeCoordinator = factory.homeCoordinator(navigationController: navigationController)
        startCoordinator(homeCoordinator)
    }

    func startCoordinator(_ coordinator: Coordinator) {
          if coordinator.start() {
              childCoordinators = [coordinator]
          }
      }
}
