//
//  JobRequestPresenter.swift
//  Prodrivetime_ios
//
//  Created by Wing Sun Cheung on 11/19/19.
//  Copyright © 2019 Wing Sun Cheung. All rights reserved.
//

import Foundation

protocol JobRequestPresenter {
    func jobRequestFetching()
    func jobRequestFetched(requests: [JobRequest])
    func jobRequestFailed()
}

class JobRequestPresenterImpl: JobRequestPresenter {
    
    private weak var viewMvc: JobRequestViewMvc?
    
    init(viewMvc: JobRequestViewMvc) {
        self.viewMvc = viewMvc
    }
    
    func jobRequestFetching() {
        viewMvc?.showLoadingIndicator()
    }
    
    func jobRequestFetched(requests: [JobRequest]) {
        viewMvc?.hideLoadingIndicator()
        viewMvc?.hideEmptyState()
        viewMvc?.populateTable(requests: requests)
    }
    
    func jobRequestFailed() {
        // lazy way of a 0 sized array
        viewMvc?.populateTable(requests: [JobRequest]())
        viewMvc?.hideLoadingIndicator()
        viewMvc?.showEmptyState()
    }
}


