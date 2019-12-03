//
//  ProdrivetimeDataTask.swift
//  Prodrivetime_ios
//
//  Created by Wing Sun Cheung on 11/12/19.
//  Copyright © 2019 Wing Sun Cheung. All rights reserved.
//

import Foundation

protocol Observable: class {
    associatedtype T
    func registerObserver(observer: T)
    func unregisterObserver()
    func getObserver() -> T?
}

class BaseObservable <T>: Observable {
    
    private var observer: T?
    
    func registerObserver(observer: T) {
        
        self.observer = observer
    }
    
    func unregisterObserver() {
        self.observer = nil
    }
    
    func getObserver() -> T? {
        return observer
    }
    
    
}
