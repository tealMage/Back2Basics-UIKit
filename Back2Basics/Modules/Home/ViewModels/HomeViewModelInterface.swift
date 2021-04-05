//
//  HomeViewModelInterface.swift
//  arskyline
//
//  Created by Adam Sterrett on 2/9/21.
//

import Foundation
import RxCocoa
import CoreLocation

typealias InfluencersResult = ViewModelResult<[Influencer]>

protocol HomeViewModelInterface {
    var influencerFetchResult: PublishRelay<InfluencersResult> { get }
    func didSelectInfluencer(_ influencer: Influencer, viewController: UIViewController)
    func refreshData()
}
