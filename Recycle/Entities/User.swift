//
//  User.swift
//  Recycle
//
//  Created by Babaev Mikhail on 03.11.2020.
//

import Foundation

struct User: Decodable {
    
    struct Corrections: Decodable {
        let approved: [String]
        let notApproved: [String]
        
        var approvedCount: Int {
            approved.count
        }
        
        var notApprovedCount: Int {
            notApproved.count
        }
        
        var totalCount: Int {
            approvedCount + notApprovedCount
        }
    }
    
    let id: Int
    let name: String?
    let correctionIds: Corrections
    
    enum CodingKeys: String, CodingKey {
        case id
        case name
        case correctionIds = "collectionPointsCorrectionsIds"
    }
}
