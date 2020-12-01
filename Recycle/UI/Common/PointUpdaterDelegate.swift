//
//  PointDelegate.swift
//  Recycle
//
//  Created by Babaev Mikhail on 30.11.2020.
//

import Foundation

protocol PointUpdaterDelegate: AnyObject {
    
    func didUpdatePoint(_ point: RecyclePoint)
}
