//
//  ErrorManager.swift
//  Recycle
//
//  Created by Babaev Mikhail on 03.11.2020.
//

import UIKit

protocol ErrorManager {
    
    func show(error: Error)
    
    func showRepeat()
}


extension UIViewController {
    
    func show(error: Error, repeatCallback: (() -> Void)? = nil) {
        let alert = UIAlertController(title: "Ошибка", message: "Произошла неизвестная ошибка", preferredStyle: .alert)
        
        if repeatCallback != nil {
            alert.addAction(UIAlertAction(title: "Повторить", style: .default, handler: { _ in
                repeatCallback?()
            }))
        } else {
            alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        }
        
        present(alert, animated: true, completion: nil)
    }
}
