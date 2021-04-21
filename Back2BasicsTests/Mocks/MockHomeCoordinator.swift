//
//  MockHomeCoordinator.swift
//  Back2BasicsTests
//
//  Created by Adam Sterrett on 4/21/21.
//

import Foundation
@testable import Back2Basics

class MockHomeCoordinator: HomeCoordinator {
    var didCallShowInfluencer = false
    var didCallClosenIfluencer = false

    func showInfluencer(_ influencer: Influencer) {
        didCallShowInfluencer = true
    }
    
    func closeInfluencer() {
        didCallClosenIfluencer = true
    }
    
    func start() -> Bool { return true }
    
}
