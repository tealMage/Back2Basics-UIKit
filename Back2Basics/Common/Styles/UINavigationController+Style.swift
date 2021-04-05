//
//  UINavigationController.swift
//  ExpertChow
//
//  Created by Adam Sterrett on 3/11/21.
//

import UIKit
import Foundation

extension UINavigationController {
    func setClearNavigationBar() {
        navigationBar.setBackgroundImage(UIImage(), for: .default)
        navigationBar.shadowImage = UIImage()
        navigationBar.isTranslucent = true
        navigationBar.barTintColor = UIColor.clear
        navigationBar.backgroundColor = .clear
    }

    func setUpDefaultNavigationBar() {
        self.setNavigationBarHidden(false, animated: false)
        
        navigationBar.tintColor = ColorStyle.white.color()

        navigationBar.barTintColor = ColorStyle.darkRed.color()
        navigationBar.isTranslucent = false
    }

    func setClearNavigationBarWithBackButton(in viewController: UIViewController, title: String?, target: Any?, action: Selector?) {
        setClearNavigationBar()
        viewController.navigationItem.leftBarButtonItem = UIBarButtonItem.backBarButtonItem(target: target, action: action)
        updateNavigationBar(in: viewController, title: title)
    }

    func setNavigationBarWithCloseButton(in viewController: UIViewController, title: String?, target: Any?, action: Selector?) {
        viewController.navigationItem.rightBarButtonItem = UIBarButtonItem.closeBarButtonItem(target: target, action: action)
        setNavigationBarWithTitle(in: viewController, title: title)
    }

    func setNavigationBarWithBackButton(in viewController: UIViewController, title: String?, target: Any?, action: Selector?) {
        viewController.navigationItem.leftBarButtonItem = UIBarButtonItem.backBarButtonItem(target: target, action: action)
        setNavigationBarWithTitle(in: viewController, title: title)
    }

    func setNavigationBarWithTitle(in viewController: UIViewController, title: String?) {
        setUpDefaultNavigationBar()
        updateNavigationBar(in: viewController, title: title)
    }
}

private extension UINavigationController {
    func updateNavigationBar(in viewController: UIViewController, title: String?) {
        let navigationItem = viewController.navigationItem
        navigationItem.hidesBackButton = true

        if let title = title {
            navigationItem.title = title
        } else {
            navigationItem.title = nil
        }

        let font = FontStyle.primaryBold.font(size: 17)
        navigationBar.titleTextAttributes = [NSAttributedString.Key.font: font,
                                             NSAttributedString.Key.foregroundColor: UIColor.white]
    }
}
