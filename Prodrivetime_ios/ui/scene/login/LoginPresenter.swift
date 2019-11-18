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
    func userProfileError(err: Error?)
    func fetching()
}

class LoginPresenterImpl: LoginPresenter {
    
    private weak var viewMvc: LoginViewMvc?
    private weak var coordinator: Coordinator?
    
    init(coordinator: Coordinator, viewMvc: LoginViewMvc) {
        self.coordinator = coordinator
        self.viewMvc = viewMvc
    }
    
    func userProfileError(err: Error?) {
        viewMvc?.hideLoadingIndicator()
    }
    
    func userProfileFetched(user: User) {
        viewMvc?.hideLoadingIndicator()
        coordinator?.segueToUserProfileVC(user: user)
    }
    
    func fetching() {
        viewMvc?.showLoadingIndicator()
    }
    
    func imcompeleteLoginDetail() {
        viewMvc?.alertFormImcomplete()
    }
    
}
