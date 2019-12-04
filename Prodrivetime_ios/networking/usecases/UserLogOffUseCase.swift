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

class UserLogOffUseCase {
    
    private let session: BaseNetworkSession
    
    init(session: BaseNetworkSession) {
        self.session = session
    }
    
    
}
