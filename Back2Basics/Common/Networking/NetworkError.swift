//
//  NetworkError.swift
//  ARSkyline
//
//  Created by Adam Sterrett on 2/14/21.
//

import Foundation

enum NetworkError: Error, LocalizedError {
    case cancelled
    case invalidRequestParameters
    case invalidResponse
    case noNetwork
    case timedOut
    case message(String)
    case unknown

    var errorDescription: String? {
        switch self {
        case .cancelled:
            return NSLocalizedString("Error_Request_Cancelled",
                                     comment: "Request cancelled error")

        case .noNetwork, .timedOut:
            return NSLocalizedString("Alert_Network_No_Connection",
                                     comment: "Message displayed when the user does not have a network connection")

        case .invalidRequestParameters,
             .invalidResponse,
             .unknown:
            return NSLocalizedString("Error_unknown",
                                     comment: "Unknown Network Error")
            
        case .message(let message):
            return message
        }
    }
}

extension NetworkError: Equatable {
    static func == (lhs: NetworkError, rhs: NetworkError) -> Bool {
        switch (lhs, rhs) {
        case (.cancelled, .cancelled),
             (.invalidRequestParameters, .invalidRequestParameters),
             (.invalidResponse, .invalidResponse),
             (.noNetwork, .noNetwork),
             (.timedOut, .timedOut),
             (.unknown, .unknown):
            return true

        case (.message(let message1), .message(let message2)):
            return message1 == message2

        default:
            return false
        }
    }
}
