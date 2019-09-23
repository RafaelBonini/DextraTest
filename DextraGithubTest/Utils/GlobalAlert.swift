//
//  GlobalAlert.swift
//  DextraGithubTest
//
//  Created by Rafael Bonini on 9/22/19.
//  Copyright © 2019 Rafael Bonini. All rights reserved.
//

import Foundation
import UIKit


struct GlobalAlert {
    let controller: UIViewController
    let msg: String
    let confirmButton: Bool
    let confirmAndCancelButton: Bool
    let url: String
    let title: String
    
    init(with controller: UIViewController, msg: String, confirmButton: Bool = true,
         confirmAndCancelButton: Bool = false, url: String = "",title: String = "") {
        self.controller = controller
        self.msg = msg
        self.confirmButton = confirmButton
        self.confirmAndCancelButton = confirmAndCancelButton
        self.url = url
        self.title = title
    }
    
    func showAlert() {
        let alert = UIAlertController(title: "Warning", message: self.msg, preferredStyle: UIAlertController.Style.alert)
        let confirmAction = UIAlertAction(title: "Ok", style: .default, handler: nil)
        alert.addAction(confirmAction)
        self.controller.present(alert, animated: true, completion: nil)
    }
    
    func showAlertForUrl(){
        let alert = UIAlertController(title: self.title, message: self.msg, preferredStyle: UIAlertController.Style.alert)
        
            alert.addAction(UIAlertAction(title: "ok", style: .default, handler: { (action) in
                
                if let url = URL(string: self.url) {
                    UIApplication.shared.open(url)
                }

            }))
            alert.addAction(UIAlertAction(title: "cancel", style: .cancel, handler: { (action) in
            }))
     
        self.controller.present(alert, animated: true, completion: nil)
    }
    
}
