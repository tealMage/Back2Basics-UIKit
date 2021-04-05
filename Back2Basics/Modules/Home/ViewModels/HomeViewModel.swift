//
//  HomeViewModel.swift
//  arskyline
//
//  Created by Adam Sterrett on 2/9/21.
//

import Foundation
import RxSwift
import RxCocoa
import CoreLocation

class HomeViewModel: HomeViewModelInterface {

    private let influencerDataInterface: InfluencerDataInterface
    
    private(set) var influencerFetchResult = PublishRelay<InfluencersResult>()
    private let locationManagerInterface: LocationManagerInterface
    private var locationSubscription: Disposable?
    
    private let disposeBag = DisposeBag()
    private let mainScheduler: SchedulerType
    
    private var influencer: [Influencer] = []
    private var currentLocation: CLLocation?
    private var didSetCurrentLocation = false
    
    private weak var homeCoordinator: HomeCoordinator?

    init(homeCoordinator: HomeCoordinator,
         influencerDataInterface: InfluencerDataInterface,
         locationManagerInterface: LocationManagerInterface,
         mainScheduler: SchedulerType = MainScheduler()) {
        self.homeCoordinator = homeCoordinator
        self.influencerDataInterface = influencerDataInterface
        self.locationManagerInterface = locationManagerInterface
        self.mainScheduler = mainScheduler
        self.startMonitoringLocations()
        self.refreshData()
        
        locationManagerInterface.startUpdatingLocation()
    }
    
    func refreshData() {
        fetchLocation()
    }
    
    func fetchLocation() {
        influencerDataInterface.fetchNearbyInfluencers()
        .asObservable()
        .observe(on: mainScheduler)
        .withUnretained(self)
        .subscribe(with: self) { owner, locations in
            owner.influencerFetchResult.accept(.loaded(locations.1))
        } onError: { owner, error in
            owner.influencerFetchResult.accept(.failed(error.localizedDescription))
         }
         .disposed(by: disposeBag)
    
    }
    
    func didSelectInfluencer(_ influencer: Influencer, viewController: UIViewController) {
        homeCoordinator?.showInfluencer(influencer)
    }
    
    func startMonitoringLocations() {
        locationSubscription = locationManagerInterface.locationUpdatedRelay
            .filter({ [weak self] _ -> Bool in
                guard let strongSelf = self else { return false }
                return strongSelf.locationManagerInterface.deviceLocation != nil
            })
            .subscribe(onNext: { [weak self] _ in
                self?.refreshData()
            })
    }

    func stopMonitoringLocation() {
        locationSubscription?.dispose()
    }
}
