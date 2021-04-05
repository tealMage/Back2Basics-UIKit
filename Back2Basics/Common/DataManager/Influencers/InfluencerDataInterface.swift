//
//  InfluencersDataInterface.swift
//  ExpertChow
//
//  Created by Adam Sterrett on 3/9/21.
//

import Foundation
import RxSwift
import RxCocoa

protocol InfluencerDataInterface {
    func fetchNearbyInfluencers() -> Single<[Influencer]>
}
