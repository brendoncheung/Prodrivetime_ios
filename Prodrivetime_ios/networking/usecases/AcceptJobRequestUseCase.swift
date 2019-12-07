//
//  AcceptJobRequestUseCase.swift
//  Prodrivetime_ios
//
//  Created by Wing Sun Cheung on 11/27/19.
//  Copyright © 2019 Wing Sun Cheung. All rights reserved.
//

import Foundation

protocol AcceptJobRequestUseCaseDelegate {
    func onRequestingAcceptJob()
    func onRequestAcceptJobSuccessful()
    func onRequestAcceptJobFailed(error: AcceptJobRequestUseCaseError)
}

enum AcceptJobRequestUseCaseError: Error {
    case requestFailed
}

class AcceptJobRequestUseCase: BaseObservable<AcceptJobRequestUseCaseDelegate> {
    
    private let session: BaseNetworkSession
    
    init(session: BaseNetworkSession) {
        self.session = session
    }
    
    func acceptJobRequest(with request: URLRequest) {
        session.registerObserver(observer: self)
        session.makeRequest(with: request)?.resume()
        getObserver()?.onRequestingAcceptJob()
    }
}

extension AcceptJobRequestUseCase: BaseSessionCallback {
    
    func onData(data: Data) {
        session.unregisterObserver()
    }
    
    func onResponse(response: HTTPURLResponse) {
        log.debug(response.statusCode)
        getObserver()?.onRequestAcceptJobSuccessful()

    }
    
    func onError(err: BaseNetworkSessionError) {
        getObserver()?.onRequestAcceptJobFailed(error: .requestFailed)

    }
    
}
