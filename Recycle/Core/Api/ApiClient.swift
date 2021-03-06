//
//  ApiClient.swift
//  Recycle
//
//  Created by Babaev Mikhail on 02.11.2020.
//

import Foundation

protocol ApiClient {
    
    @discardableResult
    func request<T: Decodable, Body: Encodable>(
        _ path: String,
        method: HTTPMethod,
        params: [String : Any],
        body: Body?,
        _ callback: ResultCallback<T>?
    ) -> Cancellable
}

extension ApiClient {
    
    @discardableResult
    func request<T: Decodable>(
        _ path: String,
        _ callback: ResultCallback<T>?
    ) -> Cancellable {
        return request(path, method: .get, params: [:], body: String?.none, callback)
    }
    
    @discardableResult
    func request<T: Decodable>(
        _ path: String,
        method: HTTPMethod,
        _ callback: ResultCallback<T>?
    ) -> Cancellable {
        return request(path, method: method, params: [:], body: String?.none, callback)
    }
    
    @discardableResult
    func request<T: Decodable>(
        _ path: String,
        params: [String : Any],
        _ callback: ResultCallback<T>?
    ) -> Cancellable {
        return request(path, method: .get, params: params, body: String?.none, callback)
    }
}
