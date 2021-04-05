//
//  TestHelpers.swift
//  Back2BasicsTests
//
//  Created by Adam Sterrett on 4/4/21.
//

import Foundation
import CoreLocation
import XCTest

@testable import Back2Basics

class TestHelpers {

    static func JSONString(for fileName: String) -> String {
        let bundle = Bundle(for: TestHelpers.self)
        let url = bundle.url(forResource: fileName, withExtension: "json")!
        
        // swiftlint:disable force_try
        let jsonString = try! String(contentsOf: url, encoding: .utf8)
        // swiftlint:enable force_try
        return jsonString
    }
    
    static func mockLocation() -> CLLocation {
        let coordinate = CLLocationCoordinate2D(latitude: Double.random(in: -90 ..< 90), longitude: Double.random(in: 0 ..< 180))
        return CLLocation(coordinate: coordinate,
                          altitude: 0.0,
                          horizontalAccuracy: TestHelpers.randomDouble(),
                          verticalAccuracy: 1.0,
                          course: 1.0,
                          speed: 1.0,
                          timestamp: Date())
    }
    
    static func randomDouble(min: Double = 0, max: Double = 1000000) -> Double {
        return Double.random(in: min...max)
    }

}
