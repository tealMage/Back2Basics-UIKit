//
//  APIClient+Parameters.swift
//  ARSkyline
//
//  Created by Adam Sterrett on 2/14/21.
//

import Foundation

extension APIClient {
    func addParameters(to request: inout URLRequest, service: APIService) throws {
        switch service.method {
        case .get, .delete:
            try addQueryParameters(to: &request, service: service)

        case .post, .put:
            try addBodyParameters(to: &request, service: service)
        }
    }
}

private extension APIClient {
    func addQueryParameters(to request: inout URLRequest, service: APIService) throws {
        guard let parameters = service.parameters as? [String: String],
            let url = request.url,
            service.method == .get else {
                return
        }

        var urlComponents = URLComponents(url: url, resolvingAgainstBaseURL: false)
        var queryItems = [URLQueryItem]()

        for (key, value) in parameters {
            queryItems.append(URLQueryItem(name: key, value: value))
        }

        if queryItems.isEmpty == false {
            urlComponents?.queryItems = queryItems
        }

        if let requestUrl = urlComponents?.url {
            request.url = requestUrl
        }
    }

    func addBodyParameters(to request: inout URLRequest, service: APIService) throws {

        var allParameters: ServerParameters

        allParameters = ServerParameters()

        service.parameters?.forEach { allParameters[$0] = $1 }

        do {
            let data = try JSONSerialization.data(withJSONObject: allParameters, options: [])
            request.httpBody = data
        } catch {
            throw NetworkError.invalidRequestParameters
        }
    }

}
