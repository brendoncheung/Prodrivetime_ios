//
//  FetchUserProfileUseCase.swift
//  Prodrivetime_ios
//
//  Created by Wing Sun Cheung on 11/12/19.
//  Copyright © 2019 Wing Sun Cheung. All rights reserved.
//

import Foundation

// interactor needs to conform to this delegate and have the usecase object in the interactor
protocol FetchUserProfileUseCaseDelegate {
    func onUserProfileFetching()
    func onUserProfileFetchSuccessful(user: User)
    func onUserProfileFetchFailed(error: Error?)
}

class FetchUserProfileUseCase: BaseObservable<FetchUserProfileUseCaseDelegate>, BaseSessionCallback {
    
    var session: BaseNetworkSession
    
    init(session: BaseNetworkSession) {
        self.session = session
    }
    
    func fetchUserProfileAndNotify(with request: URLRequest) {
        log.debug(getObservers().count)
        session.registerObserver(observer: self)
        session.makeRequest(with: request)?.resume()
        
        getObservers().forEach { (callback) in
            callback.onUserProfileFetching()
        }
    }
    
    //---------session callback---------
    
    func onData(data: Data) {
        DispatchQueue.main.async {
            self.getObservers().forEach { (callback) in
                callback.onUserProfileFetchSuccessful(user: User())
            }
        }
    }
    
    func onError(msg: String, err: Error?) {
        DispatchQueue.main.async {
            self.getObservers().forEach { (callback) in
                callback.onUserProfileFetchFailed(error: err)
            }
        }
    }
    
    func onResponse(response: HTTPURLResponse) {
        // use if need be
    }
}
