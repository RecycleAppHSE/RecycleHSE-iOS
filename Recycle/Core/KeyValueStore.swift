//
//  KeyValueStore.swift
//  Recycle
//
//  Created by Babaev Mikhail on 03.11.2020.
//

import Foundation

protocol KeyValueStore: AnyObject {
    
    var userId: String? { get set }
}

class KeyValueStoreImp {
    
    let defaults: UserDefaults
    
    init(defaults: UserDefaults) {
        self.defaults = defaults
    }
}

extension KeyValueStoreImp : KeyValueStore{
    
    var userId: String? {
        get {
            defaults.string(forKey: "userId")
        }
        set {
            defaults.setValue(newValue, forKey: "userId")
        }
    }
}
