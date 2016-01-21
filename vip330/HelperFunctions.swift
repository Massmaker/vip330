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

func dispatchAsyncMain(block:dispatch_block_t)
{
    dispatch_async(dispatch_get_main_queue(),block)
}

func dispatchAsyncBackground(block:dispatch_block_t)
{
    dispatch_async(dispatch_get_global_queue(QOS_CLASS_UTILITY, 0), block)
}