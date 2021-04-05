//
//  UIButtonItem+Style.swift
//  ExpertChow
//
//  Created by Adam Sterrett on 3/11/21.
//

import UIKit
import Foundation
extension UIBarButtonItem {
    static func backBarButtonItem(target: Any?,
                                  action: Selector?) -> UIBarButtonItem {
        let image = ImageType.arrowBack.tintableImage()
        let backButton = UIBarButtonItem(image: image, style: .plain, target: target, action: action)
        backButton.tintColor = UIColor.white
        backButton.accessibilityIdentifier = "Back"
        
        return backButton
    }

    static func closeBarButtonItem(target: Any?,
                                   action: Selector?) -> UIBarButtonItem {
        let image = ImageType.closeButton.tintableImage()
        let backButton = UIBarButtonItem(image: image, style: .plain, target: target, action: action)
        backButton.tintColor = UIColor.white

        return backButton
    }

    static func standardBarButtonItemText(title: String,
                                          target: Any?,
                                          action: Selector?) -> UIBarButtonItem {
        
        let barButton = UIBarButtonItem(title: title, style: .plain, target: target, action: action)
        
        return barButton
    }
    
     static func standardBarButtonItemCustomInset(image: ImageType,
                                                       inset: Float,
                                                       target: Any?,
                                                       action: Selector?) -> UIBarButtonItem {

        let button = UIButton(type: .custom)
        let inset = CGFloat(inset)
        button.setImage(image.image().withRenderingMode(.alwaysTemplate), for: .normal)
        if let target = target, let action = action {
            button.addTarget(target, action: action, for: .touchUpInside)
        }
        button.contentEdgeInsets = UIEdgeInsets(top: inset, left: inset, bottom: inset, right: inset)
        
        let barButton = UIBarButtonItem(customView: button)
        
        return barButton
    }
    
     static func standardBarButtonItem(image: ImageType,
                                     target: Any?,
                                     action: Selector?) -> UIBarButtonItem {
        return standardBarButtonItemCustomInset(image: image, inset: 5.0, target: target, action: action)
    }
}
