//
//  MockInfluencerDataInterface.swift
//  Back2BasicsTests
//
//  Created by Adam Sterrett on 4/4/21.
//

import Foundation
import RxSwift

@testable import Back2Basics

class MockInfluencerDataInterface: InfluencerDataInterface {

    var didCallFetchBillboards = false

    var expectedResonse: [Influencer]?
    var errors: Error?

    func fetchNearbyInfluencers() -> Single<[Influencer]> {
        didCallFetchBillboards = true
        return RxHelpers.singleWithMockValue(value: expectedResonse, error: errors)
    }
}
