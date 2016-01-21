//
//  DiscountGeodata.swift
//  vip330
//
//  Created by Ivan Yavorin on 1/21/16.
//  Copyright © 2016 Massmaker. All rights reserved.
//

import Foundation
import MapKit

class DiscountGeodata {
    let title:String
    let details:String
    let address:String
    let coordinates:CLLocationCoordinate2D
    
    init(location:CLLocationCoordinate2D, address:String, title:String, description:String)
    {
        self.address = address
        self.details = description
        self.title = title
        self.coordinates = location
    }
}