//
//  MockNetworkIndicatorInterface.swift
//  Back2BasicsTests
//
//  Created by Adam Sterrett on 4/4/21.
//

import Foundation

@testable import Back2Basics

class MockNetworkIndicatorInterface: NetworkIndicatorInterface {
    var isVisible: Bool  = false

    func incrementActivityCount() {}
    func decrementActivityCount() {}
}
