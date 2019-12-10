//
//  SubmitSupportEmailUseCase.swift
//  Prodrivetime_ios
//
//  Created by Wing Sun Cheung on 12/9/19.
//  Copyright © 2019 Wing Sun Cheung. All rights reserved.
//

import Foundation

protocol SubmitSupportEmailUseCaseDelegate {
    func supportEmailSending()
    func supportEmailSentSuccessfully()
    func supportEmailSentFailed()
}

class SubmitSupportEmailUseCase: BaseObservable<SubmitSupportEmailUseCaseDelegate>,  BaseSessionCallback {
    
    private let session: BaseNetworkSession
    
    init(session: BaseNetworkSession) {
        self.session = session
    }
    
    func submitSupportEmailAndNotify(with request: URLRequest) {
        session.registerObserver(observer: self)
        session.makeRequest(with: request)?.resume()
        getObserver()?.supportEmailSending()
    }
    
    func onData(data: Data) {
        
    }
    
    func onResponse(response: HTTPURLResponse) {
        
        if response.statusCode == 200 {
            getObserver()?.supportEmailSentSuccessfully()
        } else {
            getObserver()?.supportEmailSentFailed()
        }
        
        session.unregisterObserver()
    }
    
    func onError(err: BaseNetworkSessionError) {
        
    }
    
    
    
}
