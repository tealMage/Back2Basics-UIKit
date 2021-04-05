//
//  Drawable.swift
//  ExpertChow
//
//  Created by Adam Sterrett on 3/10/21.
//

import Foundation
import UIKit

protocol Drawable {
    var viewController: UIViewController? { get }
}

extension UIViewController: Drawable {
    var viewController: UIViewController? {return self}
}
