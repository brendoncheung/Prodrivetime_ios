//
//  RequestHistoryDetailInteractor.swift
//  Prodrivetime_ios
//
//  Created by Wing Sun Cheung on 12/2/19.
//  Copyright © 2019 Wing Sun Cheung. All rights reserved.
//

import Foundation

protocol RequestHistoryDetailInteractor: BaseInteractor {
    func bindRequest(request: JobRequestHistory)
    func handleCallButtonTapped()
}

class RequestHistoryDetailInteractorImpl: RequestHistoryDetailInteractor{
    
    private let fetchCompanyInformationUseCase: FetchCompanyInformationUseCase
    private let presenter: RequestHistoryDetailPresenter
    private let factory: URLRequestFactory
    
    private var request: JobRequestHistory?

    init(fetchCompanyInformationUseCase: FetchCompanyInformationUseCase,
         presenter: RequestHistoryDetailPresenter,
         factory: URLRequestFactory) {
        self.fetchCompanyInformationUseCase = fetchCompanyInformationUseCase
        self.presenter = presenter
        self.factory = factory
    }
    
    func onStart() {
        fetchCompanyInformationUseCase.registerObserver(observer: self)
        presenter.showRequestDetails(request: request)
    }
    
    func onStop() {
        fetchCompanyInformationUseCase.unregisterObserver()
    }
    
    func handleCallButtonTapped() {
        presenter.fetchingCompanyInformation()
        guard let email = request?.businessEmail else { return }
        guard let request = factory.createFetchCompanyInfoURLRequest(companyEmail: email) else { return }
        fetchCompanyInformationUseCase.fetchCompanyInformationAndNotify(with: request)
    }
    
    func bindRequest(request: JobRequestHistory) {
        self.request = request
    }
}

extension RequestHistoryDetailInteractorImpl: FetchCompanyInformationDelegate {
    
    func onCompanyInformationFetching() {
        
    }
    
    func onCompanyInformationFetched(company: Company) {
        guard let url = MakePhoneCallUseCase.makeCallUrl(number: company.phone) else { return }
        presenter.makeCallWith(url: url)
    }
    
    func onCompanyInformationFetchFailed(error: FetchCompanyInformationError) {
        
    }
    
    
}
