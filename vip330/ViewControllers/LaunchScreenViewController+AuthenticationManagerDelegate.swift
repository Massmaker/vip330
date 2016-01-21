//
//  LaunchScreenViewController+AuthenticationManagerDelegate.swift
//  vip330
//
//  Created by Ivan Yavorin on 1/18/16.
//  Copyright © 2016 Massmaker. All rights reserved.
//

import Foundation
import UIKit

extension AuthenticationManagerDelegate{
    //making all methods optional
    func authenticatorCredenticlaCheckResult(result: CredentialsCheckResult) {
        assert(false, "\"authenticatorCredenticlaCheckResult\" method not implemented")
    }
    
    func authenticationProcessDidStart(){
        assert(false, "\"loginProcessDidStart\" method not implemented")
    }
    
    func loginProcessDidFinishWithResult(userId:String, error:NetworkingError?){
        assert(false, "\"loginProcessDidFinishWithresult\" method not implemented")
    }
    
    func registrationProcessDidFinishWithResult(userId:String?, error:NetworkingError?){
        assert(false, "\"registrationProcessDidFinishWithResult\" method not implemented")
    }
}

extension LaunchScreenViewController:AuthenticationManagerDelegate
{
    func authenticatorCredenticlaCheckResult(result: CredentialsCheckResult) {
        switch result{
            case .AllCredentials(let email ,  _ ,  _):
                self.showMapViewScreen(email)
            case .EmailAndPassword(let email, let password):
                self.authManager.loginWithParameters(email, password: password)
            case .EmailOnly( _ ):
                fallthrough
            case .NoCredentials:
                self.showLoginScreen(result)
        }
    }
    
    func authenticationProcessDidStart()
    {
        UIApplication.sharedApplication().networkActivityIndicatorVisible = true
    }
    
    func loginProcessDidFinishWithResult(userId:String, error:NetworkingError?)
    {
        UIApplication.sharedApplication().networkActivityIndicatorVisible = false
    }
    
    func registrationProcessDidFinishWithResult(userId:String?, error:NetworkingError?)
    {
        UIApplication.sharedApplication().networkActivityIndicatorVisible = false
    }
}