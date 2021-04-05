//
//  LocationManagerInterface.swift
//  ExpertChow
//
//  Created by Adam Sterrett on 3/9/21.
//

import Foundation
import RxCocoa
import RxSwift
import MapKit

protocol LocationManagerInterface: class {
    var locationAvailableRelay: PublishRelay<Bool> { get }
       var locationUpdatedRelay: PublishRelay<Void> { get }

       var deviceLocation: CLLocation? { get }
       var horizontalAccuracy: Double { get }

       var locationServicesEnabled: Bool { get }
       var locationServicesAllowAlwaysEnabled: Bool { get }
       var locationServicesPermissionIsUndetermined: Bool { get }

       var authorizationStatusString: String { get }
       
       func startUpdatingLocation()
       func stopUpdatingLocation()
    
}
