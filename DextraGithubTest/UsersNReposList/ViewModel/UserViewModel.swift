//
//  UserViewModel.swift
//  DextraGithubTest
//
//  Created by Rafael Bonini on 9/22/19.
//  Copyright © 2019 Rafael Bonini. All rights reserved.
//

import Foundation

struct UserViewModel{
    let id: Int
    let login: String
    let type: String
    let imageUrl: String
    
    init(user: User){
        self.id = user.id ?? 0
        self.login = user.login ?? ""
        self.type = user.type ?? ""
        self.imageUrl = user.avatarUrl ?? ""
    }
}
