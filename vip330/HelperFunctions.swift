//
//  HelperFunctions.swift
//  vip330
//
//  Created by Ivan Yavorin on 1/18/16.
//  Copyright © 2016 Massmaker. All rights reserved.
//

import Foundation
import UIKit

func anAppDelegate() -> AppDelegate?
{
    guard let delegate = UIApplication.sharedApplication().delegate as? AppDelegate else
    {
        return nil
    }
    
    return delegate
}