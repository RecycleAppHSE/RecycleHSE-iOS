//
//  CorrectionService.swift
//  Recycle
//
//  Created by Babaev Mikhail on 30.11.2020.
//

import Foundation



protocol CorrectionService {
    
    func wasLiked(id: Int) -> Bool
    func wasUnliked(id: Int) -> Bool
    
    
    func suggestCorrection(id: Int,
                           types: [WasteType],
                           callback: @escaping ResultCallback<Int>)
    
    func suggestCorrection(id: Int,
                           status: RecyclePointStatus,
                           callback: @escaping ResultCallback<Int>)
    
    func loadCorrections(pointId: Int,
                         callback: @escaping ResultCallback<[Correction]>)
    
    func loadCorrections(ids: [Int],
                         callback: @escaping ResultCallback<[Correction]>)
    
    func set(isLiked: Int,
             for id: Int,
             callback: @escaping ResultCallback<Void>)
}

struct CorrectionServiceImp {
    
    let api: ApiClient
    
    static var liked: [Int] = []
    static var unliked: [Int] = []
}

extension CorrectionServiceImp: CorrectionService {
    
    func wasLiked(id: Int) -> Bool {
        Self.liked.contains(id)
    }
    
    func wasUnliked(id: Int) -> Bool {
        Self.unliked.contains(id)
    }
    
    func suggestCorrection(id: Int, types: [WasteType], callback: @escaping ResultCallback<Int>) {
        let body = TypesCorrectionBody(pointId: id, changeTo: types)
        api.request("correction/suggest", method: .post, params: [:], body: body) { (result: Result<CorrectionResponse, Error>) in
            switch result {
            case .success(let response):
                callback(.success(response.correctionId))
            case .failure(let error):
                callback(.failure(error))
            }
        }
    }
    
    func suggestCorrection(id: Int, status: RecyclePointStatus, callback: @escaping ResultCallback<Int>) {
        let body = StatusCorrectionBody(pointId: id, changeTo: status)
        api.request("correction/suggest", method: .post, params: [:], body: body) { (result: Result<CorrectionResponse, Error>) in
            switch result {
            case .success(let response):
                callback(.success(response.correctionId))
            case .failure(let error):
                callback(.failure(error))
            }
        }
    }
    
    func loadCorrections(pointId: Int,
                         callback: @escaping ResultCallback<[Correction]>) {
        api.request("point/\(pointId)/corrections") { (result: Result<CorrectionListResponse, Error>) in
            switch result {
            case .success(let response):
                callback(.success(response.corrections))
            case .failure(let error):
                callback(.failure(error))
            }
        }
    }
    
    func loadCorrections(ids: [Int],
                         callback: @escaping ResultCallback<[Correction]>) {
        let group = DispatchGroup()
        var corrections: [Correction] = []
        var error: Error?
        
        for id in ids {
            group.enter()
            loadCorrection(id: id) { result in
                switch result {
                case .success(let correction):
                    corrections.append(correction)
                case .failure(let requestError):
                    error = requestError
                }
                group.leave()
            }
        }
        
        group.notify(queue: .main) {
            if let error = error {
                callback(.failure(error))
            } else {
                callback(.success(corrections))
            }
        }
    }
    
    func loadCorrection(id: Int,
                        callback: @escaping ResultCallback<Correction>) {
        api.request("correction/\(id)", callback)
    }
    
    func set(isLiked: Int, for id: Int, callback: @escaping ResultCallback<Void>) {
        let body = LikeBody(like: isLiked)
        api.request("correction/\(id)/like", method: .post, params: [:], body: body) {
            (result: Result<EmptyResponse, Error>) in
            switch result {
            case .success:
                if isLiked == 1 {
                    Self.liked.append(id)
                    Self.unliked.removeAll { $0 == id }
                }
                
                if isLiked == -1  {
                    Self.unliked.append(id)
                    Self.liked.removeAll { $0 == id }
                }
                
                if isLiked == 0 {
                    Self.liked.removeAll { $0 == id }
                    Self.unliked.removeAll { $0 == id }
                }
                
                callback(.success)
            case .failure(let error):
                callback(.failure(error))
            }
        }
    }
}

private extension CorrectionServiceImp {
    
    struct CorrectionResponse: Decodable {
        let correctionId: Int
    }
    
    struct CorrectionListResponse: Decodable {
        let corrections: [Correction]
    }
    
    struct TypesCorrectionBody: Encodable {
        let pointId: Int
        let changeTo: [WasteType]
        
        let field = "recycle"
    }
    
    struct StatusCorrectionBody: Encodable {
        let pointId: Int
        let changeTo: RecyclePointStatus
        
        let field = "works"
    }
    
    struct LikeBody: Encodable {
        let like: Int
    }
}
