//
//  RecyclePoint.swift
//  Recycle
//
//  Created by Babaev Mikhail on 13.10.2020.
//

import Foundation


enum RecyclePointStatus: String, Codable {
    case open = "works_fine"
    case broken
    case closed = "would_not_work"
}

struct RecyclePoint: Decodable {
    
    let id: Int
    let name: String
    let address: String?
    let phoneNumber: String?
    let webSite: URL?
    var wasteTypes: [WasteType]
    
    let latitude: Double
    let longitude: Double
    
    var status: RecyclePointStatus
    let lastUpdated: Date
    
    let schedule: Schedule?
    var correctionsCount: Int
     
    static let empty: RecyclePoint = {
        RecyclePoint(id: 0, name: "", address: nil, phoneNumber: nil, webSite: nil, wasteTypes: [], latitude: 0, longitude: 0, status: .closed, lastUpdated: Date(), schedule: nil, correctionsCount: 0)
    }()
}

extension RecyclePoint {
    
    enum CodingKeys: String, CodingKey {
        case id
        case name
        case address
        case phoneNumber
        case webSite
        case wasteTypes = "recycle"
        case latitude
        case longitude
        case status = "works"
        case lastUpdated
        case schedule
        case correctionsCount
    }
}
