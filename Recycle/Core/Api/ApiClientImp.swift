//
//  ApiClient.swift
//  Recycle
//
//  Created by Babaev Mikhail on 02.11.2020.
//

typealias HTTPMethod = Alamofire.HTTPMethod

import Alamofire
import Foundation

class ApiClientImp {
    
    let decoder: JSONDecoder
    let encoder: JSONEncoder
    let store: KeyValueStore
    
    let baseUrl = "http://165.227.166.231:8080/"
    
    init(decoder: JSONDecoder,
         encoder: JSONEncoder,
         store: KeyValueStore) {
        self.decoder = decoder
        self.encoder = encoder
        self.store = store
    }
}

extension ApiClientImp: ApiClient {
    
    func request<T: Decodable, Body: Encodable>(
        _ path: String,
        method: HTTPMethod,
        params: [String : Any],
        body: Body?,
        _ callback: ResultCallback<T>?) {
        
        let headers: HTTPHeaders = .init([
            .init(name: "USER_ID", value: String(store.userId ?? 0))
        ])
        
        let url = baseUrl + path
        
        AF.request(
            url,
            method: method,
            parameters: body,
            encoder: JSONParameterEncoder(encoder: encoder),
            headers: headers
        ).validate().responseDecodable(of: T.self, decoder: decoder) { response in
            guard let value = response.value else {
                let error = response.error ?? AFError.invalidURL(url: path)
                callback?(.failure(error))
                return
            }
            
            callback?(.success(value))
        }
    }
}
