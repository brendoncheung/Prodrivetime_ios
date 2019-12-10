//
//  Endpoints.swift
//  Prodrivetime_ios
//
//  Created by Wing Sun Cheung on 11/12/19.
//  Copyright © 2019 Wing Sun Cheung. All rights reserved.
//

import Foundation

struct Endpoints {
    
    static let baseUrl = ""
    
    static let loginEndpoint = "/api/mobileApi/mobileDriverLogin" // email, password, firebasetoken
    
    static let requestLoadEndpoint = "api/driverApi/driverRequestLoad" // driverEmail

    static let acceptLoadApi = "api/mobileApi/mobileDriverAcceptLoad" // requestId, driverEmail, driverId
    
    static let logoutEndpoint = "controls/logout.php"

    static let companyInfoEndpoint = "api/mobileApi/clientInfo.php" // clientEmail

    static let loadHistoryEndpoint = "api/mobileApi/driverMobileHistory.php" // driverEmail
    
    static let supportEmailEndpoint = "services/sendSupportEmail"
    
}
