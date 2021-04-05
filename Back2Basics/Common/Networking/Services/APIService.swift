//
//  APIService.swift
//  ARSkyline
//
//  Created by Adam Sterrett on 2/14/21.
//

import Foundation
import RxSwift

protocol APIService {
    var path: String { get }
    var method: NetworkMethod { get }
    var parameters: ServerParameters? { get }
    var serviceType: ServiceType { get }
    var shouldAddCommonHeaders: Bool { get }

    func request(with baseUrlString: String) -> URLRequest
}

extension APIService {
    func request(with baseUrlString: String) -> URLRequest {

        guard let baseUrl = URL(string: "\(baseUrlString)") else {
            fatalError("Unable to create url for base URL: \(baseUrlString)")
        }

        let url = baseUrl.appendingPathComponent(self.path)
        return request(for: url)
    }

    func ziplineRequest() -> URLRequest {
        if let url = URL(string: path) {
            return request(for: url)
        } else {
            fatalError("Unable to create url for Zipline Service: \(self)")
        }
    }
    
    func request(for url: URL) -> URLRequest {
        var request = URLRequest(url: url)
        request.httpMethod = method.rawValue

        return request
    }
}
