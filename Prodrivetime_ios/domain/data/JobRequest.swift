//
//  JobRequest.swift
//  Prodrivetime_ios
//
//  Created by Wing Sun Cheung on 11/18/19.
//  Copyright © 2019 Wing Sun Cheung. All rights reserved.
//

import Foundation

struct JobRequest: Codable, Equatable {
    
    let id: Int
    let requestID: String
    let businessName: String
    let businessEmail: String
    let title: String
    let detail: String
    let loadDescription: String
    let price: String
    let pickupAddress: String
    let dropOffAddress: String
    let timestamp: String
    let deliveryDate: String
    let loadWeight: String
    
    init(id: Int, requestID: String, businessName: String, businessEmail: String, title: String, detail: String, loadDescription: String, price: String, pickupAddress: String, dropOffAddress: String, timestamp: String, deliveryDate: String, loadWeight: String) {
        
        self.id = id
        self.requestID = requestID
        self.businessName = businessName
        self.businessEmail = businessEmail
        self.title = title
        self.detail = detail
        self.loadDescription = loadDescription
        self.price = price
        self.pickupAddress = pickupAddress
        self.dropOffAddress = dropOffAddress
        self.timestamp = timestamp
        self.deliveryDate = deliveryDate
        self.loadWeight = loadWeight
    }
    
    private enum CodingKeys: String, CodingKey {
        case id = "id"
        case requestID = "request_id"
        case businessName = "business_name"
        case businessEmail = "business_email"
        case title = "title"
        case detail = "details"
        case loadDescription = "load_description"
        case price = "amount_offered"
        case pickupAddress = "pickup_address"
        case dropOffAddress = "dropoff_address"
        case timestamp = "timestamp"
        case deliveryDate = "mandatory_delivery_date"
        case loadWeight = "load_weight"
    }
    
    static func ==(lhs: JobRequest, rhs: JobRequest) -> Bool {
        return lhs.requestID == rhs.requestID
    }
    
//    var id: Int?
//    var requestID: String?
//    var businessName: String?
//    var businessEmail: String?
//    var title: String?
//    var detail: String?
//    var loadDescription: String?
//    var price: String?
//    var pickupAddress: String?
//    var dropOffAddress: String?
//    var timestamp: String?
//
//    private enum CodingKeys: String, CodingKey {
//        case id = "id"
//        case requestID = "request_id"
//        case businessName = "business_name"
//        case businessEmail = "business_email"
//        case title = "title"
//        case detail = "details"
//        case loadDescription = "load_description"
//        case price = "amount_offered"
//        case pickupAddress = "pickup_address"
//        case dropOffAddress = "dropoff_address"
//        case timestamp = "timestamp"
//    }
}
