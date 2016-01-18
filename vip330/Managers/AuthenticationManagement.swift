//
//  AuthenticationManagement.swift
//  vip330
//
//  Created by Ivan Yavorin on 1/18/16.
//  Copyright © 2016 Massmaker. All rights reserved.
//

import Foundation
protocol AuthenticationManagement {
    var delegate:AuthenticationManagerDelegate?{get set}
    func startCredentialsChecking()
    
}