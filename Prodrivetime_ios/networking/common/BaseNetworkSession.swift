//
//  BaseNetworkSession.swift
//  Prodrivetime_ios
//
//  Created by Wing Sun Cheung on 11/14/19.
//  Copyright © 2019 Wing Sun Cheung. All rights reserved.
//

import Foundation

protocol BaseSessionCallback {
    func onData(data: Data)
    func onResponse(response: HTTPURLResponse)
    func onError(err: BaseNetworkSessionError)
}

enum BaseNetworkSessionError {
    case dataIsEmpty
    case requestFailed
}

class BaseNetworkSession: BaseObservable<BaseSessionCallback> {
    
    private let session: URLSession
    
    init(configuration: URLSessionConfiguration) {
        self.session = URLSession(configuration: configuration)
    }
    
    convenience override init() {
        self.init(configuration: URLSessionConfiguration.default)
    }

    func makeRequest(with request: URLRequest) -> URLSessionDataTask? {

        let task = session.dataTask(with: request) { (data, response, error) in
            
            DispatchQueue.main.async {
                guard let httpResponse = response as? HTTPURLResponse else {
                    return
                }
                
                guard error == nil else {
                    self.getObserver()?.onError(err: .requestFailed)
                    return
                }
                
                guard let data = data else {
                    self.getObserver()?.onError(err: .dataIsEmpty)
                    return
                }
                
                self.getObserver()?.onResponse(response: httpResponse)
                self.getObserver()?.onData(data: data)
            }
        }
        return task
    }
}
