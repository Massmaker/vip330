//
//  AuthenticationManager.swift
//  vip330
//
//  Created by Ivan Yavorin on 1/18/16.
//  Copyright © 2016 Massmaker. All rights reserved.
//

import Foundation
class AuthenticationManager:AuthenticationManagement{
    
    private lazy var defaultsHandler = DefaultsManager()
    private lazy var networkHandler = NetworkApiCaller()
    
    //MARK: - AuthenticationManagement conformance
    weak var delegate:AuthenticationManagerDelegate?
    func startCredentialsChecking() {
        
        let emailFromDefaults = defaultsHandler.getEmailFromDefaults()
        let passFromDefaults = defaultsHandler.getPasswordFromDefaults()
        let userIdFromDefaults = defaultsHandler.getUserIdFromDefaults()
        
        if let email = emailFromDefaults, password = passFromDefaults, userID = userIdFromDefaults
        {
            anAppDelegate()?.currentUserID = userID
            
            self.delegate?.authenticatorCredenticlaCheckResult(CredentialsCheckResult.AllCredentials(email: email, password: password, userID: userID))
        }
        else if let email = emailFromDefaults, password = passFromDefaults
        {
            defaultsHandler.setUserIDToDefaults(nil)
            defaultsHandler.syncronyzeDefaults()
            
            self.delegate?.authenticatorCredenticlaCheckResult(.EmailAndPassword(email:email, password:password))
        }
        else if let email = emailFromDefaults
        {
            defaultsHandler.setUserIDToDefaults(nil)
            defaultsHandler.setPasswordToDefaults(nil)
            defaultsHandler.syncronyzeDefaults()
            self.delegate?.authenticatorCredenticlaCheckResult(.EmailOnly(email:email))
        }
        else
        {
            self.delegate?.authenticatorCredenticlaCheckResult(.NoCredentials)
        }
    }
    
    func loginWithParameters(email:String, password:String)
    {
        self.delegate?.authenticationProcessDidStart()
        //network handler login with params
        networkHandler.performLogin([email, password]) {[weak self] (response) in
            switch response
            {
            case .Success(let response):
                if let dict = response as? [String:String], userIdRecieved = dict["userId"]
                {
                    self?.delegate?.loginProcessDidFinishWithresult("\(userIdRecieved)", error: nil)
                }
            case .Failure(let error):
                self?.delegate?.loginProcessDidFinishWithresult("", error: error)
            }
            
        }
    }
    
    func registerWithParameters(email:String, password:String)
    {
        self.delegate?.authenticationProcessDidStart()
        //network handler register with params
    }
}