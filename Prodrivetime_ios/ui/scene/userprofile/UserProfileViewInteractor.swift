//
//  UserProfileViewInteractor.swift
//  Prodrivetime_ios
//
//  Created by Wing Sun Cheung on 11/17/19.
//  Copyright © 2019 Wing Sun Cheung. All rights reserved.
//

import Foundation

protocol UserProfileViewInteractor: BaseInteractor {
    func showUserProfile()
    func fetchJobRequestCount(driverEmail: String)
}

class UserProfileViewInteractorImpl {
    
    private let presenter: UserProfileViewPresenter
    private let usecase: FetchRequestUseCase
    private let factory: URLRequestFactory
    
    init(presenter: UserProfileViewPresenter, usecase: FetchRequestUseCase, factory: URLRequestFactory) {
        self.presenter = presenter
        self.usecase = usecase
        self.factory = factory
    }
    
    func onStart() {
        presenter.displayUserProfile()
        usecase.registerObserver(observer: self)
    }
    
    func onStop() {
        usecase.unregisterObserver()
    }
}

extension UserProfileViewInteractorImpl: UserProfileViewInteractor {
    
    func showUserProfile() {
        presenter.displayUserProfile()
    }
    
    func fetchJobRequestCount(driverEmail: String) {
        guard let request = factory.createJobRequestURLRequest(email: driverEmail) else { return}
        
        usecase.fetchRequestAndNotify(with: request)
    }
}

extension UserProfileViewInteractorImpl: FetchRequestUseCaseDelegate {
    
    func onRequestFetching() {
        
    }
    
    func onRequestFetchSuccessful(request: [JobRequest]) {
        presenter.jobRequestCount(count: request.count)
    }
    
    func onRequestFetchFailed(error: FetchUserProfileUseCaseError) {
        presenter.jobRequestCount(count: 0)
    }
    
    
}
