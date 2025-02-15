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
    
    // Main coordinator is a singleton
    
    var coordinator: ApplicationCoordinator?
    
    private let window: UIWindow
    
    init(window: UIWindow) {
        self.window = window
    }
    
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
        
        let config = URLSessionConfiguration.default
        config.timeoutIntervalForRequest = 10
        
        return URLSessionConfiguration.default
    }
    
    func getBaseNetworkSession() -> BaseNetworkSession {
        return BaseNetworkSession(configuration: getSessionConfiguration())
    }
    
    // MARK: - Main navigation controller configuration
    
    func getMainNavigationController() -> BaseNavigationViewController {
        return BaseNavigationViewController()
    }
    
    // MARK:- Main coordinator configuration
    
    func getCoordinator() -> ApplicationCoordinator {
        if coordinator == nil {
            coordinator = ApplicationCoordinator(window: window, navigationController: getMainNavigationController(),
                                             injector: getInjector())
        }
        return coordinator!
    }
    
    // MARK: - Injector
    
    func getInjector() -> Injector {
        return Injector(compositionRoot: self)
    }
    
    // MARK: - Authentication configuration
    
    private let KEYCHAIN_ACCOUNT_NAME = "Prodrivetime_keychain_account"
    
    func getUserDefaults() -> UserDefaults {
        return UserDefaults.standard
    }
    
    func getKeyChainPasswordItem() -> KeychainPasswordItem {
        return KeychainPasswordItem(service: KeychainConfiguration.serviceName, account: KEYCHAIN_ACCOUNT_NAME, accessGroup: KeychainConfiguration.accessGroup)
    }

    func getAuthentication() -> Authentication {
        return AuthenticationImpl(keychainPasswordItem: getKeyChainPasswordItem(), userdefaults: getUserDefaults())
    }

    // MARK: - Use cases configuration
    
    func getFetchUserProfileUseCase() -> FetchUserProfileUseCase {
        return FetchUserProfileUseCase(session: getBaseNetworkSession())
    }
    
    func getFetchFirebaseTokenUseCase() -> FetchFireBaseTokenUseCase {
        return FetchFireBaseTokenUseCase()
    }
    
    func getFetchRequestUseCase() -> FetchRequestUseCase {
        return FetchRequestUseCase(session: getBaseNetworkSession())
    }
    
    func getFetchRequestHistoryUseCase() -> FetchRequestHistoryUseCase {
        return FetchRequestHistoryUseCase(session: getBaseNetworkSession())
    }
    
    func getAcceptRequestUseCase() -> AcceptJobRequestUseCase {
        return AcceptJobRequestUseCase(session: getBaseNetworkSession())
    }
    
    func getFetchCompanyInformationUseCase() -> FetchCompanyInformationUseCase {
        return FetchCompanyInformationUseCase(session: getBaseNetworkSession())
    }
    
    func getSubmitSupportEmailUseCase() -> SubmitSupportEmailUseCase {
        return SubmitSupportEmailUseCase(session: getBaseNetworkSession())
    }
    
    func getUserLogOutUseCase() -> UserLogOffUseCase {
        return UserLogOffUseCase(session: getBaseNetworkSession())
    }
    
    // MARK: - Presenter configuration
    
    func getLoginPresenter(viewMvc: LoginViewMvc, coordinator: ApplicationCoordinator) -> LoginPresenter {
        return LoginPresenterImpl(coordinator: coordinator, viewMvc: viewMvc)
    }
    
    func getUserProfilePresenter(viewMvc: UserProfileViewMvc) -> UserProfileViewPresenter {
        return UserProfileViewPresenterImpl(viewMvc: viewMvc)
    }
    
    func getJobRequestPresenter(viewMvc: JobRequestViewMvc) -> JobRequestPresenter {
        return JobRequestPresenterImpl(viewMvc: viewMvc)
    }
    
    func getJobRequestDetailPresenter(viewMvc: RequestDetailViewMvc) -> RequestDetailPresenter {
        return RequestDetailPresenterImpl(viewMvc: viewMvc)
    }
    
    func getJobRequestHistoryPresenter(viewMvc: JobRequestHistoryViewMvc) -> JobRequestHistoryPresenter {
        return JobRequestHistoryPresenterImpl(viewMvc: viewMvc)
    }
    
    func getJobRequestHistoryDetailPresenter(viewMvc: RequestHistoryDetailViewController) -> RequestHistoryDetailPresenter   {
        return RequestHistoryDetailPresenterImpl(viewMvc: viewMvc)
    }
    
    func getSettingPresenter(viewMvc: SettingTableViewController) -> SettingPresenter {
        return SettingPresenterImpl(viewMvc: viewMvc)
    }
    
    func getSupportPresenter(viewMvc: SupportViewController) -> SupportPresenter {
        return SupportPresenterImpl(viewMvc: viewMvc)
    }

    // MARK: - Interactors configuration
    
    func getLoginInteractor(presenter: LoginPresenter) -> LoginInteractor {
        return LoginInteractorImpl(loginUseCase: getFetchUserProfileUseCase(), firebaseTokenUseCase: getFetchFirebaseTokenUseCase(), factory: getURLRequestFactory(),presenter: presenter, authenticator: getAuthentication())
    }
    
    func getUserProfileViewInteractor(presenter: UserProfileViewPresenter) -> UserProfileViewInteractor {
        return UserProfileViewInteractorImpl(presenter: presenter, usecase: getFetchRequestUseCase(), factory: getURLRequestFactory())
    }
    
    func getJobRequestInteractor(presenter: JobRequestPresenter) -> JobRequestInteractor {
        return JobRequestInteractorImpl(fetchRequestUseCase: getFetchRequestUseCase(), factory: getURLRequestFactory(), presenter: presenter)
    }
    
    func getJobRequestDetailInteractor(presenter: RequestDetailPresenter) -> RequestDetailInteractor {
        return RequestDetailInteractorImpl(acceptRequestUseCase: getAcceptRequestUseCase(), fetchCompanyInfoUseCase: getFetchCompanyInformationUseCase(), factory: getURLRequestFactory(), presenter: presenter)
    }
    
    func getJobRequestHistoryInteractor(presenter: JobRequestHistoryPresenter) -> JobRequestHistoryInteractor {
        return JobRequestHistoryInteractorImpl(fetchHistoryRequestUseCase: getFetchRequestHistoryUseCase(), fetchCompanyUseCase: getFetchCompanyInformationUseCase(), factory: getURLRequestFactory(), presenter: presenter)
    }
    
    func getJobRequestHistoryDetailsInteractor(presenter: RequestHistoryDetailPresenter) -> RequestHistoryDetailInteractor {
        return RequestHistoryDetailInteractorImpl(fetchCompanyInformationUseCase: getFetchCompanyInformationUseCase(), presenter: presenter, factory: getURLRequestFactory())
    }
    
    func getSettingInteractor(presenter: SettingPresenter) -> SettingInteractor {
        return SettingInteractorImpl(logOutUseCase: getUserLogOutUseCase(), presenter: presenter, authenticator: getAuthentication(), factory: getURLRequestFactory())
    }
    
    func getSupportInteractor(presenter: SupportPresenter) -> SupportInteractor {
        return SupportInteractorImpl(supportEmailUseCase: getSubmitSupportEmailUseCase(), presenter: presenter, factory: getURLRequestFactory())
        
    }
}



