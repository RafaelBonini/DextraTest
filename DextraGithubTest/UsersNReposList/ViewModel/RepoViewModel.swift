//
//  RepoViewModel.swift
//  DextraGithubTest
//
//  Created by Rafael Bonini on 9/22/19.
//  Copyright © 2019 Rafael Bonini. All rights reserved.
//

import Foundation


struct RepoViewModel{
    
    let name: String
    let acessStatus: String
    let language: String
    let createdAt: String
    let updatedAt: String
    let userImageUrl: String
    let repoUrl: String

    init(repo: Repo){
        self.name = repo.name ?? ""
        self.acessStatus = repo.priv ?? false ? "Private" : "Public"
        self.language = repo.language ?? ""
        self.createdAt = repo.createdAt?.getFormatedDate() ?? ""
        self.updatedAt = repo.updatedAt?.getFormatedDate() ?? ""
        self.userImageUrl = repo.owner?.avatarUrl ?? ""
        self.repoUrl = repo.htmlUrl ?? ""
    }
}

