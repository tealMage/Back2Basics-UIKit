//
//  AppEnvironment.swift
//  ARSkyline
//
//  Created by Adam Sterrett on 2/14/21.
//

import Foundation

private var sharedEnvironment: AppEnvironment?

class AppEnvironment: NSObject, Environment {

    private static func environments() -> NSDictionary {
            let contentsOfFile = Bundle.main.path(forResource: "Environment", ofType: "plist")!
            return NSDictionary(contentsOfFile: contentsOfFile)!
        
    }

    let apiBase: String
    let environmentType: String

    override init() {
        let env = AppEnvironment.environments()

        guard let apiBase = env["apiBase"] as? String,
            let environmentType = env["environment"] as? String else {
                fatalError("The environment is not set up correctly.")
        }

        self.apiBase = apiBase
        self.environmentType = environmentType
    }

    func currentEnvironment() -> EnvironmentType {
        if self.isDebug() {
            return .qa
        }

        return .prod
    }

    func isDebug() -> Bool {
        return "Prod" != environmentType
    }
}
