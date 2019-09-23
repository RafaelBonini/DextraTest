//
//  String.swift
//  DextraGithubTest
//
//  Created by Rafael Bonini on 9/22/19.
//  Copyright © 2019 Rafael Bonini. All rights reserved.
//

import Foundation

extension String{
    
    //receiving iso date(String) and returning in "MMM d, yyyy" format
    func getFormatedDate() -> String{
        
        let dateFormatter = DateFormatter()
        let locale = Locale(identifier: "en_US_POSIX")
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZ"
        dateFormatter.locale = locale
        let date = dateFormatter.date(from:self)!
        
        dateFormatter.dateFormat = "MMM d, yyyy"
        let newDate = dateFormatter.string(from: date)
        
        return newDate
    }
    
}
