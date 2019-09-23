//
//  Dictionary.swift
//  DextraGithubTest
//
//  Created by Rafael Bonini on 9/21/19.
//  Copyright © 2019 Rafael Bonini. All rights reserved.
//

import Foundation

extension Dictionary {
    
    var json: String {
        let invalidJson = "Not a valid JSON"
        do {
            let jsonData = try JSONSerialization.data(withJSONObject: self, options: .prettyPrinted)
            return String(bytes: jsonData, encoding: String.Encoding.utf8) ?? invalidJson
        } catch {
            return invalidJson
        }
    }
    
    func printJson() {
        print(json)
    }
    
}
