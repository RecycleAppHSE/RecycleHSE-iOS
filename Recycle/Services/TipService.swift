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
//        api.request("tip/collections") { (result: Result<TipsCollecitonsResponse, Error>) in
//            switch result {
//            case .success(let response):
//                callback(.success(response.collections))
//            case .failure(let error):
//                callback(.failure(error))
//            }
//        }
        
        let tips = [
            TipsCollection(id: 1, title: "Tip title #1", tipsNumber: 2),
            TipsCollection(id: 2, title: "Tip title #2", tipsNumber: 2)
        ]
        
        callback(.success(tips))
    }
    
    func loadTips(collectionId: Int, callback: @escaping ResultCallback<[Tip]>) {
//        api.request("tip/\(collectionId)") { (result: Result<TipCollectionResponse, Error>) in
//            switch result {
//            case .success(let response):
//                callback(.success(response.tips))
//            case .failure(let error):
//                callback(.failure(error))
//            }
//        }
        
        let tips = [
            Tip(id: 0, title: "Tip title #1", content: "Tip content 1Tip content 1Tip content 1Tip content 1Tip content 1Tip content 1Tip content 1Tip content 1Tip content 1Tip content 1Tip content 1Tip content 1Tip content 1Tip content 1Tip content 1Tip content 1"),
            Tip(id: 1, title: "Tip title #2", content: "Long tip content 2 Long tip content 2 Long tip content 2 Long tip content 2 Long tip content 2 Long tip content 2 Long tip content 2 Long tip content 2 Long tip content 2 Long tip content 2 ")
        ]
        
        callback(.success(tips))
    }
}
