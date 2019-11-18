//
//  Injector.swift
//  Prodrivetime_ios
//
//  Created by Wing Sun Cheung on 11/18/19.
//  Copyright © 2019 Wing Sun Cheung. All rights reserved.
//

import Foundation

class Injector {
    
    private let compositionRoot: CompositionRoot
    
    init(compositionRoot: CompositionRoot) {
        self.compositionRoot = compositionRoot
    }
    
    func inject(loginViewController: LoginViewController) {
        
        let coordinator = compositionRoot.getCoordinator()
        
        let presenter = compositionRoot.getLoginPresenter(viewMvc: loginViewController,
                                                          coordinator: coordinator)
        
        let interactor = compositionRoot.getLoginInteractor(presenter: presenter)
        loginViewController.interactor = interactor
    }
    
    
    
    
    
    
}
