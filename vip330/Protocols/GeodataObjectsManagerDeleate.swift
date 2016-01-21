//
//  GeodataObjectsManagerDeleate.swift
//  vip330
//
//  Created by Ivan Yavorin on 1/21/16.
//  Copyright © 2016 Massmaker. All rights reserved.
//

import Foundation

protocol GeodataObjectsManagerDeleate:class {
    
    func managerDidStartLoadingGeodata()
    func managerDidFinishLoadingGeodata(datas:[DiscountGeodata])
    func managerDidFailToLoadGeodata(error:ErrorType)
    
}