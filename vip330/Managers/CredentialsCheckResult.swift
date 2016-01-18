//
//  CredentialsCheckResult.swift
//  vip330
//
//  Created by Ivan Yavorin on 1/18/16.
//  Copyright © 2016 Massmaker. All rights reserved.
//

import Foundation
enum CredentialsCheckResult
{
    case AllCredentials(email:String, password:String, userID:String)
    case NoCredentials
    case EmailOnly(email:String)
    case EmailAndPassword(email:String, password:String)
}