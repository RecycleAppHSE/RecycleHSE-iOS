//
//  LocationManager.swift
//  Recycle
//
//  Created by Babaev Mikhail on 13.10.2020.
//

import Foundation
import CoreLocation

protocol LocationManagerDelegate: AnyObject {
    func didUpdateLocation(_ location: CLLocation)
}

protocol LocationManager: AnyObject {
    
    var delegate: LocationManagerDelegate? { get set }
    
    func requestAuth()
}

class LocationManagerImp: NSObject {
    
    weak var delegate: LocationManagerDelegate?
    
    private let manager: CLLocationManager
    
    init(manager: CLLocationManager = CLLocationManager()) {
        self.manager = manager
    }
}

extension LocationManagerImp: LocationManager {
    
    func requestAuth() {
        manager.requestWhenInUseAuthorization()
    }
}

extension LocationManagerImp: CLLocationManagerDelegate {
    
    func locationManagerDidChangeAuthorization(_ manager: CLLocationManager) {
        if #available(iOS 14.0, *) {
            switch manager.authorizationStatus {
            case .authorizedWhenInUse:
                manager.startMonitoringSignificantLocationChanges()
                manager.startUpdatingLocation()
            default:
                break
            }
        } else {
            manager.startMonitoringSignificantLocationChanges()
            manager.startUpdatingLocation()
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let location = locations.last else {
            return
        }
        
        delegate?.didUpdateLocation(location)
    }
}

private extension LocationManagerImp {
    
    func startMonitoting() {
        
    }
}
