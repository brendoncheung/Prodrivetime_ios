//
//  Authentication.swift
//  Prodrivetime_ios
//
//  Created by Wing Sun Cheung on 12/3/19.
//  Copyright © 2019 Wing Sun Cheung. All rights reserved.
//

import Foundation

protocol Authentication {
    func saveUsernameAndPassword(username: String, password: String)
    func clear()
    func loadUsername() -> String
    func loadPassword() -> String
    func setShouldAutoLogin(to bool: Bool)
    func shouldAutoLogin() -> Bool
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
    
    private let USERNAME_KEY = "USERNAME"
    private let AUTO_LOGIN_KEY = "AUTOLOGIN"
    private let keychainPasswordItem: KeychainPasswordItem
    private let userdefaults: UserDefaults
    
    init(keychainPasswordItem: KeychainPasswordItem,
         userdefaults: UserDefaults) {
        self.keychainPasswordItem = keychainPasswordItem
        self.userdefaults = userdefaults
    }
    
    func saveUsernameAndPassword(username: String, password: String) {
        userdefaults.setValue(username, forKey: USERNAME_KEY)
        try? keychainPasswordItem.savePassword(password)
    }
    
    func setShouldAutoLogin(to bool: Bool) {
        userdefaults.set(bool, forKey: AUTO_LOGIN_KEY)
    }

    func shouldAutoLogin() -> Bool {
        return userdefaults.bool(forKey: AUTO_LOGIN_KEY)
    }
    
    func clear() {
        userdefaults.setValue("", forKey: USERNAME_KEY)
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
