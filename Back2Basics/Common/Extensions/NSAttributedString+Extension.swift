//
//  NSAttributedString+Extension.swift
//  ExpertChow
//
//  Created by Adam Sterrett on 3/11/21.
//

import Foundation
import UIKit

extension NSAttributedString {
    static func multiLineLabel(with text: String,
                               font: UIFont = FontStyle.primaryMedium.font(size: 17),
                               textColor: UIColor = ColorStyle.textBlack.color(),
                               textAlignment: NSTextAlignment = .left,
                               lineHeightMultiple: CGFloat = 1.2) -> NSAttributedString {
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.lineHeightMultiple = lineHeightMultiple
        paragraphStyle.alignment = textAlignment

        let attributes = [NSAttributedString.Key.paragraphStyle: paragraphStyle,
                          NSAttributedString.Key.font: font,
                          NSAttributedString.Key.foregroundColor: textColor]

        return NSAttributedString(string: text, attributes: attributes)
    }
}
