//
//  PointService.swift
//  Recycle
//
//  Created by Babaev Mikhail on 03.11.2020.
//

import Foundation

protocol PointService {
    
    func point(with id: String) -> RecyclePoint?
    
    func loadPoints(_ callback: @escaping ResultCallback<[RecyclePoint]>)
}

class PointServiceImp {
    
    let api: ApiClient
    
    var pointStore: [String : RecyclePoint] = [:]
    
    init(api: ApiClient) {
        self.api = api
    }
}

extension PointServiceImp: PointService {
    
    func point(with id: String) -> RecyclePoint? {
        pointStore[id]
    }
    
    func loadPoints(_ callback: @escaping ResultCallback<[RecyclePoint]>) {
        api.request("point") {
            [weak self] (result: Result<[RecyclePoint], Error>) in
            switch result {
            case .success(let points):
                self?.pointStore = [:]
                for point in points {
                    self?.pointStore[point.id] = point
                }
            case .failure:
                break
            }
            
            callback(result)
        }
    }
}

