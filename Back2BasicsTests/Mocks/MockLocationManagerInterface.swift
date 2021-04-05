//
//  MockLocationManagerInterface.swift
//  Back2BasicsTests
//
//  Created by Adam Sterrett on 4/4/21.
//

import Foundation
import RxCocoa
import RxSwift
import CoreLocation

@testable import Back2Basics

class MockLocationManagerInterface: LocationManagerInterface {
    
    var didCallShowLocationServicesDisabledAlert = false
    var didCallStartLocationUpdates = false
    var didCallStopLocationUpdates = false
    var didShowFullAccuracyRequest = false
    var didShowDenyPreciseLocationAlert = false

    var locationAvailableRelay = PublishRelay<Bool>()
    var locationUpdatedRelay = PublishRelay<Void>()

    var deviceLocation: CLLocation?
    var userLocationString: String?
    var userPlacemark: CLPlacemark?
    var horizontalAccuracy = 0.0

    var monitoredRegions = Set<CLRegion>()

    var locationServicesEnabled = false
    var locationServicesAllowAlwaysEnabled = false
    var locationServicesPermissionIsUndetermined = false
    
    var authorizationStatusString = ""
    var preciseLocationEnabled = false
    var searchedLocation: CLLocation?

    func isLastLocation(greaterThan date: Date) -> Bool { return false }

  
    func startUpdatingLocation() { didCallStartLocationUpdates = true }
    func stopUpdatingLocation() { didCallStopLocationUpdates = true }
}
