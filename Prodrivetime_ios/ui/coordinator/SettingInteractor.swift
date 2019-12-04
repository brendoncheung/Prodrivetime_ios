
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
    
    init(logOutUseCase: UserLogOffUseCase,
         presenter: SettingPresenter) {
        self.logOutUseCase = logOutUseCase
        self.presenter = presenter
    }
    
    func onStart() {
        
    }
    
    func onStop() {
        
    }
    
    func handleLogout() {
        log.debug("logout implementation in interactor")
    }
    
    
    
}
