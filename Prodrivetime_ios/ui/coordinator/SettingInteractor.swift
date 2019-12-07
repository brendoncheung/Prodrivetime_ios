
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
    private let factory: URLRequestFactory
    
    init(logOutUseCase: UserLogOffUseCase,
         presenter: SettingPresenter,
         authenticator: Authentication,
         factory: URLRequestFactory) {
        self.logOutUseCase = logOutUseCase
        self.presenter = presenter
        self.authenticator = authenticator
        self.factory = factory
    }
    
    func onStart() {
        logOutUseCase.registerObserver(observer: self)
    }
    
    func onStop() {
        
    }
    
    func handleLogout() {
        log.debug("logout implementation in interactor")
        authenticator.clear()
        authenticator.setShouldAutoLogin(to: false)
        
        guard let request = factory.createUserLogOutURLRequest() else { return }
        
        logOutUseCase.requestUserLogOut(request: request)

    }
}

extension SettingInteractorImpl: UserLogOffUseCaseDelegate {
    
    func onLogOutSuccessful() {
        presenter.userLogoutSuccessful()
    }
    
    func onLogOutFailed(error: UserLogOffUseCaseError) {
        presenter.userLogoutFailed()
    }
}
