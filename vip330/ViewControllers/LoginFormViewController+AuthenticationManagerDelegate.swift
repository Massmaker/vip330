//
//  LoginFormViewController+AuthenticationManagerDelegate.swift
//  vip330
//
//  Created by Ivan Yavorin on 1/19/16.
//  Copyright © 2016 Massmaker. All rights reserved.
//

import Foundation
import UIKit

extension LoginFormViewController:AuthenticationManagerDelegate {
    func authenticationProcessDidStart() {
        UIApplication.sharedApplication().networkActivityIndicatorVisible = true
        self.userPassword = ""
        self.checkLoginButtonEnabled()
    }
    
    func loginProcessDidFinishWithresult(userId: String, error: NetworkingError?) {
        UIApplication.sharedApplication().networkActivityIndicatorVisible = false
    }
    
    func registrationProcessDidFinishWithResult(userId: String?, error: NetworkingError?) {
        UIApplication.sharedApplication().networkActivityIndicatorVisible = false
    }
}