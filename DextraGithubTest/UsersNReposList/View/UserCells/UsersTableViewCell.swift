//
//  UsersTableViewCell.swift
//  DextraGithubTest
//
//  Created by Rafael Bonini on 9/21/19.
//  Copyright © 2019 Rafael Bonini. All rights reserved.
//

import Foundation
import UIKit
import SDWebImage

class UsersTableViewCell: UITableViewCell{
    
    @IBOutlet weak var userImage: UIImageView!
    @IBOutlet weak var userLoginLabel: UILabel!
    @IBOutlet weak var userTypeLabel: UILabel!
    @IBOutlet weak var imageLoadingIndicator: UIActivityIndicatorView!
    
    
    var userViewModel: UserViewModel!{
        
        didSet{
            userLoginLabel.text = userViewModel.login
            userTypeLabel.text = userViewModel.type
            
            imageLoadingIndicator.isHidden = false
            imageLoadingIndicator.alpha = 1
            imageLoadingIndicator.startAnimating()
            
            userImage.sd_setImage(with:  URL(string: userViewModel.imageUrl)) { [unowned self] image, Error, cache, URL in
                self.imageLoadingIndicator.stopAnimating()
                self.imageLoadingIndicator.isHidden = true
            }
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

}
