//
//  HomeCoordinator.swift
//  ARSkyline
//
//  Created by Adam Sterrett on 2/14/21.
//

import Foundation

protocol HomeCoordinator: Coordinator {
    func showInfluencer(_ influencer: Influencer)
    func closeInfluencer()
}
