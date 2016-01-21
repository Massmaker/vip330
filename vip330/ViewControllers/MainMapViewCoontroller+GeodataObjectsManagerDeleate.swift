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
    }
}