//
//  NetworkingErrors.swift
//  vip330
//
//  Created by Ivan Yavorin on 1/18/16.
//  Copyright © 2016 Massmaker. All rights reserved.
//

import Foundation

enum NetworkingResponse {
    case Success(response:AnyObject?)
    case Failure(error:NetworkingError)
}