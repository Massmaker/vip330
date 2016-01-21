//
//  AuthenticationManager.swift
//  vip330
//
//  Created by Ivan Yavorin on 1/18/16.
//  Copyright © 2016 Massmaker. All rights reserved.
//

import UIKit

class DefaultsManager:UserDefaultsManagement {
    
    private let defaults = NSUserDefaults.standardUserDefaults()
    
    func syncronyzeDefaults() {
        defaults.synchronize()
    }
    
    func getEmailFromDefaults() -> String? {
        return defaults.objectForKey(UserDefaultsKeys.Email.rawValue) as? String
    }
    
    func setEmailToDefaults(email: String?) {
        defaults.setObject(email, forKey: UserDefaultsKeys.Email.rawValue)
    }
    
    func getPasswordFromDefaults() -> String? {
        return defaults.objectForKey(UserDefaultsKeys.Password.rawValue) as? String
    }
    
    func setPasswordToDefaults(password: String?) {
        defaults.setObject(password, forKey: UserDefaultsKeys.Password.rawValue)
    }
    
    func setUserIDToDefaults(userId:String?)
    {
        defaults.setObject(userId, forKey: UserDefaultsKeys.UserID.rawValue)
    }
    
    func getUserIdFromDefaults() -> String?
    {
        return defaults.objectForKey(UserDefaultsKeys.UserID.rawValue) as? String
    }
    
    func getDiscountImageFromDocumentsForUserId(userId:String) -> UIImage?
    {
        let docsPath = documentsFolder()
        let imagePath = docsPath.stringByAppendingPathComponent("\(userId).png")
        guard let data = NSData(contentsOfFile: imagePath), image = UIImage(data: data) else
        {
            return nil
        }
        
        return image
    }
    
    func saveDiscountImageToDocuments(image:UIImage, forUserId:String)
    {
        let dataToSave = UIImagePNGRepresentation(image)
        
        let docsPath = documentsFolder()
        
        let filePath = docsPath.stringByAppendingPathComponent("\(forUserId).png")
        
        dataToSave?.writeToFile(filePath, atomically: true)
    }
    
    private func documentsFolder() -> NSString
    {
        return NSSearchPathForDirectoriesInDomains(NSSearchPathDirectory.DocumentDirectory , NSSearchPathDomainMask.UserDomainMask, true).last! as NSString
    }
    
}