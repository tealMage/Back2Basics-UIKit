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
        // Remove to test api
        return Single.just([Influencer(guid: "dsafsadf", name: "leet", description: "Influencer looking for the best food dishes ", url: URL(string: "https://scx1.b-cdn.net/csz/news/800a/2016/howcuttingdo.jpg")!)])
        // Real API Call
        //        guard let location = locationManagerInterface.deviceLocation, location.horizontalAccuracy > 0 else {
        //            return serverClient.request(InfluencerService.fetchFeaturedInfluencers)
        //          }
        //        return serverClient.request(InfluencerService.fetchNearbyInfluencers(location))
    }
}
 
