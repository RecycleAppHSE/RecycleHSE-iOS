//
//  User.swift
//  Recycle
//
//  Created by Babaev Mikhail on 03.11.2020.
//

import Foundation

struct User: Decodable {
    
    struct Corrections: Decodable {
        var applied: [Int]
        var inProgress: [Int]
        var rejected: [Int]
        
        var appliedCount: Int {
            applied.count
        }
        
        var inProgressCount: Int {
            inProgress.count
        }
        
        var totalCount: Int {
            appliedCount + inProgressCount
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
