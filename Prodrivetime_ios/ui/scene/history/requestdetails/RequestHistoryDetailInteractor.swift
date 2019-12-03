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
}

class RequestHistoryDetailInteractorImpl: RequestHistoryDetailInteractor{
    
    private let fetchCompanyInformationUseCase: FetchCompanyInformationUseCase
    private let presenter: RequestHistoryDetailPresenter
    
    private var request: JobRequestHistory?

    init(fetchCompanyInformationUseCase: FetchCompanyInformationUseCase,
         presenter: RequestHistoryDetailPresenter) {
        self.fetchCompanyInformationUseCase = fetchCompanyInformationUseCase
        self.presenter = presenter
    }
    
    func onStart() {
        fetchCompanyInformationUseCase.registerObserver(observer: self)
        presenter.showRequestDetails(request: request)
    }
    
    func onStop() {
        fetchCompanyInformationUseCase.unregisterObserver()
    }
    
    func bindRequest(request: JobRequestHistory) {
        self.request = request
    }
}

extension RequestHistoryDetailInteractorImpl: FetchCompanyInformationDelegate {
    
    func onCompanyInformationFetching() {
        
    }
    
    func onCompanyInformationFetched(company: Company) {
        
    }
    
    func onCompanyInformationFetchFailed(error: FetchCompanyInformationError) {
        
    }
    
    
}
