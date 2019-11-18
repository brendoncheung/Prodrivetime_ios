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
    func onError(msg: String, err: Error?)
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
            
            guard let httpResponse = response as? HTTPURLResponse else {
                return
            }
            
            guard error == nil else {
                print("1")
                self.getObservers().forEach({ (callback) in
                    callback.onError(msg: error.debugDescription, err: error)
                })
                return
            }
            
            guard let data = data else {
                print("2")
                self.getObservers().forEach({ (callback) in
                    callback.onError(msg: "Empty data", err: error)
                })
                return
            }
            self.getObservers().forEach({ (callback) in
                callback.onResponse(response: httpResponse)
            })
            
            self.getObservers().forEach({ (callback) in
                callback.onData(data: data)
            })
        }
        return task
    }
}
