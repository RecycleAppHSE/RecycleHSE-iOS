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
    
    let baseUrl = "http://165.227.116.231:8080/"
    
    init(decoder: JSONDecoder) {
        self.decoder = decoder
    }
}

extension ApiClientImp: ApiClient {
    
    func request<T: Decodable, Body: Encodable>(
        _ path: String,
        method: HTTPMethod,
        params: [String : Any],
        body: Body?,
        _ callback: ResultCallback<T>?) {
        
        // TODO: handle body
        
        let url = baseUrl + path
        AF.request(path, method: method, parameters: params).responseDecodable(of: T.self) { response in
            guard let value = response.value else {
                let error = response.error ?? AFError.invalidURL(url: path)
                callback?(.failure(error))
                return
            }
            
            callback?(.success(value))
        }
    }
}
