//
//  UserPreRegistrationData.swift
//  vip330
//
//  Created by Ivan Yavorin on 1/21/16.
//  Copyright © 2016 Massmaker. All rights reserved.
//

import Foundation
class UserPreRegistrationData {
    
    lazy var username:String = ""
    lazy var email = ""
    lazy var confirmEmail = ""
    lazy var password = ""
    lazy var confirmPassword = ""
    
    var userDataSuccessfull:Bool  {
        
        guard password == confirmPassword && password.characters.count > 0 else
        {
            return false
        }
        
        guard email == confirmEmail && email.characters.count > 0 else
        {
            return false
        }
        
        guard username.characters.count > 0 else
        {
            return false
        }
        
        return true
    }
}