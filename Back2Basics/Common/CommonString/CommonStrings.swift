//
//  CommonStrings.swift
//  ExpertChow
//
//  Created by Adam Sterrett on 3/10/21.
//

import Foundation
enum CommonString: String {
    case ok
    
    func localizedString() -> String {
        switch self {
        case .ok:
            return NSLocalizedString("OK",
                   comment: "Used to express agreement or acceptance")

        }
    }
}
