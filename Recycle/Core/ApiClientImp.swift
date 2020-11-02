//
//  ApiClient.swift
//  Recycle
//
//  Created by Babaev Mikhail on 02.11.2020.
//

typealias HTTPMethod = Alamofire.HTTPMethod

import Alamofire
import Foundation

protocol ApiClient {
    
    func request<T: Decodable>(
        _ path: String,
        method: HTTPMethod,
        params: [String : Any],
        _ callback: ResultCallback<T>
    )
    
    func request<T: Decodable, Body: Encodable>(
        _ path: String,
        method: HTTPMethod,
        params: [String : Any],
        body: Body?,
        _ callback: ResultCallback<T>
    )
}

extension ApiClient {
    
    func request<T: Decodable>(
        _ path: String
        params: [String : Any],
        _ callback: ResultCallback<T>
    ) {
        request(path, params: [:], callback)
    }
}

class ApiClientImp {
    
    let decoder: JSONDecoder
    
    init(decoder: JSONDecoder) {
        self.decoder = decoder
    }
}

extension ApiClientImp: ApiClient {
    
    func request<T: Decodable>(
        _ path: String,
        method: HTTPMethod,
        params: [String : Any],
        _ callback: ResultCallback<T>) {
        AF.request(path, method: method, parameters: params).responseDecodable(of: T.self) { response in
            guard let value = response.value else {
                let error = response.error ?? AFError.invalidURL(url: path)
                callback(.failure(error))
                return
            }
            
            callback(.success(value))
        }
    }
    
    func request<T, Body>(_ path: String, method: HTTPMethod, params: [String : Any], body: Body?, _ callback: (Result<T, Error>) -> Void) where T : Decodable, Body : Encodable {
        // TODO:
    }
}
