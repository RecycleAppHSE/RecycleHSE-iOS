//
//  SearchCellModel.swift
//  Recycle
//
//  Created by Babaev Mikhail on 16.11.2020.
//

import Foundation

struct SearchCellModel {
    
    let title: String
    let text: String?
    
    init(point: RecyclePoint) {
        title = point.name
        text = point.address
    }
}
