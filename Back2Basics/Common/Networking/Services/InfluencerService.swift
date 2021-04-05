//
//  BillboardService.swift
//  ARSkyline
//
//  Created by Adam Sterrett on 2/14/21.
//

import Foundation
import MapKit

enum InfluencerService: APIService, Equatable {
    
    case fetchNearbyInfluencers(CLLocation)
    case fetchFeaturedInfluencers

    var path: String {
        switch self {
        case .fetchNearbyInfluencers:
            return "/nearbyInfluencer"
        case .fetchFeaturedInfluencers:
            return "/fetchFeaturedInfluencers"

        }
    }

    var parameters: ServerParameters? {
        switch self {
        case .fetchNearbyInfluencers(let deviceLocation):
            return ["latitude": "\(String(describing: deviceLocation.coordinate.latitude))",
                    "longitude": "\(String(describing: deviceLocation.coordinate.longitude))"]
        case .fetchFeaturedInfluencers:
            return [:]
        }
    }

    var method: NetworkMethod {
        return .get
    }

    var serviceType: ServiceType {
        return .api
    }

    var shouldAddCommonHeaders: Bool {
        return true
    }
}
