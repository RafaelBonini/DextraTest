//
//  UIView.swift
//  DextraGithubTest
//
//  Created by Rafael Bonini on 9/22/19.
//  Copyright © 2019 Rafael Bonini. All rights reserved.
//

import UIKit

extension UIView{
    func dropShadow(opacity: Float, radius: CGFloat, offSetWidth: CGFloat = 0, offSetHeight: CGFloat = 0) {
        self.layer.masksToBounds = false
        self.layer.shadowColor = UIColor.black.cgColor
        self.layer.shadowOpacity = opacity
        self.layer.shadowRadius = radius
        self.layer.shadowOffset = CGSize(width: offSetWidth, height: offSetHeight)
    }
}
