//
//  Cancellable.swift
//  Recycle
//
//  Created by Babaev Mikhail on 17.11.2020.
//

import Alamofire

protocol Cancellable {
    
    @discardableResult
    func cancel() -> Self
}

extension DataRequest: Cancellable {
    
}
