//
//  TipsCollection.swift
//  Recycle
//
//  Created by Babaev Mikhail on 15.12.2020.
//

import Foundation

//"collections" : [ {
//    "id" : 1,
//    "title" : "Как утилизировать правильно?",
//    "tips_number" : 1
//  }, {

struct TipsCollecitonsResponse: Decodable {
    let collections: [TipsCollection]
}

struct TipsCollection: Decodable {
    
    let id: Int
    let title: String
    let tipsNumber: Int
}
//
//"id" : 1,
//    "collection_id" : 1,
//    "title" : "Раздельный сбор мусора: как правильно сортировать отходы для переработки?",
//    "content" : "У"
//  }

struct TipCollectionResponse: Decodable {
    let tips: [Tip]
}

struct Tip: Decodable {
    let id: Int
    let colllectionId: Int
    let title: String
    let content: String
}
