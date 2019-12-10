//
//  URLRequestFactory.swift
//  Prodrivetime_ios
//
//  Created by Wing Sun Cheung on 11/14/19.
//  Copyright © 2019 Wing Sun Cheung. All rights reserved.
//

import Foundation

private enum API {
    case Login
    case Logoff
    case LoadRquest
    case AcceptRequest
    case LoadHistory
    case CompanyInfo
    case SupportEmail
}

class URLRequestFactory {
    
    private let BASE_URL_STRING = "https://www.prodrivetime.com"
    
    private var BASE_URL: URL?
    
    private let cachePolicy: URLRequest.CachePolicy
    private let timeInterval: TimeInterval
    
    init(policy: URLRequest.CachePolicy = URLRequest.CachePolicy.reloadIgnoringLocalAndRemoteCacheData,
         timeInterval: TimeInterval = TimeInterval(10)) {
        
        BASE_URL = URL(string: BASE_URL_STRING)
        self.cachePolicy = policy
        self.timeInterval = timeInterval
    }
    
    func createLoginURLRequest(email: String, pw: String, token: String) -> URLRequest? {

        let email_param = "email"
        let password_param = "password"
        let token_param = "firebaseToken"
        
        guard let url = createURL(api: .Login) else {
            log.debug("createLoginURLRequest failed")
            return nil
        }
        
        var request = createPOSTRequest(url: url)
        
        request.httpBody = "\(email_param)=\(email)&\(password_param)=\(pw)&\(token_param)=\(token)".data(using: .utf8)
        log.debug(token)
        
        return request
    }
    
    func createJobRequestURLRequest(email: String) -> URLRequest? {
        
        
        guard let url = createURL(api: .LoadRquest) else {
            log.debug("createJobRequestURLRequest failed")
            return nil
        }
        
        var request = createPOSTRequest(url: url)
        
        request.httpBody = "driverEmail=\(email)".data(using: .utf8)
        
        return request
        
    }
    
    func createAcceptJobRequestURLRequest(requestId: String, driverEmail: String, driverId: String) -> URLRequest? {
        
        guard let url = createURL(api: .AcceptRequest) else {
            log.debug("createAcceptJobRequestURLRequest failed")
            return nil
        }
        
        var request = createPOSTRequest(url: url)
        request.httpBody = "requestId=\(requestId)&driverEmail=\(driverEmail)&driverId=\(driverId)".data(using: .utf8)
        log.debug("requestId=\(requestId)&driverEmail=\(driverEmail)&driverId=\(driverId)")
        return request
        
    }
    
    func createJobRequestHistoryURLRequest(email: String) -> URLRequest? {
        guard let url = createURL(api: .LoadHistory) else {
            log.debug("createJobRequestHistoryURLRequest failed")
            return nil
        }
        
        var request = createPOSTRequest(url: url)
        request.httpBody = "driverEmail=\(email)".data(using: .utf8)
        
        return request
    }
    
    // FIXME: - the logout request should be a get
    
    func createUserLogOutURLRequest() -> URLRequest? {
        guard let url = createURL(api: .Logoff) else { return nil}
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        return request
    }
    
    func createFetchCompanyInfoURLRequest(companyEmail: String) -> URLRequest? {
        guard let url = createURL(api: .CompanyInfo) else { return nil }
        var request = createPOSTRequest(url: url)
        request.httpBody = "clientEmail=\(companyEmail)".data(using: .utf8)
        return request
    }
    
    func createSendSupportEmailURLRequest(subject: String, email: String, body: String) -> URLRequest? {
        
        guard let url = createURL(api: .SupportEmail) else { return nil}
        var request = createPOSTRequest(url: url)
        request.httpBody = "subject=\(subject)&email=\(email)&body=\(body)".data(using: .utf8)
        return request
    }
    
    fileprivate func createURL(api: API) -> URL? {
        
        switch api {
            
        case .Login :
            return URL(string: Endpoints.loginEndpoint, relativeTo: BASE_URL)
            
        case .Logoff :
            return URL(string: Endpoints.logoutEndpoint, relativeTo: BASE_URL)
            
        case .LoadRquest :
            return URL(string: Endpoints.requestLoadEndpoint, relativeTo: BASE_URL)
            
        case .LoadHistory :
            return URL(string: Endpoints.loadHistoryEndpoint, relativeTo: BASE_URL)
            
        case .AcceptRequest :
            return URL(string: Endpoints.acceptLoadApi, relativeTo: BASE_URL)
            
        case .CompanyInfo :
            return URL(string: Endpoints.companyInfoEndpoint, relativeTo: BASE_URL)
            
        case .SupportEmail :
            return URL(string: Endpoints.supportEmailEndpoint, relativeTo: BASE_URL)
        }
    }
    
    private func createPOSTRequest(url: URL) -> URLRequest {
        var request = URLRequest(url: url, cachePolicy: cachePolicy, timeoutInterval: timeInterval)
        request.httpMethod = "POST"
        request.setValue("application/x-www-form-urlencoded", forHTTPHeaderField: "Content-Type")
        return request
    }
}


























