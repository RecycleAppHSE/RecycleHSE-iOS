//
//  Correction.swift
//  Recycle
//
//  Created by Babaev Mikhail on 14.12.2020.
//

import Foundation
import UIKit

struct Correction {
    
    enum Status: String, Decodable {
        case inProgress = "in-progress"
        case approved
        case declined
        
        var text: String {
            switch self {
            case .inProgress:
                return "Не подтверждены"
            case .approved:
                return "Подтверждены"
            case .declined:
                return "Не подтверждены"
            }
        }
        
        var image: UIImage {
            switch self {
            case .inProgress:
                return #imageLiteral(resourceName: "clock")
            case .approved:
                return #imageLiteral(resourceName: "correctionTick")
            case .declined:
                return #imageLiteral(resourceName: "cross-correction")
            }
        }
    }
    
    let id: Int
    let pointId: Int
    let field: String
    
    let changeToTypes: [WasteType]
    let status: Status
    
    let submitTime: TimeInterval
    var likeCount: Int
    var dislikeCount: Int
    
    var isStatusMode: Bool = false
    var isSelf = false
}
