//
//  AuthenticationManagement.swift
//  vip330
//
//  Created by Ivan Yavorin on 1/18/16.
//  Copyright © 2016 Massmaker. All rights reserved.
//

import Foundation
protocol AuthenticationManagement:class {
    var delegate:AuthenticationManagerDelegate?{get set}
    func startCredentialsChecking()
    func loginWithParameters(email:String, password:String)
    func registerWithParameters(username: String, email:String, password:String)
    
}