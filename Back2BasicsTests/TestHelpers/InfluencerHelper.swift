//
//  InfluencerHelper.swift
//  Back2BasicsTests
//
//  Created by Adam Sterrett on 4/4/21.
//

import Foundation
import XCTest
@testable import Back2Basics

class InfluencerHelper {

    static func influencersFromInfluencerJSON() -> [Influencer] {
        return CodableTestHelpers<[Influencer]>.decodedObjectForFileNamed("Influencers")
    }

    static func verifyInfluencer(_ influencer: Influencer) {
        verifyInfluencerData(influencer)
    }

    static func verifyInfluencerData(_ influencer: Influencer) {

        XCTAssertEqual(influencer.guid, "1c933518-7d3a-4402-add4-5ad762ffbd54")
        XCTAssertEqual(influencer.username, "Mermaid")
        XCTAssertEqual(influencer.description, "Mermaid Fun Event")
        XCTAssertEqual(influencer.url, URL(string: "http://www.google.com"))
    }

    static func verifyInfluencers(_ influencer: [Influencer]) {
        XCTAssertEqual(influencer.count, 3)
        verifyInfluencerData(influencer)
    }

    static func verifyInfluencerData(_ influencer: [Influencer]) {
        verifyInfluencer1(influencer[0])
        verifyInfluencer2(influencer[1])
        verifyInfluencer3(influencer[2])
    }

    static func verifyInfluencer1(_ influencer: Influencer) {

        XCTAssertEqual(influencer.guid, "a5b895c2-37bb-4f27-9ba8-72bec6040c1d")
        XCTAssertEqual(influencer.username, "Crab")
        XCTAssertEqual(influencer.description, "Crab Fun Event")
        XCTAssertEqual(influencer.url, URL(string: "http://www.google.com"))

    }

    static func verifyInfluencer2(_ influencer: Influencer) {

        XCTAssertEqual(influencer.guid, "f970b17f-d086-4cc5-a63b-79d6a41d124c")
        XCTAssertEqual(influencer.username, "Ocean")
        XCTAssertEqual(influencer.description, "Ocean Fun Event")
        XCTAssertEqual(influencer.url, URL(string: "http://www.google.com"))
    }

    static func verifyInfluencer3(_ influencer: Influencer) {

        XCTAssertEqual(influencer.guid, "e846f274-e187-4275-a2f8-a734927aad69")
        XCTAssertEqual(influencer.username, "Norfolk")
        XCTAssertEqual(influencer.description, "Norfolk Fun Event")
        XCTAssertEqual(influencer.url, URL(string: "http://www.google.com"))

    }
}
