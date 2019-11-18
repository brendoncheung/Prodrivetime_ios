//
//  Authentication.swift
//  Prodrivetime_ios
//
//  Created by Wing Sun Cheung on 11/12/19.
//  Copyright © 2019 Wing Sun Cheung. All rights reserved.
//

import Foundation

protocol LoginInteractor {
    func fetchUserProfileAndNotify(email: String?, password: String?)
}

class LoginInteractorImpl: LoginInteractor {

    private let loginUseCase: FetchUserProfileUseCase
    private let firebaseTokenUseCase: FetchFireBaseTokenUseCase
    private let factory: URLRequestFactory
    
    private var email: String?
    private var password: String?
    
    var presenter: LoginPresenter
    
    init(loginUseCase: FetchUserProfileUseCase,
        firebaseTokenUseCase: FetchFireBaseTokenUseCase,
        factory: URLRequestFactory,
        presenter: LoginPresenter) {
        self.loginUseCase = loginUseCase
        self.firebaseTokenUseCase = firebaseTokenUseCase
        self.factory = factory
        self.presenter = presenter
        
        loginUseCase.registerObserver(observer: self)
        firebaseTokenUseCase.registerObserver(observer: self)
    }

    func fetchUserProfileAndNotify(email: String?, password: String?) {

        guard email?.isEmpty == false,
            password?.isEmpty == false else {
            presenter.imcompeleteLoginDetail()
            return
        }
        
        self.email = email
        self.password = password
        
        firebaseTokenUseCase.fetchFireBaseTokenAndNotify()
    }
}

extension LoginInteractorImpl: FetchUserProfileUseCaseDelegate {
    
    func onUserProfileFetchFailed(error: Error?) {
        presenter.userProfileError(err: error)
    }
    
    func onUserProfileFetchSuccessful(user: User) {
        presenter.userProfileFetched(user: user)
    }
    
    func onUserProfileFetching() {
        presenter.fetching()
    }
}

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




