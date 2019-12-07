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
    func onUserProfileFetchFailed(error: FetchUserProfileUseCaseError)
}

enum FetchUserProfileUseCaseError: Error {
    case decodeJsonUnsucessful
    case requestFailed
}

class FetchUserProfileUseCase: BaseObservable<FetchUserProfileUseCaseDelegate>, BaseSessionCallback {
    
    var session: BaseNetworkSession
    
    init(session: BaseNetworkSession) {
        self.session = session
    }
    
    func fetchUserProfileAndNotify(with request: URLRequest) {
        session.registerObserver(observer: self)
        session.makeRequest(with: request)?.resume()
        getObserver()?.onUserProfileFetching()
    }
    
    //---------session callback---------
    
    func onData(data: Data) {
        do {
            let user = try JSONDecoder().decode(User.self, from: data)
            self.getObserver()?.onUserProfileFetchSuccessful(user: user)
            
        } catch {
            getObserver()?.onUserProfileFetchFailed(error: .decodeJsonUnsucessful)
        }
        
        session.unregisterObserver()

    }
    
    func onError(err: BaseNetworkSessionError) {
        
        self.getObserver()?.onUserProfileFetchFailed(error: .requestFailed)
    }
    
    func onResponse(response: HTTPURLResponse) {
        // use if need be

    }
}
