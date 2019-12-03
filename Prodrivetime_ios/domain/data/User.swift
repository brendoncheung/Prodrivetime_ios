//
//  User.swift
//  Prodrivetime_ios
//
//  Created by Wing Sun Cheung on 11/12/19.
//  Copyright © 2019 Wing Sun Cheung. All rights reserved.
//

import Foundation

struct User: Codable, Equatable {

    var driverId: String
    var name: String?
    var email: String?
    var phoneNumber: String?
    var city: String?
    var state: String?
    var experience: Int?
    
    private enum CodingKeys: String, CodingKey {
        
        case driverId = "driver_id"
        case name = "name"
        case email = "email"
        case phoneNumber = "phone"
        case city = "city"
        case state = "state"
        case experience = "experience"
        
    }
    
    public static func == (lhs: User, rhs: User) -> Bool {
        
        let bool: Bool
        
        if (rhs.driverId == lhs.driverId) {
            bool = true
        } else {
            bool = false
        }
        return bool
    }
    
}
