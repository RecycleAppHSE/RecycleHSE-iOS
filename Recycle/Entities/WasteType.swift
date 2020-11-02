//
//  WasteType.swift
//  Recycle
//
//  Created by Babaev Mikhail on 13.10.2020.
//


enum WasteType: String, Decodable {
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
}

