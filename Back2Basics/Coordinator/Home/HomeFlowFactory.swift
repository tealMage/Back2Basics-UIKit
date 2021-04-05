//
//  HomeFlowFactory.swift
//  ARSkyline
//
//  Created by Adam Sterrett on 2/14/21.
//

import Foundation

struct HomeFlowFactory {
    private let influencerDataInterface: InfluencerDataInterface
    private let locationManagerInterface: LocationManagerInterface
    private let activityIndicator: ActivityIndicator
    private let alertController: AlertController

    init(influencerDataInterface: InfluencerDataInterface, locationManagerInterface: LocationManagerInterface, activityIndicator: ActivityIndicator, alertController: AlertController) {
        self.influencerDataInterface = influencerDataInterface
        self.locationManagerInterface = locationManagerInterface
        self.alertController = alertController
        self.activityIndicator = activityIndicator
    }

    func homeViewController(in coordinator: HomeFlowCoordinator) -> HomeViewController {
        let viewModel = HomeViewModel(homeCoordinator: coordinator, influencerDataInterface: influencerDataInterface, locationManagerInterface: locationManagerInterface)
        return HomeViewController(viewModel: viewModel, alertController: alertController, activityIndicator: activityIndicator)
    }

    func influencerViewController(in coordinator: HomeFlowCoordinator, influencer: Influencer) -> InfluencerViewController {
        let viewModel = InfluencerViewModel(homeCoordinator: coordinator, influencer: influencer)

        let viewController = InfluencerViewController(viewModel: viewModel,
                                                  alertController: alertController,
                                                  activityIndicator: activityIndicator)

        return viewController
    }
}
