//
//  LocationManager.swift
//  ExpertChow
//
//  Created by Adam Sterrett on 3/9/21.
//

import Foundation
import CoreLocation
import RxCocoa
import RxSwift

class LocationManager: NSObject, LocationManagerInterface {

    private let locationManager: CLLocationManager
    private let disposeBag = DisposeBag()
    private var isUpdatingLocations = false

    private(set) var locationAvailableRelay = PublishRelay<Bool>()
    private(set) var locationUpdatedRelay = PublishRelay<Void>()
    private(set) var deviceLocation: CLLocation?

    var horizontalAccuracy: Double {
        return deviceLocation?.horizontalAccuracy ?? 0.0
    }

    var locationServicesPermissionIsUndetermined: Bool {
        return CLLocationManager.authorizationStatus() == .notDetermined
    }

    var locationServicesEnabled: Bool {
        guard CLLocationManager.locationServicesEnabled() else { return false }

        return CLLocationManager.authorizationStatus() == .authorizedAlways ||
            CLLocationManager.authorizationStatus() == .authorizedWhenInUse
    }

    var locationServicesAllowAlwaysEnabled: Bool {
        guard CLLocationManager.locationServicesEnabled() else { return false }
        return CLLocationManager.authorizationStatus() == .authorizedAlways
    }

    var authorizationStatusString: String {
        switch CLLocationManager.authorizationStatus() {
        case .authorizedAlways:
            return "Always"

        case .authorizedWhenInUse:
            return "When In Use"

        case .denied, .notDetermined, .restricted:
            return "Never"

        @unknown default:
            return "Never"
        }
    }

    var monitoredRegions: Set<CLRegion> {
        return locationManager.monitoredRegions
    }

    private var shouldRequestLocationAuthorization: Bool {
        guard CLLocationManager.locationServicesEnabled(),
            CLLocationManager.authorizationStatus() == .notDetermined else {
                return false
        }

        return true
    }

    override init() {
        self.locationManager = CLLocationManager()

        super.init()

        locationManager.desiredAccuracy = kCLLocationAccuracyNearestTenMeters
        locationManager.pausesLocationUpdatesAutomatically = false
        locationManager.distanceFilter = 0.1
        locationManager.delegate = self
    }

    func startUpdatingLocation() {
        isUpdatingLocations = true

        if shouldRequestLocationAuthorization {
            requestLocationServicesIfNeeded()
        } else {
            locationManager.startUpdatingLocation()
        }
    }

    func stopUpdatingLocation() {
        guard isUpdatingLocations else { return }

        isUpdatingLocations = false
        locationManager.stopUpdatingLocation()
    }
}

private extension LocationManager {
    func requestLocationServicesIfNeeded() {
        if shouldRequestLocationAuthorization {
            locationManager.requestAlwaysAuthorization()
        }
    }
}

extension LocationManager: CLLocationManagerDelegate {
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let location = locations.last else { return }
        guard Date().timeIntervalSince(location.timestamp) < 5.0 else { return }

        deviceLocation = location

        locationUpdatedRelay.accept(())
    }

    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
    }
    
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {

        if shouldRequestLocationAuthorization && isUpdatingLocations {
            requestLocationServicesIfNeeded()
        } else {
            if locationServicesEnabled && isUpdatingLocations {
                startUpdatingLocation()
            }

            // Need to clear the location, so a stale location is not used when location services are disabled
            // or the location permissions change.
            if locationServicesEnabled == false {
                deviceLocation = nil
            }

            locationAvailableRelay.accept(locationServicesEnabled)
        }
    }
}
