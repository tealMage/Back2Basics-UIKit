//
//  AppFlowFactory.swift
//  ARSkyline
//
//  Created by Adam Sterrett on 2/14/21.
//

import Foundation
import UIKit

struct AppFlowFactory {

    private let influencerDataInterface: InfluencerDataInterface
    let locationManagerInterface: LocationManagerInterface
    private let alertController = AlertViewAlertController()
    private let activityIndicator: ActivityIndicator

    init () {
    
        let environment = AppEnvironment()
        let networkIndicatorInterface = NetworkIndicatorService()
        let serviceClient = APIClient(environment: environment, networkIndicatorInterface: networkIndicatorInterface)
        let locationManager = LocationManager()
        locationManagerInterface = locationManager
        
        activityIndicator = StandardActivityIndicator()

        influencerDataInterface = InfluencerDataManager(serverClient: serviceClient, locationManagerInterface: locationManager)
    }
    
    func homeCoordinator(navigationController: UINavigationController) -> HomeFlowCoordinator {
        let factory = HomeFlowFactory(influencerDataInterface: influencerDataInterface, locationManagerInterface: locationManagerInterface, activityIndicator: activityIndicator, alertController: alertController)
        
        return HomeFlowCoordinator(factory: factory, navigationController: navigationController)
    }
}
