//
//  MainMapViewCoontroller+GeodataObjectsManagerDeleate.swift
//  vip330
//
//  Created by Ivan Yavorin on 1/21/16.
//  Copyright © 2016 Massmaker. All rights reserved.
//

import Foundation
import UIKit

extension MainMapViewController: GeodataObjectsManagerDeleate{
    func managerDidStartLoadingGeodata() {
        UIApplication.sharedApplication().networkActivityIndicatorVisible = true
    }
    
    func managerDidFinishLoadingGeodata(datas: [DiscountGeodata]) {
        UIApplication.sharedApplication().networkActivityIndicatorVisible = false
    }

    func managerDidFailToLoadGeodata(error: ErrorType) {
        UIApplication.sharedApplication().networkActivityIndicatorVisible = false
        
        if let anError = error as? NetworkingError
        {
            switch anError{
            case .Unknown(let message):
                 self.showAlertWithTitle("Failed to load discounts data", message: "Unknown error: \(message)", cancelButtonTitle: "Ok")
            case .Failure(let code, let message):
                self.showAlertWithTitle("Failed to load discounts data", message: "Error: code:\(code), message:\(message)", cancelButtonTitle: "Ok")
            }
        }
       
    }
}