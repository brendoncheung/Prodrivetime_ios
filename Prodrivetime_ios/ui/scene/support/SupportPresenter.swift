//
//  SupportPresenter.swift
//  Prodrivetime_ios
//
//  Created by Wing Sun Cheung on 12/9/19.
//  Copyright © 2019 Wing Sun Cheung. All rights reserved.
//

import Foundation

protocol SupportPresenter {
    
    func incompleteField()
    func questionSentingInProcess()
    func questionSentSuccessfully()
    
}

class SupportPresenterImpl: SupportPresenter {
    
    private weak var viewMvc: SupportViewControllerViewMvc?
    
    init(viewMvc: SupportViewControllerViewMvc) {
        self.viewMvc = viewMvc
    }
    
    func incompleteField() {
        viewMvc?.showAlert(title: "Error", description: "Please complete the required fields")
    }
    
    func questionSentSuccessfully() {
        viewMvc?.clearForm()
        viewMvc?.showQuestionSentSuccessfully()
        viewMvc?.hideLoadingIndicator()
    }
    
    func questionSentingInProcess() {
        viewMvc?.showLoadingIndicator()
    }
}
