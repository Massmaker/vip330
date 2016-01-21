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
    
    
    func setLoadingIndicatorVisible(visible:Bool)
    {
        if visible
        {
            if let indicator = self.view.viewWithTag(0x70AD) as? UIActivityIndicatorView
            {
                if indicator.isAnimating()
                {
                    return //already showing
                }
                else
                {
                    indicator.startAnimating()
                }
                return
            }
            
            let indicatorView = UIActivityIndicatorView(activityIndicatorStyle: UIActivityIndicatorViewStyle.WhiteLarge)
            indicatorView.tag = 0x70AD
            let frame = CGRectMake(0, 0, 200.0, 200.0)
            indicatorView.frame = frame
            indicatorView.layer.cornerRadius = 7.0
            indicatorView.backgroundColor = UIColor.blackColor().colorWithAlphaComponent(0.7)
            indicatorView.center = CGPointMake(CGRectGetMidX(self.view.bounds), CGRectGetMidY(self.view.bounds))
            indicatorView.autoresizingMask =  [.FlexibleLeftMargin , .FlexibleRightMargin , .FlexibleTopMargin , .FlexibleBottomMargin]
            self.view.addSubview(indicatorView)
            indicatorView.startAnimating()
        }
        else
        {
            if let indicator = self.view.viewWithTag(0x70AD) as? UIActivityIndicatorView
            {
                indicator.stopAnimating()
            }
        }
    }
    
}