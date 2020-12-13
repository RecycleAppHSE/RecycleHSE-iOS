//
//  UIView+Stack.swift
//  Recycle
//
//  Created by Babaev Mikhail on 14.12.2020.
//

import UIKit
 
extension UIView {
    
    var isHiddenInStackView: Bool {
        set {
            if newValue != isHidden {
                isHidden = newValue
            }
        }
        get {
            isHidden
        }
    }
}
