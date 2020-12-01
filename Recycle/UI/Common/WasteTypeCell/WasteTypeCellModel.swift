//
//  WasteCellModel.swift
//  Recycle
//
//  Created by Babaev Mikhail on 13.10.2020.
//

import UIKit

enum WasteCellMode {
    case selectable, selectableBlue, readOnly
}

struct WasteTypeCellModel {
    
    // MARK: - Properties
    
    let title: String
    let titleColor: UIColor?
    let image: UIImage
    let tickImage: UIImage?
    let hideTick: Bool
    let backgroundColor: UIColor?
    let isSelected: Bool
    let type: WasteType
    let mode: WasteCellMode
    
    // MARK: - Init
    
    init(wasteType: WasteType, hideTitle: Bool) {
        let wasteModel = WasteTypeModel(type: wasteType)
        self.image = wasteModel.image
        self.mode = .readOnly
        title = wasteModel.title
        titleColor = hideTitle ? .clear : .textGray
        tickImage = nil
        hideTick = true
        backgroundColor = .clear
        isSelected = false
        type = wasteType
    }
    
    init(waste: WasteType,
         isSelected: Bool,
         mode: WasteCellMode) {
        self.mode = mode
        self.isSelected = isSelected
        self.type = waste
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
            backgroundColor = isSelected ? .main : .wasteBackground
            
        case .selectableBlue:
            hideTick = false
            backgroundColor = isSelected ? .buttonTint : .wasteBackground
        }
    }
    
    var identifier: String {
        "WasteTypeCell"
    }
}
