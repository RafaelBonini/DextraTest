//
//  URLs.swift
//  DextraGithubTest
//
//  Created by Rafael Bonini on 9/21/19.
//  Copyright © 2019 Rafael Bonini. All rights reserved.
//

import Foundation

enum URLs{
    
    static let baseURL = "https://api.github.com"
    
    static var apiEndPoint : String {
        get {
            let val = "\(URLs.baseURL)"
            return val
        }
    }
    
    
    
    //MARK:- Users
    //list of users from index
    static func getUsers(since id: Int) -> String {
        return "\(URLs.apiEndPoint)/users?since=\(id)"
    }
    
    //MARK:- Repos
    //list of owned repos for user
    static func getRepos(for userName: String) -> String {
        return "\(URLs.apiEndPoint)/users/\(userName)/repos?type=owner"
    }
}
