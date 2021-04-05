//
//  MockServerClient.swift
//  Back2BasicsTests
//
//  Created by Adam Sterrett on 4/4/21.
//

import Foundation
import RxSwift
@testable import Back2Basics

class MockServerClient: ServerClient {
    var environment: MockEnvironment
    var networkIndicatorInterface: MockNetworkIndicatorInterface
    var session: URLSession

    var calledService: APIService?
    var responseError: Error?
    var expectedResponse: Any?
    var hasStartedRequest = false

    init() {
        environment = MockEnvironment()
        networkIndicatorInterface = MockNetworkIndicatorInterface()
        session = URLSession(configuration: URLSessionConfiguration.default)
    }

    func handleResponse<T: Decodable>(request: URLRequest, response: URLResponse?, data: Data, single: (SingleEvent<T>) -> Void) {}

    func addParameters(to request: inout URLRequest, service: APIService) throws {}
    
    func request<T: Decodable>(_ service: APIService) -> Single<T> {
        hasStartedRequest = true
        calledService = service

        return RxHelpers.singleWithMockValue(value: expectedResponse as? T, error: responseError ?? NetworkError.unknown)
    }
}
