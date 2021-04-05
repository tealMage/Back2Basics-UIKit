//
//  Coordinator.swift
//  arskyline
//
//  Created by Adam Sterrett on 2/9/21.
//

import Foundation

protocol Coordinator: class {
    @discardableResult func start() -> Bool
}
