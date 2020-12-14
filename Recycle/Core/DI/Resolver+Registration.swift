//
//  Resolver+Registration.swift
//  Recycle
//
//  Created by Babaev Mikhail on 02.11.2020.
//

import Foundation
import CoreLocation
import UIKit

var sharedPointService: PointService!

extension Resolver {
    
    func registerDependencies() {
        
        // MARK: - Services
        
        add(type: LocationManager.self) {
            return LocationManagerImp()
        }
        
        add(type: UserService.self) {
            UserServiceImp(
                api: self.resolve(),
                store: self.resolve()
            )
        }
        
        add(type: PointService.self) {
            if sharedPointService == nil {
                sharedPointService = PointServiceImp(
                    api: self.resolve()
                )
            }
            
            return sharedPointService
        }
        
        add(type: CorrectionService.self) {
            CorrectionServiceImp(
                api: self.resolve()
            )
        }
        
        add(type: AppHelper.self) {
            AppHelperImp(
                application: UIApplication.shared
            )
        }
        
        // MARK: - Core
        
        add(type: CLGeocoder.self) {
            CLGeocoder()
        }

        add(type: JSONDecoder.self) {
            let decoder = JSONDecoder()
            decoder.keyDecodingStrategy = .convertFromSnakeCase
            return decoder
        }
        
        add(type: JSONEncoder.self) {
            let encoder = JSONEncoder()
            encoder.keyEncodingStrategy = .convertToSnakeCase
            return encoder
        }
        
        add(type: ApiClient.self) {
            return ApiClientImp(
                decoder: self.resolve(),
                encoder: self.resolve(),
                store: self.resolve()
            )
        }
        
        add(type: KeyValueStore.self) {
            return KeyValueStoreImp(
                defaults: .standard
            )
        }
    }
}
