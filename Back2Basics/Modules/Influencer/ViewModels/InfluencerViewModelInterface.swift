//
//  ViewerViewModelInterface.swift
//  ARSkyline
//
//  Created by Adam Sterrett on 3/8/21.
//

import Foundation
import RxCocoa
import CoreLocation

protocol InfluencerViewModelInterface {
    var influencer: Influencer { get }
    func closeInfluencerView()
}
