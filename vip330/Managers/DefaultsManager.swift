//
//  AuthenticationManager.swift
//  vip330
//
//  Created by Ivan Yavorin on 1/18/16.
//  Copyright © 2016 Massmaker. All rights reserved.
//

import Foundation
class DefaultsManager:UserDefaultsManagement {
    
    private let defaults = NSUserDefaults.standardUserDefaults()
    
    func syncronyzeDefaults() {
        defaults.synchronize()
    }
    
    func getEmailFromDefaults() -> String? {
        return defaults.objectForKey(UserDefaultsKeys.Email.rawValue) as? String
    }
    
    func setEmailToDefaults(email: String?) {
        defaults.setObject(email, forKey: UserDefaultsKeys.Email.rawValue)
    }
    
    func getPasswordFromDefaults() -> String? {
        return defaults.objectForKey(UserDefaultsKeys.Password.rawValue) as? String
    }
    
    func setPasswordToDefaults(password: String?) {
        defaults.setObject(password, forKey: UserDefaultsKeys.Password.rawValue)
    }
    
    func setUserIDToDefaults(userId:String?)
    {
        defaults.setObject(userId, forKey: UserDefaultsKeys.UserID.rawValue)
    }
    
    func getUserIdFromDefaults() -> String?
    {
        return defaults.objectForKey(UserDefaultsKeys.UserID.rawValue) as? String
    }
    
}