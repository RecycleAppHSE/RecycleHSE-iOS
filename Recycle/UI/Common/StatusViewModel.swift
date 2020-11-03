//
//  StatusViewModel.swift
//  Recycle
//
//  Created by Babaev Mikhail on 03.11.2020.
//

import Foundation
import UIKit

struct StatusViewModel {
    
    let image: UIImage
    let text: String
    let color: UIColor?
    
    init(status: RecyclePointStatus) {
        switch status {
        case .open:
            color = .main
            image = #imageLiteral(resourceName: "tick-mini")
        case .broken, .closed:
            color = .error
            image = #imageLiteral(resourceName: "cross-mini")
        }
        
        switch status {
        case .open:
            text = "Функционирует нормально!"
        case .broken:
            text = "Сломан!"
        case .closed:
            text = "Больше не работает!"
        }
    }
}
