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
    let store: KeyValueStore
    
    let baseUrl = "http://165.227.166.231:8080/"
    
    init(decoder: JSONDecoder,
         store: KeyValueStore) {
        self.decoder = decoder
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
        
        let encoding: ParameterEncoding = body != nil ? JSONEncoding.default : URLEncoding.default
        
        let headers: HTTPHeaders = .init([
            .init(name: "USER_ID", value: String(store.userId ?? 0))
        ])
        
        let url = baseUrl + path
        
        AF.request(
            url,
            method: method,
            parameters: params,
            encoding: encoding,
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
