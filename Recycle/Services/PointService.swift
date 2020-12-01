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
    
    func searchPoint(text: String,
                     callback: @escaping ResultCallback<[RecyclePoint]>)
}

class PointServiceImp {
    
    private let api: ApiClient
    
    private var pointStore: [Int : RecyclePoint] = [:]
    private var searchRequest: Cancellable?
    
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
    
    func searchPoint(text: String,
                     callback: @escaping ResultCallback<[RecyclePoint]>) {
        searchRequest?.cancel()
        
        api.request("search", params: ["q" : text]) { (result: Result<PointsResponse, Error>) in
            switch result {
            case .success(let response):
                let points = response.points
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
