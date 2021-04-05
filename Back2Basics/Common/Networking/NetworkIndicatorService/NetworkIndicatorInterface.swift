//
//  NetworkIndicatorInterface.swift
//  ARSkyline
//
//  Created by Adam Sterrett on 2/14/21.
//

import Foundation

protocol NetworkIndicatorInterface {
    var isVisible: Bool { get }
    
    func incrementActivityCount()
    func decrementActivityCount()
}
