//
//  RequestHistoryDetailPresenter.swift
//  Prodrivetime_ios
//
//  Created by Wing Sun Cheung on 12/2/19.
//  Copyright © 2019 Wing Sun Cheung. All rights reserved.
//

import Foundation

protocol RequestHistoryDetailPresenter: class {
    func onRequestHistoryFetching()
    func showRequestDetails(request: JobRequestHistory?)
    func acceptJobRequestSuccessful()
    func makeCallWith(url: URL)
    func fetchingCompanyInformation()
}

class RequestHistoryDetailPresenterImpl{
    
    private weak var viewMvc: RequestHistoryDetailViewMvc?
    
    init(viewMvc: RequestHistoryDetailViewMvc) {
        self.viewMvc = viewMvc
    }
    
    
}

extension RequestHistoryDetailPresenterImpl: RequestHistoryDetailPresenter {
    
    func onRequestHistoryFetching() {
        
    }
    
    func showRequestDetails(request: JobRequestHistory?) {
        guard let request = request else { return }
        viewMvc?.populateUI(request: request)
    }
    
    func acceptJobRequestSuccessful() {
        
    }
    
    func makeCallWith(url: URL) {
        viewMvc?.hideLoadingIndicatorOnCallButton()
        viewMvc?.openCallDialog(url: url)
    }
    
    func fetchingCompanyInformation() {
        viewMvc?.showLoadingIndicatorOnCallButton()
    }
    
    
    
}
