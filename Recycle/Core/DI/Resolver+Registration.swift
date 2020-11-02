//
//  Resolver+Registration.swift
//  Recycle
//
//  Created by Babaev Mikhail on 02.11.2020.
//

import Foundation

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
            PointServiceImp(
                api: self.resolve()
            )
        }
        
        // MARK: - Core

        add(type: JSONDecoder.self) {
            let decoder = JSONDecoder()
            decoder.keyDecodingStrategy = .convertFromSnakeCase
            return decoder
        }
        
        add(type: ApiClient.self) {
            return ApiClientImp(
                decoder: self.resolve(),
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
