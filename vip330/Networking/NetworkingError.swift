//
//  NetworkingError.swift
//  vip330
//
//  Created by Ivan Yavorin on 1/18/16.
//  Copyright © 2016 Massmaker. All rights reserved.
//

import Foundation
enum NetworkingError:ErrorType{
    case Failure(code:Int, message:String?)
    case Unknown(message:String?)
    
    var displayMessage:String{
        switch self
        {
            case .Failure(let code, let message):
                let realMessage = message ?? "undefined"
                return "code: \(code), reason:\(realMessage)"
            case .Unknown(let message):
                let realMessage = message ?? "undefined"
                return "reason: \(realMessage)"
        }
    }
}