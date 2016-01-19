//
//  AuthenticationManagerDelegate.swift
//  vip330
//
//  Created by Ivan Yavorin on 1/18/16.
//  Copyright © 2016 Massmaker. All rights reserved.
//

import Foundation
protocol AuthenticationManagerDelegate:class {
    func authenticatorCredenticlaCheckResult(result:CredentialsCheckResult)
    func authenticationProcessDidStart()
    func loginProcessDidFinishWithresult(userId:String, error:NetworkingError?)
    func registrationProcessDidFinishWithResult(userId:String?, error:NetworkingError?)
}