//
//  GitHubUser.swift
//  DextraGithubTest
//
//  Created by Rafael Bonini on 9/21/19.
//  Copyright © 2019 Rafael Bonini. All rights reserved.
//

import Foundation

struct User: Codable{
    
    let login: String?
    let id: Int?
    let nodeId: String?
    let avatarUrl: String?
    let gravatarId: String?
    let url: String?
    let htmlUrl: String?
    let followersUrl: String?
    let followingUrl: String?
    let gistsUrl: String?
    let starredUrl: String?
    let subscriptionsUrl: String?
    let organizationsUrl: String?
    let reposUrl: String?
    let eventsUrl: String?
    let receivedEventsUrl: String?
    let type: String?
    let siteAdmin: Bool?
    
    enum CodingKeys: String, CodingKey {
        
        case id, gravatarId = "gravatar_id", nodeId = "nodeId"
        case login
        case type, siteAdmin = "site_admin"
        case url, htmlUrl = "html_url", followersUrl = "followers_url", followingUrl = "following_url"
        case gistsUrl = "gists_url", receivedEventsUrl = "received_events_url", eventsUrl = "events_url"
        case avatarUrl = "avatar_url", starredUrl = "starred_url", subscriptionsUrl = "subscriptions_url"
        case organizationsUrl = "organizations_url", reposUrl = "repos_url"
    }
}
