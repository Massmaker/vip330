//
//  AuthenticationManagement.swift
//  vip330
//
//  Created by Ivan Yavorin on 1/18/16.
//  Copyright © 2016 Massmaker. All rights reserved.
//

import Foundation

protocol UserDefaultsManagement
{
    func getEmailFromDefaults() -> String?
    func setEmailToDefaults(email:String?)
    func getPasswordFromDefault() -> String?
    func setPasswordToDefaults(password:String?)
    func setUserIDToDefaults(userId:String?)
    func getUserIdFromDefaults() -> String?
    func syncronyzeDefaults()
}