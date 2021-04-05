//
//  APIClient.swift
//  ARSkyline
//
//  Created by Adam Sterrett on 2/14/21.
//

import Foundation
import RxSwift

class APIClient: NSObject, ServerClient {

    let environment: Environment
    let networkIndicatorInterface: NetworkIndicatorInterface
    let decoder = JSONDecoder()

    lazy var session: URLSession = {
        let configuration = URLSessionConfiguration.default
        configuration.timeoutIntervalForRequest = 10.0
        configuration.timeoutIntervalForResource = 10.0
        configuration.waitsForConnectivity = true

        return URLSession(configuration: configuration, delegate: nil, delegateQueue: nil)
    }()

    init(environment: Environment,
         networkIndicatorInterface: NetworkIndicatorInterface) {
        self.environment = environment
        self.networkIndicatorInterface = networkIndicatorInterface
    }

    func request<T: Decodable>(_ service: APIService) -> Single<T> {
        return Single<T>.create { single in
            var task: URLSessionDataTask?

            do {
                var request = service.request(with: self.baseUrl(for: service))

                if service.shouldAddCommonHeaders {
                    self.addCommonHeaders(to: &request, service: service)
                }

                try self.addParameters(to: &request, service: service)

                self.networkIndicatorInterface.incrementActivityCount()

                task = self.session.dataTask(with: request) { data, response, error in
                    defer {
                        self.networkIndicatorInterface.decrementActivityCount()
                    }

                    if let error = error as NSError? {
                        let networkError = self.networkErrorForError(error)
                        single(.failure(networkError))
                        return
                    }

                    guard let data = data else {
                        single(.failure(NetworkError.invalidResponse))
                        return
                    }

                    self.handleResponse(request: request, response: response, data: data, service: service, single: single)
                }

                task?.resume()
            } catch {
                single(.failure(error as? NetworkError ?? .unknown))
            }

            return Disposables.create {
                // A cancelled call to the AppLaunch end point means SSL Pinning has failed, so we never want to manually
                // cancel a call to AppLaunch
                //
                // Any web server endpoint can be used, but AppLaunch was chosen.
                if let url = task?.currentRequest?.url, url.absoluteString.contains("AppLaunch") {
                    return
                }

                task?.cancel()
            }
        }
    }
}

private extension APIClient {
    func handleResponse<T: Decodable>(request: URLRequest,
                                      response: URLResponse?,
                                      data: Data,
                                      service: APIService,
                                      single: (SingleEvent<T>) -> Void) {
        switch service.serviceType {
        case .api:
            handleResponse(request: request, response: response, data: data, single: single)
        }
    }

    func networkErrorForError(_ error: NSError) -> NetworkError {
        switch error.code {
        case NSURLErrorTimedOut:
            return .timedOut

        case NSURLErrorCannotConnectToHost, NSURLErrorNetworkConnectionLost, NSURLErrorNotConnectedToInternet:
            return .noNetwork

        case NSURLErrorCancelled:
            return .cancelled

        default:
            return .unknown
        }
    }

    func baseUrl(for service: APIService) -> String {
        switch service.serviceType {
        case .api:
            return environment.apiBase
        }
    }
}
