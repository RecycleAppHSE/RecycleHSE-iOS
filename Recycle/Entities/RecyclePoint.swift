//
//  RecyclePoint.swift
//  Recycle
//
//  Created by Babaev Mikhail on 13.10.2020.
//

import Foundation


enum RecyclePointStatus: String, Decodable {
    case open = "works_fine"
    case broken
    case closed = "would_not_work"
}

struct RecyclePoint: Decodable {
    
    let id: String
    let organization: String
    let phoneNumber: String
    let webSite: URL
    let wasteTypes: [WasteType]
    
    let latitude: Double
    let longitude: Double
    
    let status: RecyclePointStatus
    let lastUpdated: Date
    
    let schedule: Schedule?
    let correctionsCount: Int
}

extension RecyclePoint {
    
    enum CodingKeys: String, CodingKey {
        case id
        case organization = "name"
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
    
    //{
    //    "id": 21
    //    "name": "Pokrovsky bulvar 2",
    //    "phone_number": "+74994001041",
    //    "web_site": "https://www.hse.ru/",
    //    "recycle": ["metal", "glass", "plastic", "paper"],
    //    "latitude": 38.8951,
    //    "longitude": -77.0364,
    //    "works":  "broken" | "would_not_work" | "works_fine",
    //    "last_updated": 1604343073
    //    "schedule":{
    //        "from": "09:00",
    //        "to": "17:00"
    //     },
    //    "corrections_count": 2
    //  }
}
