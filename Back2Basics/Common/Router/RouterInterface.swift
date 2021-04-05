//
//  RouterInterface.swift
//  ExpertChow
//
//  Created by Adam Sterrett on 3/10/21.
//

import Foundation

typealias NavigationBackClosure = (() -> Void)

protocol RouterInterface: class {
    func push(_ drawable: Drawable, isAnimated: Bool, onNavigateBack closure: NavigationBackClosure?)
    func pop(_ isAnimated: Bool)
    func popToRoot(_ isAnimated: Bool)
}
