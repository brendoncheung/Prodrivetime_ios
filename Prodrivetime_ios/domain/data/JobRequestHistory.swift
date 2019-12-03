//
//  JobRequestHistory.swift
//  Prodrivetime_ios
//
//  Created by Wing Sun Cheung on 11/30/19.
//  Copyright © 2019 Wing Sun Cheung. All rights reserved.
//

import Foundation

struct JobRequestHistory: Decodable {
    
    let id: Int
    let request_id: String
    let final_id: String
    let businessName: String
    let businessEmail: String
    let driverEmail: String
    let driverName: String
    let title: String
    let details: String
    let loadDescription: String
    let offering: String
    let pickupAddresss: String
    let dropoffAddress: String
    let mandatoryDate: String
    let timeStamp: String
    let loadWeight: String
    
    private enum CodingKeys: String, CodingKey {
        
        case id = "id"
        case request_id = "request_id"
        case final_id = "final_id"
        case businessName = "business_name"
        case businessEmail = "business_email"
        case driverEmail = "driver_email"
        case driverName = "driver_name"
        case title = "title"
        case details = "details"
        case loadDescription = "load_description"
        case offering = "amount_offered"
        case pickupAddresss = "pickup_address"
        case dropoffAddress = "dropoff_address"
        case timeStamp = "timestamp"
        case mandatoryDate = "load_mandatory_date"
        case loadWeight = "load_weight"
        
        
    }
}
