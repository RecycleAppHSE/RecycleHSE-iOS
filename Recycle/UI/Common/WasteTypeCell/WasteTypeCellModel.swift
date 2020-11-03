//
//  WasteCellModel.swift
//  Recycle
//
//  Created by Babaev Mikhail on 13.10.2020.
//

import UIKit

enum WasteCellMode {
    case selectable, readOnly
}

struct WasteTypeCellModel {
    
    // MARK: - Properties
    
    let title: String
    let titleColor: UIColor?
    let image: UIImage
    let tickImage: UIImage?
    let hideTick: Bool
    let backgroundColor: UIColor?
    
    // MARK: - Init
    
    init(wasteType: WasteType, hideTitle: Bool) {
        let wasteModel = WasteTypeModel(type: wasteType)
        self.image = wasteModel.image
        title = wasteModel.title
        titleColor = hideTitle ? .clear : .textGray
        tickImage = nil
        hideTick = true
        backgroundColor = .clear
    }
    
    init(waste: WasteType,
         isSelected: Bool,
         mode: WasteCellMode) {
        tickImage = isSelected ? #imageLiteral(resourceName: "tick-selected") : #imageLiteral(resourceName: "tick-unselected")
        
        let wasteModel = WasteTypeModel(type: waste)
        title = wasteModel.title
        image = wasteModel.image
        
        titleColor = isSelected ? .white : .textGray
        
        switch mode {
        case .readOnly:
            hideTick = true
            backgroundColor = isSelected ? .main : .clear
            
        case .selectable:
            hideTick = false
            backgroundColor = isSelected ? .green : .wasteBackground
        }
    }
    
    var identifier: String {
        "WasteTypeCell"
    }
}
