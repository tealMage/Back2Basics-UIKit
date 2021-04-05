//
//  ProcessInfo+Extension.swift
//  ExpertChow
//
//  Created by Adam Sterrett on 3/10/21.
//

import Foundation
extension ProcessInfo {
    @objc static func isRunningUITests() -> Bool {
        return ProcessInfo.processInfo.arguments.contains("Running_UI_Tests")
    }

    @objc static func isRunningUnitTests() -> Bool {
        return ProcessInfo.processInfo.environment["XCTestConfigurationFilePath"] ?? nil != nil
    }
}
