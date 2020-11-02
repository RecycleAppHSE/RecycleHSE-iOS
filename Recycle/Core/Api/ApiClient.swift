//
//  ApiClient.swift
//  Recycle
//
//  Created by Babaev Mikhail on 02.11.2020.
//

import Foundation

protocol ApiClient {
    
    func request<T: Decodable, Body: Encodable>(
        _ path: String,
        method: HTTPMethod,
        params: [String : Any],
        body: Body?,
        _ callback: ResultCallback<T>?
    )
}

extension ApiClient {
    
    func request<T: Decodable>(
        _ path: String,
        _ callback: ResultCallback<T>?
    ) {
        request(path, method: .get, params: [:], body: String?.none, callback)
    }
    
    func request<T: Decodable>(
        _ path: String,
        method: HTTPMethod,
        _ callback: ResultCallback<T>?
    ) {
        request(path, method: method, params: [:], body: String?.none, callback)
    }
}
