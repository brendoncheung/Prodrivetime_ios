//
//  CompositionRoot.swift
//  Prodrivetime_ios
//
//  Created by Wing Sun Cheung on 11/14/19.
//  Copyright © 2019 Wing Sun Cheung. All rights reserved.
//

import Foundation
import UIKit

class CompositionRoot {
    
    var coordinator: Coordinator?
    
    init() {}
    
    // MARK: - Networking configuration
    
    func getRequestCachePolicy() -> URLRequest.CachePolicy {
        return URLRequest.CachePolicy.reloadIgnoringCacheData
    }
    
    func getTimeOutInterval() -> TimeInterval {
        return TimeInterval(10)
    }
    
    func getURLRequestFactory() -> URLRequestFactory {
        return URLRequestFactory(policy: getRequestCachePolicy(), timeInterval: getTimeOutInterval())
    }
    
    func getSessionConfiguration() -> URLSessionConfiguration {
        return URLSessionConfiguration.default
    }
    
    func getBaseNetworkSession() -> BaseNetworkSession {
        return BaseNetworkSession(configuration: getSessionConfiguration())
    }
    
    // MARK: - Main navigation controller configuration
    func getMainNavigationController() -> UINavigationController {
        return BaseNavigationViewController()
    }
    
    // MARK:- Main coordinator configuration
    
    func getCoordinator() -> Coordinator {
        if coordinator == nil {
            coordinator = MainCoordinatorImpl(navigationController: getMainNavigationController(),
                                             injector: getInjector())
        }
        return coordinator!
    }
    
    // MARK: - Injector
    
    func getInjector() -> Injector {
        return Injector(compositionRoot: self)
    }
    
    // MARK: - Use cases configuration
    
    func getFetchUserProfileUseCase() -> FetchUserProfileUseCase {
        return FetchUserProfileUseCase(session: getBaseNetworkSession())
    }
    
    func getFetchFirebaseTokenUseCase() -> FetchFireBaseTokenUseCase {
        return FetchFireBaseTokenUseCase()
    }
    
    // MARK: - Presenter configuration
    
    func getLoginPresenter(viewMvc: LoginViewMvc, coordinator: Coordinator) -> LoginPresenter {
        return LoginPresenterImpl(coordinator: coordinator, viewMvc: viewMvc)
    }
    
    // MARK: - ViewMvc configuration
    
    func getLoginViewMvc() -> LoginViewMvc {
        return UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "LoginViewController") as! LoginViewMvc
    }
    
    // MARK: - Interactors configuration
    
    func getLoginInteractor(presenter: LoginPresenter) -> LoginInteractor {
        
        return LoginInteractorImpl(loginUseCase: getFetchUserProfileUseCase(),
                                   firebaseTokenUseCase: getFetchFirebaseTokenUseCase(),
                                   factory: getURLRequestFactory(),
                                   presenter: presenter)
    }
}































