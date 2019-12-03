//
//  FetchCompanyInformationUseCase.swift
//  Prodrivetime_ios
//
//  Created by Wing Sun Cheung on 11/26/19.
//  Copyright © 2019 Wing Sun Cheung. All rights reserved.
//

import Foundation

protocol FetchCompanyInformationDelegate {
    func onCompanyInformationFetching()
    func onCompanyInformationFetched(company: Company)
    func onCompanyInformationFetchFailed(error: FetchCompanyInformationError)
}

enum FetchCompanyInformationError: Error{
    case decodeJsonUnsucessful
    case requestFailed
}

class FetchCompanyInformationUseCase: BaseObservable<FetchCompanyInformationDelegate>, BaseSessionCallback {
    
    private let session: BaseNetworkSession
    
    init(session: BaseNetworkSession) {
        self.session = session
    }
    
    func fetchCompanyInformationAndNotify(with request: URLRequest) {
        session.makeRequest(with: request)?.resume()
        getObserver()?.onCompanyInformationFetching()
        
    }
    
    func onData(data: Data) {
        do {
            let company = try JSONDecoder().decode(Company.self, from: data)
            getObserver()?.onCompanyInformationFetched(company: company)
            
        } catch {
            getObserver()?.onCompanyInformationFetchFailed(error: .decodeJsonUnsucessful)
        }
    }
    
    func onResponse(response: HTTPURLResponse) {
        
    }
    
    func onError(err: BaseNetworkSessionError) {
        
    }
    
    
    
    
}
