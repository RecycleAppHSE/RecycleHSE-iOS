//
//  User.swift
//  Recycle
//
//  Created by Babaev Mikhail on 03.11.2020.
//

import Foundation

struct User: Decodable {
    
    struct Corrections: Decodable {
        var approved: [Int]
        var inProgress: [Int]
        var rejected: [Int]
        
        var all: [Int] {
            var result = [Int]()
            result.append(contentsOf: approved)
            result.append(contentsOf: inProgress)
            result.append(contentsOf: rejected)
            return result
        }
        
        var appliedCount: Int {
            approved.count
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
