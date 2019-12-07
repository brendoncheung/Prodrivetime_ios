//
//  FetchRequestUseCase.swift
//  Prodrivetime_ios
//
//  Created by Wing Sun Cheung on 11/19/19.
//  Copyright © 2019 Wing Sun Cheung. All rights reserved.
//

import Foundation

protocol FetchRequestUseCaseDelegate {
    func onRequestFetching()
    func onRequestFetchSuccessful(request: [JobRequest])
    func onRequestFetchFailed(error: FetchUserProfileUseCaseError)
}

enum FetchRequestUseCaseError: Error{
    case emptyJobRequest
    case requestFailed
}

class FetchRequestUseCase: BaseObservable<FetchRequestUseCaseDelegate>, BaseSessionCallback {
    
    private let session: BaseNetworkSession
    
    init(session: BaseNetworkSession) {
        self.session = session
    }
    
    func fetchRequestAndNotify(with request: URLRequest) {
        session.registerObserver(observer: self)
        session.makeRequest(with: request)?.resume()
        getObserver()?.onRequestFetching()
    }
    
    func onData(data: Data) {
        do {
            let request = try JSONDecoder().decode([JobRequest].self, from: data)
            getObserver()?.onRequestFetchSuccessful(request: request)
            
        } catch {
            getObserver()?.onRequestFetchFailed(error: .decodeJsonUnsucessful)
        }
        session.unregisterObserver()
    }
    
    func onError(err: BaseNetworkSessionError) {
        
        self.getObserver()?.onRequestFetchFailed(error: .requestFailed)

    }
    
    func onResponse(response: HTTPURLResponse) {
        // use if need be

    }
    
    
    
    
}
