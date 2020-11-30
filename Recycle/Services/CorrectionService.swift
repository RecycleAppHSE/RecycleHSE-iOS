//
//  CorrectionService.swift
//  Recycle
//
//  Created by Babaev Mikhail on 30.11.2020.
//

import Foundation

protocol CorrectionService {
    
    func suggestCorrection(id: Int,
                           types: [WasteType],
                           callback: @escaping ResultCallback<Int>)
    
    func suggestCorrection(id: Int,
                           status: RecyclePointStatus,
                           callback: @escaping ResultCallback<Int>)
}

struct CorrectionServiceImp {
    
    let api: ApiClient
}

extension CorrectionServiceImp: CorrectionService {
    
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
}

private extension CorrectionServiceImp {
    
    struct CorrectionResponse: Decodable {
        let correctionId: Int
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
}
