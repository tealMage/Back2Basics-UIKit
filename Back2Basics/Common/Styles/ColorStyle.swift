//
//  ColorStyle.swift
//  ExpertChow
//
//  Created by Adam Sterrett on 3/10/21.
//

import Foundation
import UIKit

enum ColorStyle {
    case clear
    case backgroundColor
    case grey37
    case grey15
    case textBlack
    case white
    case darkRed


    func color() -> UIColor {
         switch self {
            case .backgroundColor: return UIColor(named: "#F4F3F3") ?? .clear
            case .clear: return .clear
            case .grey37: return UIColor.black.withAlphaComponent(0.37)
            case .grey15: return UIColor.black.withAlphaComponent(0.15)
            case .textBlack: return UIColor(red: 0.13, green: 0.13, blue: 0.13, alpha: 1.0)
            case .white: return .white
            case .darkRed: return UIColor(named: "BackgroundRed") ?? .clear


         }
    }
}
