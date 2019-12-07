//
//  Authentication.swift
//  Prodrivetime_ios
//
//  Created by Wing Sun Cheung on 11/12/19.
//  Copyright © 2019 Wing Sun Cheung. All rights reserved.
//

import Foundation
import SafariServices

protocol LoginInteractor: BaseInteractor {
    func handleLoginButtonTapped(email: String?, password: String?)
    func handleSwitchState(isOn: Bool)
    func handleSignUpButtonTapped()
}

class LoginInteractorImpl: BaseInteractor, LoginInteractor {

    private let loginUseCase: FetchUserProfileUseCase
    private let firebaseTokenUseCase: FetchFireBaseTokenUseCase
    private let factory: URLRequestFactory
    private let authenticator: Authentication
    
    private var email: String!
    private var password: String!
    private var switchState = false
    
    var presenter: LoginPresenter
    
    init(loginUseCase: FetchUserProfileUseCase,
        firebaseTokenUseCase: FetchFireBaseTokenUseCase,
        factory: URLRequestFactory,
        presenter: LoginPresenter,
        authenticator: Authentication) {
        self.loginUseCase = loginUseCase
        self.firebaseTokenUseCase = firebaseTokenUseCase
        self.factory = factory
        self.presenter = presenter
        self.authenticator = authenticator
    }
    
    func onStart() {
        loginUseCase.registerObserver(observer: self)
        firebaseTokenUseCase.registerObserver(observer: self)
//        shouldProceedToAutoLogin()
    }
    
    func onStop() {
        loginUseCase.unregisterObserver()
        firebaseTokenUseCase.unregisterObserver()
    }
    
    private func shouldProceedToAutoLogin() {
        
        guard authenticator.shouldAutoLogin() else { return }
        
        
        
    }

    func handleLoginButtonTapped(email: String?, password: String?) {

        guard email?.isEmpty == false,
            password?.isEmpty == false else {
            presenter.imcompeleteLoginDetail()
            return
        }
        
        self.email = email
        self.password = password

        firebaseTokenUseCase.fetchFireBaseTokenAndNotify()
    }
    
    func handleSwitchState(isOn: Bool) {
        switchState = isOn
    }
    
    func handleSignUpButtonTapped() {
        guard let url = URL(string: "https://www.prodrivetime.com/driver/driverRegister") else { return }
        presenter.handleSignUp(url: url)
    }
}

// MARK: - Firebase token callback

extension LoginInteractorImpl: FetchFireBaseTokenUseCaseDelegate {
    
    func onFirebaseTokenFetched(token: String) {
        
        guard let email = email, let password = password else {
            return
        }
        
        guard let request = factory.createLoginURLRequest(email: email, pw: password, token: token) else {
            return
        }
        loginUseCase.fetchUserProfileAndNotify(with: request)
    }
}

// MARK: - Userprofile callback

extension LoginInteractorImpl: FetchUserProfileUseCaseDelegate {
    
    func onUserProfileFetching() {
        presenter.userProfileFetching()
    }
    
    func onUserProfileFetchFailed(error: FetchUserProfileUseCaseError) {
        
        switch error {
            
        case .decodeJsonUnsucessful :
            presenter.userProfileError(err: .decodeJsonUnsucessful)
        
        case .requestFailed :
            presenter.userProfileError(err: .requestFailed)
        }
    }
    
    func onUserProfileFetchSuccessful(user: User) {
        autoLoginCapture()
        presenter.userProfileFetched(user: user)
    }
    
    private func autoLoginCapture() {
        if switchState {
            authenticator.setShouldAutoLogin(to: true)
            authenticator.saveUsernameAndPassword(username: email, password: password)
        } else {
            authenticator.setShouldAutoLogin(to: false)
        }
    }
}






