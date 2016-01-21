//
//  AuthenticationManagement.swift
//  vip330
//
//  Created by Ivan Yavorin on 1/18/16.
//  Copyright © 2016 Massmaker. All rights reserved.
//

import UIKit

protocol UserDefaultsManagement
{
    func getEmailFromDefaults() -> String?
    func setEmailToDefaults(email:String?)
    func getPasswordFromDefaults() -> String?
    func setPasswordToDefaults(password:String?)
    func setUserIDToDefaults(userId:String?)
    func getUserIdFromDefaults() -> String?
    func getDiscountImageFromDocumentsForUserId(userId:String) -> UIImage?
    func saveDiscountImageToDocuments(image:UIImage, forUserId:String)
    func syncronyzeDefaults()
}