//
//  APIClient+Headers.swift
//  ARSkyline
//
//  Created by Adam Sterrett on 2/14/21.
//

import Foundation
extension APIClient {
    func addCommonHeaders(to request: inout URLRequest, service: APIService) {
        let headers = commonHeaders()

        for (key, value) in headers {
            request.setValue(value, forHTTPHeaderField: key)
        }
    }
}

private extension APIClient {
    func commonHeaders() -> [String: String] {
        let headers = [
            "Content-Type": "application/json",
            "Accept-Language": NSLocale.preferredLanguages.joined(separator: ","),
            "X-Device-OS": "iOS",
            "X-Application-Version": self.applicationVersion(),
            "X-Timezone-ID": TimeZone.current.identifier
        ]
        return headers
    }

    func applicationVersion() -> String {
        let version = Bundle.main.infoDictionary?["CFBundleShortVersionString"] ?? ""
        let buildNumber = Bundle.main.infoDictionary?["CFBundleVersion"] ?? ""

        return "\(version) \(buildNumber)"
    }
}
