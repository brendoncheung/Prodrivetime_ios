//
//  JobRequestInteractor.swift
//  Prodrivetime_ios
//
//  Created by Wing Sun Cheung on 11/19/19.
//  Copyright © 2019 Wing Sun Cheung. All rights reserved.
//

import Foundation

protocol JobRequestInteractor: BaseInteractor {
    func fetchJobRequestAndNotify()
    func bindEmail(email: String?)
}

class JobRequestInteractorImpl: JobRequestInteractor {
    
    private let fetchRequestUseCase: FetchRequestUseCase
    private let factory: URLRequestFactory
    private let presenter: JobRequestPresenter
    
    private var email: String?
    
    init(fetchRequestUseCase: FetchRequestUseCase,
         factory: URLRequestFactory,
         presenter: JobRequestPresenter) {
        
        self.fetchRequestUseCase = fetchRequestUseCase
        self.factory = factory
        self.presenter = presenter
    }
    
    func bindEmail(email: String?) {
        self.email = email
    }
    
    func onStart() {
        fetchRequestUseCase.registerObserver(observer: self)
    }
    
    func onStop() {
        fetchRequestUseCase.unregisterObserver()
    }
    
    func fetchJobRequestAndNotify() {
        guard let email = email, let url = factory.createJobRequestURLRequest(email: email) else { return }
        fetchRequestUseCase.fetchRequestAndNotify(with: url)
    }
}

extension JobRequestInteractorImpl: FetchRequestUseCaseDelegate {
    
    func onRequestFetching() {
        presenter.jobRequestFetching()
    }
    
    func onRequestFetchSuccessful(request: [JobRequest]) {
        presenter.jobRequestFetched(requests: request)
    }
    
    func onRequestFetchFailed(error: FetchUserProfileUseCaseError) {
        
        switch error {
        case .requestFailed :
            log.debug("requestFailed")
            presenter.jobRequestFailed()
        case .decodeJsonUnsucessful :
            log.debug("decodeJsonUnsucessful")
            presenter.jobRequestFailed()
        }
    }
}


