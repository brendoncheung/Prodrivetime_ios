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
    func unregisterObserver(observer: T)
    func getObservers() -> [T]
}

class BaseObservable <T>: Observable {
    
    private var observers = [T]()
    
    func registerObserver(observer: T) {
        
        observers.append(observer)
    }
    
    func unregisterObserver(observer: T) {
        // TODO:
    }
    
    func getObservers() -> [T] {
        return observers
    }
    
    
}
