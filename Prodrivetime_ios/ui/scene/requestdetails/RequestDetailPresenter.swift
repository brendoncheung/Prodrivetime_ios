//
//  RequestDetailPresenter.swift
//  Prodrivetime_ios
//
//  Created by Wing Sun Cheung on 11/23/19.
//  Copyright © 2019 Wing Sun Cheung. All rights reserved.
//

import Foundation

protocol RequestDetailPresenter {
    func onAcceptRequestProcessing()
    func showRequestDetails(request: JobRequest?)
    func acceptJobRequestSuccessful()
}

class RequestDetailPresenterImpl: RequestDetailPresenter {
    
    private weak var viewMvc: RequestDetailViewMvc?
    
    init(viewMvc: RequestDetailViewMvc) {
        self.viewMvc = viewMvc
    }
    
    func onAcceptRequestProcessing() {
        viewMvc?.showLoadingIndicator()
    }

    func showRequestDetails(request: JobRequest?) {
        guard let request = request else { fatalError("request cant be nil")}
        viewMvc?.populateUI(request: request)
    }
    
    func acceptJobRequestSuccessful() {
        viewMvc?.hideLoadingIndicator()
        viewMvc?.onAcceptSuccessful()
    }
    
}
