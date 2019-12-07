//
//  LoginPresenter.swift
//  Prodrivetime_ios
//
//  Created by Wing Sun Cheung on 11/15/19.
//  Copyright © 2019 Wing Sun Cheung. All rights reserved.
//

import Foundation

protocol LoginPresenter {
    func imcompeleteLoginDetail()
    func userProfileFetched(user: User)
    func userProfileError(err: FetchUserProfileUseCaseError)
    func userProfileFetching()
    func handleSignUp(url: URL)
    func proceedToAutoLogin()
}

class LoginPresenterImpl: LoginPresenter {
    
    private weak var viewMvc: LoginViewMvc?
    private weak var coordinator: ApplicationCoordinator?
    
    init(coordinator: ApplicationCoordinator, viewMvc: LoginViewMvc) {
        self.coordinator = coordinator
        self.viewMvc = viewMvc
    }
    
    func userProfileError(err: FetchUserProfileUseCaseError) {

        switch err {
            
        case .decodeJsonUnsucessful:
            viewMvc?.showAlert(title: "Login Error", description: "Email and/or password in incorrect")
            
        case .requestFailed:
            viewMvc?.showAlert(title: "Login Error", description: "Bad URL request")
        }
        viewMvc?.hideLoadingIndicator()
    }
    
    func userProfileFetched(user: User) {
        viewMvc?.hideLoadingIndicator()
        coordinator?.pushToMainTabBarController(user: user)
    }
    
    func userProfileFetching() {
        viewMvc?.showLoadingIndicator()
    }
    
    func imcompeleteLoginDetail() {
        viewMvc?.showAlert(title: "Login Error", description: "Please enter your username and/or password")
    }
    
    func handleSignUp(url: URL) {
        viewMvc?.showSignUpPage(url: url)
    }
    
    func proceedToAutoLogin() {
        viewMvc?.hideLoginInterface()
    }
}
