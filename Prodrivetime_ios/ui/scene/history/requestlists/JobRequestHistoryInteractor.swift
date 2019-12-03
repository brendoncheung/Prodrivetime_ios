//
//  JobRequestHistoryInteractor.swift
//  Prodrivetime_ios
//
//  Created by Wing Sun Cheung on 11/26/19.
//  Copyright © 2019 Wing Sun Cheung. All rights reserved.
//

import Foundation

protocol JobRequestHistoryInteractor: BaseInteractor {
    
    func fetchJobRequestHistory()
    func bindUser(user: User)
    
}

class JobRequestHistoryInteractorImpl: JobRequestHistoryInteractor {
    
    private let fetchHistoryRequestUseCase: FetchRequestHistoryUseCase
    private let fetchCompanyUseCase: FetchCompanyInformationUseCase
    private let factory: URLRequestFactory
    private var user: User?
    private let presenter: JobRequestHistoryPresenter
    
    init(fetchHistoryRequestUseCase: FetchRequestHistoryUseCase,
         fetchCompanyUseCase: FetchCompanyInformationUseCase,
         factory: URLRequestFactory,
         presenter: JobRequestHistoryPresenter) {
        
        self.fetchHistoryRequestUseCase = fetchHistoryRequestUseCase
        self.fetchCompanyUseCase = fetchCompanyUseCase
        self.factory = factory
        self.presenter = presenter
    }
    
    func fetchJobRequestHistory() {
        guard let user = user, let email = user.email else { return }
        let request = factory.createJobRequestHistoryURLRequest(email: email)
        
        fetchHistoryRequestUseCase.fetchRequestHistoryAndNotify(with: request!)
    }
    
    func onStart() {
        fetchCompanyUseCase.registerObserver(observer: self)
        fetchHistoryRequestUseCase.registerObserver(observer: self)
    }
    
    func onStop() {
        fetchCompanyUseCase.unregisterObserver()
        fetchHistoryRequestUseCase.unregisterObserver()
    }
    
    func bindUser(user: User) {
        self.user = user
    }
}

extension JobRequestHistoryInteractorImpl: FetchRequestHistoryUseCaseDelegate {
    
    func onRequestHistoryFetching() {
        presenter.jobRequestHistoryFetching()
    }
    
    func onRequestHistoryFetched(request: [JobRequestHistory]) {
        presenter.jobRequestHistoryFetched(requests: request)
    }
    
    func onRequestHistoryFetchedFailed(error: FetchRequestHistoryUseCaseError) {
        
    }
    
    
}

extension JobRequestHistoryInteractorImpl: FetchCompanyInformationDelegate {
    func onCompanyInformationFetching() {
        
    }
    
    func onCompanyInformationFetched(company: Company) {
        
    }
    
    func onCompanyInformationFetchFailed(error: FetchCompanyInformationError) {
        
    }
}

