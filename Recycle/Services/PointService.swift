//
//  PointService.swift
//  Recycle
//
//  Created by Babaev Mikhail on 03.11.2020.
//

import Foundation

protocol PointService {
    
    func point(with id: Int) -> RecyclePoint?
    
    func loadPoints(_ callback: @escaping ResultCallback<[RecyclePoint]>)
}

class PointServiceImp {
    
    let api: ApiClient
    
    var pointStore: [Int : RecyclePoint] = [:]
    
    init(api: ApiClient) {
        self.api = api
    }
}

extension PointServiceImp: PointService {
    
    func point(with id: Int) -> RecyclePoint? {
        pointStore[id]
    }
    
    func loadPoints(_ callback: @escaping ResultCallback<[RecyclePoint]>) {
        api.request("point") {
            [weak self] (result: Result<PointsResponse, Error>) in
            switch result {
            case .success(let response):
                self?.pointStore = [:]
                let points = response.points
                for point in points {
                    self?.pointStore[point.id] = point
                }
                callback(.success(points))
            case .failure(let error):
                callback(.failure(error))
            }
        }
    }
}

private extension PointServiceImp {
        
    struct PointsResponse: Decodable {
        let points: [RecyclePoint]
    }
}
