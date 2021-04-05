//
//  ViewerViewModel.swift
//  ARSkyline
//
//  Created by Adam Sterrett on 3/8/21.
//

import Foundation
import RxSwift
import RxCocoa
import CoreLocation

class InfluencerViewModel: InfluencerViewModelInterface {
  
    private let disposeBag = DisposeBag()
    private let mainScheduler: SchedulerType
        
    private weak var homeCoordinator: HomeCoordinator?
    
    let influencer: Influencer
    
    init(homeCoordinator: HomeCoordinator,
         mainScheduler: SchedulerType = MainScheduler(),
         influencer: Influencer) {
        self.homeCoordinator = homeCoordinator
        self.mainScheduler = mainScheduler
        self.influencer = influencer
    }

    func closeInfluencerView() {
        homeCoordinator?.closeInfluencer()
    }
}
