//
//  APIClient+Response.swift
//  ARSkyline
//
//  Created by Adam Sterrett on 2/14/21.
//

import Foundation
import RxSwift

extension APIClient {
    func handleResponse<T: Decodable>(request: URLRequest,
                                      response: URLResponse?,
                                      data: Data,
                                      single: (SingleEvent<T>) -> Void) {
        do {
            if let error = try errorForResponse(response, request: request, data: data) {
                single(.failure(error))
            } else {
                let object = try self.decoder.decode(T.self, from: data)
                single(.success(object))
            }
        } catch {
            single(.failure(NetworkError.invalidResponse))
        }
    }

}

private extension APIClient {

    func errorForResponse(_ response: URLResponse?, request: URLRequest, data: Data) throws -> NetworkError? {
        guard let response = response as? HTTPURLResponse else {
                fatalError("The response should not be nil!")
        }

        let statusCode = response.statusCode

        if statusCode >= 200 && statusCode <= 204 {
            return nil
        } else {
            if let message = try errorMessage(for: data) {
                return NetworkError.message(message)
            } else {
                return NetworkError.unknown
            }
        }
    }

    func errorMessage(for data: Data) throws -> String? {
        do {
            let object = try JSONSerialization.jsonObject(with: data, options: []) as? [String: Any]
            let errorMessage = object?["message"] as? String
            return errorMessage
        } catch {
            let errorString = String(data: data, encoding: .utf8)

            if let errorString = errorString, errorString.isEmpty == false {
                return errorString
            }

            throw error
        }
    }
}
