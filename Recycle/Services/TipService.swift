//
//  TipService.swift
//  Recycle
//
//  Created by Babaev Mikhail on 15.12.2020.
//

import Foundation

protocol TipService {
    
    func loadTipsCollections(callback: @escaping ResultCallback<[TipsCollection]>)
    
    func loadTips(collectionId: Int,
                  callback: @escaping ResultCallback<[Tip]>)
}

struct TipServiceImp {
    let api: ApiClient
}

extension TipServiceImp: TipService {
    
    func loadTipsCollections(callback: @escaping ResultCallback<[TipsCollection]>) {
        api.request("tip/collections") { (result: Result<TipsCollecitonsResponse, Error>) in
            switch result {
            case .success(let response):
                callback(.success(response.collections))
            case .failure(let error):
                callback(.failure(error))
            }
        }
    }
    
    func loadTips(collectionId: Int, callback: @escaping ResultCallback<[Tip]>) {
        api.request("tip/\(collectionId)") { (result: Result<TipCollectionResponse, Error>) in
            switch result {
            case .success(let response):
                callback(.success(response.tips))
            case .failure(let error):
                callback(.failure(error))
            }
        }
    }
}
