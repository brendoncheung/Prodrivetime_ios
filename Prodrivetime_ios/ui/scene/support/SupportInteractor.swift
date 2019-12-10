
//
//  SupportInteractpr.swift
//  Prodrivetime_ios
//
//  Created by Wing Sun Cheung on 12/9/19.
//  Copyright © 2019 Wing Sun Cheung. All rights reserved.
//

import Foundation

protocol SupportInteractor: BaseInteractor {
    func submitSupportEmail(subject: String?, email: String?, body: String?)
    func bindUser(user: User)
    
}

class SupportInteractorImpl: SupportInteractor {
    
    private let supportEmailUseCase: SubmitSupportEmailUseCase
    private let presenter: SupportPresenter
    private let factory: URLRequestFactory
    
    private var user: User?
    
    init(supportEmailUseCase: SubmitSupportEmailUseCase,
         presenter: SupportPresenter,
         factory: URLRequestFactory) {
        self.supportEmailUseCase = supportEmailUseCase
        self.presenter = presenter
        self.factory = factory
    }
    
    func onStart() {
        supportEmailUseCase.registerObserver(observer: self)
    }
    
    func onStop() {
        supportEmailUseCase.unregisterObserver()
    }
    
    func submitSupportEmail(subject: String?, email: String?, body: String?) {
        
        guard subject!.count > 0, email!.count > 0, body!.count > 0 else {
            presenter.incompleteField()
            return
        }
        guard let request = factory.createSendSupportEmailURLRequest(subject: subject!, email: email!, body: body!) else { return }
        
        supportEmailUseCase.submitSupportEmailAndNotify(with: request)
    }
    
    func bindUser(user: User) {
        self.user = user
    }
    
}

extension SupportInteractorImpl: SubmitSupportEmailUseCaseDelegate {
    
    func supportEmailSending() {
        presenter.questionSentingInProcess()
    }
    
    func supportEmailSentSuccessfully() {
        presenter.questionSentSuccessfully()
    }
    
    func supportEmailSentFailed() {
        
    }
    
}
