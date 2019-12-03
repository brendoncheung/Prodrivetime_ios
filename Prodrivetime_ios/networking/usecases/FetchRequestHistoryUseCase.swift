//
//  FetchRequestHistoryUseCase.swift
//  Prodrivetime_ios
//
//  Created by Wing Sun Cheung on 11/19/19.
//  Copyright © 2019 Wing Sun Cheung. All rights reserved.
//

import Foundation

protocol FetchRequestHistoryUseCaseDelegate {
    func onRequestHistoryFetching()
    func onRequestHistoryFetched(request: [JobRequestHistory])
    func onRequestHistoryFetchedFailed(error: FetchRequestHistoryUseCaseError)
}

enum FetchRequestHistoryUseCaseError: Error {
    case decodeJsonUnsucessful
    case requestFailed
}

class FetchRequestHistoryUseCase: BaseObservable<FetchRequestHistoryUseCaseDelegate>, BaseSessionCallback {
    
    private let session: BaseNetworkSession
    
    init(session: BaseNetworkSession) {
        self.session = session
    }
    
    func fetchRequestHistoryAndNotify(with request: URLRequest) {
        session.registerObserver(observer: self)
        session.makeRequest(with: request)?.resume()
        getObserver()?.onRequestHistoryFetching()
    }
    
    
    func onData(data: Data) {
        
        do {
            let request = try JSONDecoder().decode([JobRequestHistory].self, from: data)
            
            log.debug(String(data: data, encoding: .utf8))
            getObserver()?.onRequestHistoryFetched(request: request)
        } catch {
            getObserver()?.onRequestHistoryFetchedFailed(error: .decodeJsonUnsucessful)
        }
    }
    
    func onResponse(response: HTTPURLResponse) {
        // stub
    }
    
    func onError(err: BaseNetworkSessionError) {
        getObserver()?.onRequestHistoryFetchedFailed(error: .requestFailed)
    }
    
    
    
    
    
    
    
}
