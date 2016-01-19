//
//  UIViewController+Extensions.swift
//  vip330
//
//  Created by Ivan Yavorin on 1/20/16.
//  Copyright © 2016 Massmaker. All rights reserved.
//

import Foundation
import UIKit

extension UIViewController
{
    func showAlertWithTitle(alertTitle:String, message:String, cancelButtonTitle:String, cancelButtonAction:(()->())? = nil, presentationCompletion:(()->())? = nil)
    {
//        if #available (iOS 8.0, *)
//        {
            let closeAction:UIAlertAction = UIAlertAction(title: cancelButtonTitle as String, style: .Cancel, handler: nil)
            let alertController = UIAlertController(title: alertTitle, message: message, preferredStyle: .Alert)
            alertController.addAction(closeAction)
            
            self.presentViewController(alertController, animated: true, completion: presentationCompletion)
//        }
//        else
//        {
//            UIAlertView(title: alertTitle, message: message, delegate: nil, cancelButtonTitle: cancelButtonTitle).show()
//        }
    }
}