//
//  BillboardDataManager.swift
//  ExpertChow
//
//  Created by Adam Sterrett on 3/9/21.
//

import Foundation
import RxSwift

struct InfluencerDataManager: InfluencerDataInterface {
    private let serverClient: ServerClient
    private let locationManagerInterface: LocationManagerInterface
    private let disposeBag = DisposeBag()

    init(
        serverClient: ServerClient,
        locationManagerInterface: LocationManagerInterface
    ) {
        self.serverClient = serverClient
        self.locationManagerInterface = locationManagerInterface
    }

    func fetchNearbyInfluencers() -> Single<[Influencer]> {
      guard let location = locationManagerInterface.deviceLocation else {
        return serverClient.request(InfluencerService.fetchFeaturedInfluencers)
      }

      return serverClient.request(InfluencerService.fetchNearbyInfluencers(location))
    }
}
 
