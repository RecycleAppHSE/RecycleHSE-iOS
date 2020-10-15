//
//  RecyclePoint.swift
//  Recycle
//
//  Created by Babaev Mikhail on 13.10.2020.
//

import Foundation

enum RecyclePointStatus: String, Decodable {
    case open, broken
}

struct RecyclePoint: Decodable {
    
    let title: String
    let organization: String
    let status: RecyclePointStatus
    let statusLastUpdate: Date
    let wasteTypes: [WasteType]
}
