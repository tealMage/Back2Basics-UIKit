//
//  Router.swift
//  ExpertChow
//
//  Created by Adam Sterrett on 3/10/21.
//

import Foundation
import UIKit

class Router: NSObject, RouterInterface {

    let navigationController: UINavigationController
    private var closures: [String: NavigationBackClosure] = [:]
    
    func push(_ drawable: Drawable, isAnimated: Bool, onNavigateBack closure: NavigationBackClosure?) {
        guard let viewController = drawable.viewController else {
            return
        }
        
        if let closure = closure {
            closures.updateValue(closure, forKey: viewController.description)
        }
        
        navigationController.pushViewController(viewController, animated: isAnimated)
    }
    
    func pop(_ isAnimated: Bool) {
        navigationController.popViewController(animated: isAnimated)
    }
    
    func popToRoot(_ isAnimated: Bool) {
        navigationController.popToRootViewController(animated: isAnimated)
    }

    private func execureClosure(_ viewController: UIViewController) {
        guard let closure = closures.removeValue(forKey: viewController.description) else {return}
        closure()
    }

    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
        super.init()
        self.navigationController.delegate = self as UINavigationControllerDelegate
    }
}

extension Router: UINavigationControllerDelegate {
    func navigationController(_ navigationController: UINavigationController, didShow viewController: UIViewController, animated: Bool) {
        guard let previousController = navigationController.transitionCoordinator?.viewController(forKey: .from), !navigationController.viewControllers.contains(previousController) else {
            return
        }
        execureClosure(previousController)
    }
}
