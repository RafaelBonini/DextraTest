//
//  ReposTableViewCell.swift
//  DextraGithubTest
//
//  Created by Rafael Bonini on 9/22/19.
//  Copyright © 2019 Rafael Bonini. All rights reserved.
//

import Foundation
import UIKit

class ReposTableViewCell: UITableViewCell{
    
    @IBOutlet weak var repoName: UILabel!
    @IBOutlet weak var languageLabel: UILabel!
    @IBOutlet weak var privacyTypeLabel: UILabel!
    @IBOutlet weak var createdDateLabel: UILabel!
    @IBOutlet weak var lastUpdatedLabel: UILabel!
    
    
    var repoViewModel: RepoViewModel!{
        didSet{
            repoName.text = repoViewModel.name
            languageLabel.text = repoViewModel.language
            privacyTypeLabel.text = repoViewModel.acessStatus
            createdDateLabel.text = repoViewModel.createdAt
            lastUpdatedLabel.text = repoViewModel.updatedAt
        }
    }

}
