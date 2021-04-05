//
//  CodableTestHelpers.swift
//  Back2BasicsTests
//
//  Created by Adam Sterrett on 4/4/21.
//

import XCTest

class CodableTestHelpers<Result: Codable & Equatable> {
    typealias CodableTestHelperResult = (Result) -> Void

    static func decodedObjectForFileNamed(_ fileName: String) -> Result {
        let json = TestHelpers.JSONString(for: fileName)
        let data = json.data(using: String.Encoding.utf8)!

        let decoder = JSONDecoder()

            // swiftlint:disable force_try
            let result = try! decoder.decode(Result.self, from: data)
            // swiftlint:enable force_try
            return result
    }

    static func decodeFileNamed(_ fileName: String, completion: CodableTestHelperResult?) {
        let result = decodedObjectForFileNamed(fileName)
        completion?(result)
    }

    static func encodeFileNamed(_ fileName: String, expectedResult: Result) {
        let json = TestHelpers.JSONString(for: fileName)
        let data = json.data(using: String.Encoding.utf8)!

        let decoder = JSONDecoder()
        let encoder = JSONEncoder()

        do {
            let object = try decoder.decode(Result.self, from: data)
            let encodedData = try encoder.encode(object)
            let encodedObject = try decoder.decode(Result.self, from: encodedData)

            XCTAssertEqual(encodedObject, expectedResult)
        } catch {
            XCTFail("Failed to decode \(fileName)")
        }
    }

    static func encodeFileNamed(_ fileName: String, completion: CodableTestHelperResult?) {
        let json = TestHelpers.JSONString(for: fileName)
        let data = json.data(using: String.Encoding.utf8)!

        let decoder = JSONDecoder()
        let encoder = JSONEncoder()

        do {
            let object = try decoder.decode(Result.self, from: data)
            let encodedData = try encoder.encode(object)
            let encodedObject = try decoder.decode(Result.self, from: encodedData)

            completion?(encodedObject)
        } catch {
            XCTFail("Failed to decode \(fileName)")
        }
    }
}
