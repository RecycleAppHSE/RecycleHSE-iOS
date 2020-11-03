//
//  WasteTypeModel.swift
//  Recycle
//
//  Created by Babaev Mikhail on 13.10.2020.
//

import UIKit

struct WasteTypeModel {
    
    // MARK: - Properties
    
    private let type: WasteType
    
    // MARK: - Init
    
    init(type: WasteType) {
        self.type = type
    }
    
    // MARK: Computed properties
    
    var title: String {
        switch type {
        case .paper:
            return "Бумага"
        case .glass:
            return "Стекло"
        case .plastic:
            return "Пластик"
        case .metal:
            return "Метал"
        case .clothes:
            return "Одежда"
        case .lamps:
            return "Лампы"
        case .toxic:
            return "Опасные\nотходы"
        case .appliances:
            return "Бытовая\nтехника"
        case .tetraPack:
            return "Tetra\nPak"
        case .batteries:
            return "Батарейки"
            
        default:
            return type.rawValue
        }
    }
    
    var image: UIImage {
        switch type {
        case .paper:
            return #imageLiteral(resourceName: "paper-mini")
        case .glass:
            return #imageLiteral(resourceName: "glass-mini")
        case .plastic:
            return #imageLiteral(resourceName: "plastic-mini")
        case .metal:
            return #imageLiteral(resourceName: "metal-mini")
        case .clothes:
            return #imageLiteral(resourceName: "clothes-mini")
        case .lamps:
            return #imageLiteral(resourceName: "lamps-mini")
        case .toxic:
            return #imageLiteral(resourceName: "danger-mini")
        case .appliances:
            return #imageLiteral(resourceName: "washing-machine-mini")
        case .batteries:
            return #imageLiteral(resourceName: "power-mini")
        default:
            return #imageLiteral(resourceName: "cancel")
        }
    }
}
