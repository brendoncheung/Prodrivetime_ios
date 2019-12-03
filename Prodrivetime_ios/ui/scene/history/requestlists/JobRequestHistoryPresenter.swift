//
//  JobRequestHistoryPresenter.swift
//  Prodrivetime_ios
//
//  Created by Wing Sun Cheung on 11/26/19.
//  Copyright © 2019 Wing Sun Cheung. All rights reserved.
//

import Foundation

protocol JobRequestHistoryPresenter {
    
    func jobRequestHistoryFetching()
    func jobRequestHistoryFetched(requests: [JobRequestHistory])
    func jobRequestHistoryFailed()
}

class JobRequestHistoryPresenterImpl: JobRequestHistoryPresenter {
    
    private weak var viewMvc: JobRequestHistoryViewMvc?
    
    init(viewMvc: JobRequestHistoryViewMvc) {
        self.viewMvc = viewMvc
    }
    
    func jobRequestHistoryFailed() {
        
    }
    
    func jobRequestHistoryFetching() {
        viewMvc?.showLoadingIndicator()
    }
    
    func jobRequestHistoryFetched(requests: [JobRequestHistory]) {
        viewMvc?.populateTable(requests: requests)
        viewMvc?.hideLoadingIndicator()
    }
    
}
