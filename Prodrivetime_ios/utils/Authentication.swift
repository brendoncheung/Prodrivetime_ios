//
//  Authentication.swift
//  Prodrivetime_ios
//
//  Created by Wing Sun Cheung on 12/3/19.
//  Copyright © 2019 Wing Sun Cheung. All rights reserved.
//

import Foundation

protocol Authentication {
    func saveUsername(username: String)
    func savePassword(password: String)
    func clear()
    func loadUsername() -> String
    func loadPassword() -> String
}

protocol AuthenticationErrorDelegate: class {
    func authenticationError(error: AuthenticationError)
}

enum AuthenticationError{
    case noPassword
    case unexpectedPasswordData
    case unexpectedItemData
    case unhandledError
}

class AuthenticationImpl: Authentication {
    
    private let keychainPasswordItem: KeychainPasswordItem
    private let KeychainConfiguration: KeychainConfiguration
    private let USERNAME_KEY = "USERNAME"
    private weak var delegate: AuthenticationErrorDelegate?
    
    init(keychainPasswordItem: KeychainPasswordItem,
         KeychainConfiguration: KeychainConfiguration,
         delegate: AuthenticationErrorDelegate) {
        self.keychainPasswordItem = keychainPasswordItem
        self.KeychainConfiguration = KeychainConfiguration
        self.delegate = delegate
    }
    
    func saveUsername(username: String) {
        UserDefaults.standard.setValue(username, forKey: USERNAME_KEY)
    }
    
    func savePassword(password: String) {
        try? keychainPasswordItem.savePassword(password)
    }
    
    func clear() {
        try? keychainPasswordItem.deleteItem()
    }
    
    func loadUsername() -> String {
        
        guard let username = UserDefaults.standard.string(forKey: USERNAME_KEY) else {
            return ""
        }
        
        return username
    }
    
    func loadPassword() -> String {
        return try! keychainPasswordItem.readPassword()
    }
    
    
    
    
    
    
}
