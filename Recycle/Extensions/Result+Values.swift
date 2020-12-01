//
//  Result+Values.swift
//  Recycle
//
//  Created by Babaev Mikhail on 03.11.2020.
//

import Foundation

extension Result {
    
    var value: Success? {
        return try? get()
    }
    
    var error: Failure? {
        switch self {
        case .success:
            return nil
        case .failure(let error):
            return error
        }
    }
}

extension Result where Success == Void {
    
    static var success: Result {
        return .success(())
    }
}
