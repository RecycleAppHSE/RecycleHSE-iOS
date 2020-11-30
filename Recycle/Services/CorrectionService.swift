//
//  CorrectionService.swift
//  Recycle
//
//  Created by Babaev Mikhail on 30.11.2020.
//

import Foundation

protocol CorrectionService {
    
    func suggestCorrection(id: String,
                           types: [WasteType],
                           callback: @escaping ResultCallback<String>)
}

struct CorrectionServiceImp {
    
    let api: ApiClient
}

extension CorrectionServiceImp: CorrectionService {
    
    func suggestCorrection(id: String, types: [WasteType], callback: @escaping ResultCallback<String>) {
        api.request("correction/suggest", method: .post) { (result: Result<CorrectionResponse, Error>) in
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
        let correctionId: String
    }
    
    struct TypesCorrectionBody: Encodable {
        let pointId: Int
        let changeTo: [WasteType]
        
        let field = "recycle"
    }
}
