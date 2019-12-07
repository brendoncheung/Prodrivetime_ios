//
//  FetchFireBaseTokenUseCase.swift
//  Prodrivetime_ios
//
//  Created by Wing Sun Cheung on 11/13/19.
//  Copyright © 2019 Wing Sun Cheung. All rights reserved.
//

import Foundation
import FirebaseMessaging

protocol FetchFireBaseTokenUseCaseDelegate {
    func onFirebaseTokenFetched(token: String)
}

class FetchFireBaseTokenUseCase: BaseObservable<FetchFireBaseTokenUseCaseDelegate> {
    
    func fetchFireBaseTokenAndNotify() {
        
        guard let firebaseToken = Messaging.messaging().fcmToken else {
            return
        }
        
        getObserver()?.onFirebaseTokenFetched(token: firebaseToken)
        
        
    }
}
