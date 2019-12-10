//
//  UserLogOffUseCase.swift
//  Prodrivetime_ios
//
//  Created by Wing Sun Cheung on 11/19/19.
//  Copyright © 2019 Wing Sun Cheung. All rights reserved.
//

import Foundation

protocol UserLogOffUseCaseDelegate {
    func onLogOutSuccessful()
    func onLogOutFailed(error: UserLogOffUseCaseError)
}

enum UserLogOffUseCaseError: Error{
    case logOutError
}

class UserLogOffUseCase: BaseObservable<UserLogOffUseCaseDelegate> {
    
    private let session: BaseNetworkSession
    
    init(session: BaseNetworkSession) {
        self.session = session
    }
    
    func requestUserLogOut(request: URLRequest) {
        session.registerObserver(observer: self)
        session.makeRequest(with: request)?.resume()
    }
}

extension UserLogOffUseCase: BaseSessionCallback {
    
    func onData(data: Data) {
        // weird backend response
    }
    
    func onResponse(response: HTTPURLResponse) {
        if response.statusCode == 200 {
            getObserver()?.onLogOutSuccessful()
        }
    }
    
    func onError(err: BaseNetworkSessionError) {
        
    }
    
    
    
    
    
}
