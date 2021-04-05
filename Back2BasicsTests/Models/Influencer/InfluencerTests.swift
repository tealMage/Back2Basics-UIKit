//
//  InfluencerTests.swift
//  Back2BasicsTests
//
//  Created by Adam Sterrett on 4/4/21.
//

import Foundation
import XCTest
@testable import Back2Basics

class InfluencerTests: XCTestCase {
    func testDecodingPlace() {
        CodableTestHelpers<Influencer>.decodeFileNamed("Influencer") { influencer in
            InfluencerHelper.verifyInfluencer(influencer)
        }
    }

    func testDecodingPlaces() {
        CodableTestHelpers<[Influencer]>.decodeFileNamed("Influencers") { influencer in
            InfluencerHelper.verifyInfluencers(influencer)
        }
    }

    func testEncodingPlace() {
        CodableTestHelpers<Influencer>.encodeFileNamed("Influencer") { influencer in
            InfluencerHelper.verifyInfluencer(influencer)
        }
    }

    func testEncodingPlaces() {
        CodableTestHelpers<[Influencer]>.encodeFileNamed("Influencers") { influencer in
            InfluencerHelper.verifyInfluencers(influencer)
        }
    }
}
