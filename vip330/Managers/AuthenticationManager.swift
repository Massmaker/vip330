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
        
        networkHandler.performLogin([email, password]) {[weak self] (response) in
            switch response
            {
            case .Success(let response):
                if let dict = response as? [String:String], userIdRecieved = dict["userId"]
                {
                    self?.delegate?.loginProcessDidFinishWithResult("\(userIdRecieved)", error: nil)
                    self?.defaultsHandler.setEmailToDefaults(email)
                    self?.defaultsHandler.setPasswordToDefaults(password)
                    self?.defaultsHandler.setUserIDToDefaults(userIdRecieved)
                    self?.defaultsHandler.syncronyzeDefaults()
                }
            case .Failure(let error):
                self?.delegate?.loginProcessDidFinishWithResult("", error: error)
            }
            
        }
    }
    
    func registerWithParameters(username: String, email:String, password:String)
    {
        self.delegate?.authenticationProcessDidStart()
        let userRegData = UserRegistrationData(username:username, email:email, password:password)
        
        networkHandler.performRegistration(userRegData) {[weak self] (response)  in
            switch response
            {
                case .Success(let response):
                    if let dict = response as? [String:String], userIdRecieved = dict["userId"]
                    {
                        self?.defaultsHandler.setEmailToDefaults(email)
                        self?.defaultsHandler.setPasswordToDefaults(password)
                        self?.defaultsHandler.setUserIDToDefaults(userIdRecieved)
                        self?.defaultsHandler.syncronyzeDefaults()
                        self?.delegate?.registrationProcessDidFinishWithResult(userIdRecieved, error: nil)
                    }
                case .Failure(let error):
                    self?.delegate?.registrationProcessDidFinishWithResult(nil, error: error)
            }
        }
    }
}