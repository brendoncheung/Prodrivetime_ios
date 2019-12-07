
//
//  SettingInteractor.swift
//  Prodrivetime_ios
//
//  Created by Wing Sun Cheung on 12/4/19.
//  Copyright © 2019 Wing Sun Cheung. All rights reserved.
//

import Foundation

protocol SettingInteractor: BaseInteractor {
    
    func handleLogout()
    
}

class SettingInteractorImpl: SettingInteractor {
    
    private let logOutUseCase: UserLogOffUseCase
    private let presenter: SettingPresenter
    private let authenticator: Authentication
    
    init(logOutUseCase: UserLogOffUseCase,
         presenter: SettingPresenter,
         authenticator: Authentication) {
        self.logOutUseCase = logOutUseCase
        self.presenter = presenter
        self.authenticator = authenticator
    }
    
    func onStart() {
        
    }
    
    func onStop() {
        
    }
    
    func handleLogout() {
        log.debug("logout implementation in interactor")
        
        // TODO: this interactor requires an authenticator to erase user
        // credentials
    }
    
    
    
}
