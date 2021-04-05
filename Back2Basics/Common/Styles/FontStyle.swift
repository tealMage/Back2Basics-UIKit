//
//  FontStyle.swift
//  ExpertChow
//
//  Created by Adam Sterrett on 3/11/21.
//

import Foundation
import UIKit
enum FontStyle {
    case primaryMedium
    case primaryBold
    case primarySemiBold

    func font(size: CGFloat) -> UIFont {
        return UIFont.systemFont(ofSize: size, weight: fontWeight())
    }

    private func fontWeight() -> UIFont.Weight {
        switch self {
        case .primaryMedium:
            return .regular
        case .primaryBold:
            return .bold
        case .primarySemiBold:
            return .semibold
        }
    }
}
