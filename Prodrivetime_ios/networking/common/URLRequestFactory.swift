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
        let token_param = "token"
        
        guard let url = createURL(api: .Login) else {
            print("createLoginURLRequest failed")
            return nil
        }
        
        var request = createPOSTRequest(url: url)
        
        request.httpBody = "\(email_param)=\(email)&\(password_param)=\(pw)&\(token_param)=\(token)".data(using: .utf8)
        
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
        }
    }
    
    private func createPOSTRequest(url: URL) -> URLRequest {
        var request = URLRequest(url: url, cachePolicy: cachePolicy, timeoutInterval: timeInterval)
        request.httpMethod = "POST"
        request.setValue("application/x-www-form-urlencoded", forHTTPHeaderField: "Content-Type")
        return request
    }
}


























