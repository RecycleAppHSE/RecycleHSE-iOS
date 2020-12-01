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
    
    var location: CLLocation? { get }
    
    func requestAuth()
}

class LocationManagerImp: NSObject {
    
    weak var delegate: LocationManagerDelegate?
    
    private (set) var location: CLLocation?
    private let manager: CLLocationManager
    
    init(manager: CLLocationManager = CLLocationManager()) {
        self.manager = manager
    }
}

extension LocationManagerImp: LocationManager {
    
    func requestAuth() {
        manager.delegate = self
    
        manager.requestWhenInUseAuthorization()
        startMonitoting()
    }
}

extension LocationManagerImp: CLLocationManagerDelegate {
    
    func locationManagerDidChangeAuthorization(_ manager: CLLocationManager) {
        if #available(iOS 14.0, *) {
            switch manager.authorizationStatus {
            case .authorizedWhenInUse:
                startMonitoting()
            default:
                break
            }
        } else {
            startMonitoting()
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let location = locations.last else {
            return
        }
        
        self.location = location
        delegate?.didUpdateLocation(location)
    }
}

private extension LocationManagerImp {
    
    func startMonitoting() {
        
        manager.startMonitoringSignificantLocationChanges()
        manager.startUpdatingLocation()
    }
}
