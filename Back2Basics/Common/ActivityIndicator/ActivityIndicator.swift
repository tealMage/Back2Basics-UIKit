//
//  ActivityIndicator.swift
//  ExpertChow
//
//  Created by Adam Sterrett on 3/9/21.
//

import Foundation
import UIKit
protocol ActivityIndicator {
    // When view is nil, the activity indicator will block the whole screen
    func show(in view: UIView?)
    func hide()
}
