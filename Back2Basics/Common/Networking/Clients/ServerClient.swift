//
//  ServerClient.swift
//  ARSkyline
//
//  Created by Adam Sterrett on 2/14/21.
//

import Foundation
import RxSwift

typealias ServerParameters = [String: Any]

protocol ServerClient {
    func request<T: Decodable>(_ service: APIService) -> Single<T>
}
