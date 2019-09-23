//
//  UserViewModel.swift
//  DextraGithubTest
//
//  Created by Rafael Bonini on 9/21/19.
//  Copyright © 2019 Rafael Bonini. All rights reserved.
//

import Foundation


protocol UserReqViewModelProtocol {
    
    func getUsers(since id:Int, onCompletion: @escaping([User]) -> Void,
                  onError: @escaping(_ msg: String) -> Void)
    func getRepos(for userName: String, onCompletion: @escaping([Repo]) -> Void,
                  onError: @escaping(_ msg: String) -> Void)
}

class UserReqViewModel: UserReqViewModelProtocol {
    
    //MARK:- Requests
    
    //get users since x id
    func getUsers(since id: Int, onCompletion: @escaping ([User]) -> Void, onError: @escaping (String) -> Void) {
        
        let params: [String:Any] = [:]
        
        Api().requestCodable(metodo: .GET, url: URLs.getUsers(since: id), objeto: Array<User>.self, parametros: params, onSuccess: { (reponse, result) in
            
            onCompletion(result)
            
        }) { (response, msg) in
            onError(msg)
        }
        
    }
    
    //get repos for user
    func getRepos(for userName: String, onCompletion: @escaping ([Repo]) -> Void, onError: @escaping (String) -> Void) {
        
        let params: [String: Any] = [:]
        
        Api().requestCodable(metodo: .GET, url: URLs.getRepos(for: userName), objeto: Array<Repo>.self, parametros: params, onSuccess: { (response, result) in
            
            onCompletion(result)
            
        }) { (response, msg) in
            onError(msg)
        }
    }
}
