//
//  UserService.swift
//  Recycle
//
//  Created by Babaev Mikhail on 03.11.2020.
//

import Foundation

protocol UserService {
    
    func createUserIfNeeded(_ callback: ResultCallback<Void>?)
    func getUser(callback: @escaping ResultCallback<User>)
    func updateName(_ name: String, _ callback: @escaping ResultCallback<Void>)
}

class UserServiceImp {
    
    let api: ApiClient
    let store: KeyValueStore
    
    init(api: ApiClient,
         store: KeyValueStore) {
        self.api = api
        self.store = store
    }
}

extension UserServiceImp: UserService {
    
    private struct UserResponse: Decodable {
        let userId: Int
    }
    
    func createUserIfNeeded(_ callback: ResultCallback<Void>?) {
        guard store.userId == 0 else {
            callback?(.success)
            return
        }
        
        api.request("new_user", method: .get) { [weak self] (result: Result<UserResponse, Error>) in
            switch result {
            case .success(let response):
                self?.store.userId = response.userId
                callback?(.success)
            case .failure(let error):
                callback?(.failure(error))
            }
        }
    }
    
    func getUser(callback: @escaping ResultCallback<User>) {
        api.request("me") { (result: Result<User, Error>) in
            callback(result)
        }
    }
    
    func updateName(_ name: String, _ callback: @escaping ResultCallback<Void>) {
        let body = ChangeNameBody(changeTo: name)
        
        api.request("change_name", method: .post, params: [:], body: body) {
            (result: Result<EmptyResponse, Error>) in
            switch result {
            case .success:
                callback(.success)
            case .failure(let error):
                callback(.failure(error))
            }
        }
    }
}

private extension UserServiceImp {
    
    struct ChangeNameBody: Encodable {
        let changeTo: String
    }
}
