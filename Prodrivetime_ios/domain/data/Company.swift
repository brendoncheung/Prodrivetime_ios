//
//  Company.swift
//  Prodrivetime_ios
//
//  Created by Wing Sun Cheung on 11/26/19.
//  Copyright © 2019 Wing Sun Cheung. All rights reserved.
//

import Foundation

struct Company: Decodable {
    
    let name: String
    let email: String
    let phone: String
    
    init(name: String, email: String, phone: String) {
        self.name = name
        self.email = email
        self.phone = phone
        
    }
    
    private enum CodingKeys: String, CodingKey {
        case name = "name"
        case email = "email_addr"
        case phone = "number"
    }

    
    
}
