//
//  WasteType.swift
//  Recycle
//
//  Created by Babaev Mikhail on 13.10.2020.
//


enum WasteType: String, Codable, CaseIterable {
    case
    paper,
    glass,
    plastic,
    metal,
    clothes,
    lamps = "light_bulbs",
        
    tetraPack = "tetra_pack",
    toxic,
    appliances, // Техника
    batteries,
        
    tires, // шины
    caps, 
    other
    
    var isUnknown: Bool {
        return false
        
//        switch self {
//        case .tires, .caps, .other:
//            return true
//        default:
//            return false
//        }
    }
}

