//
//  HomeFlowCoordinator.swift
//  ARSkyline
//
//  Created by Adam Sterrett on 2/14/21.
//

import Foundation
import UIKit

class HomeFlowCoordinator: HomeCoordinator {

    private let factory: HomeFlowFactory
    private let navigationController: UINavigationController?
    private var childCoordinators: [Coordinator] = []

    init(factory: HomeFlowFactory,
         navigationController: UINavigationController) {
        self.factory = factory
        self.navigationController = navigationController
    }

    @discardableResult func start() -> Bool {
        let startClosure = {
            let viewController = self.factory.homeViewController(in: self)
            self.navigationController?.pushViewController(viewController, animated: true)
        }

        startClosure()

        return true
    }

    func showInfluencer(_ influencer: Influencer) {
        let viewController = factory.influencerViewController(in: self, influencer: influencer)
        navigationController?.pushViewController(viewController, animated: true)
    }

    func closeInfluencer() {
        navigationController?.popViewController(animated: true)
    }
}
