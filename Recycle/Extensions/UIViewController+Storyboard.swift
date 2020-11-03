//
//  UIViewController+Storyboard.swift
//  Recycle
//
//  Created by Babaev Mikhail on 03.11.2020.
//

import UIKit


extension UIViewController {
    
    static var storyboardId: String {
        return String(describing: self)
    }
    
    class var storyboardName: String {
        return storyboardId.replacingOccurrences(of: "ViewController", with: "")
    }
}

extension UIViewController {
    
     func create<VC: UIViewController>(
        storyboardName: String = VC.storyboardName,
        storyboardId: String = VC.storyboardId) -> VC {
        
           let storyboard = UIStoryboard(name: storyboardName, bundle: nil)
           let controller = storyboard.instantiateViewController(withIdentifier: storyboardId)
           return controller as! VC
       }
}
