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
    var title:String!
    var coordinates:CLLocationCoordinate2D!
    
    var details:String?
    var address:String?
    var phone:String?
    
    
    init()
    {
        self.title = ""
        self.coordinates = CLLocationCoordinate2DMake(CLLocationDegrees(0.0), CLLocationDegrees(0.0))
    }
    
    convenience init?(location:CLLocationCoordinate2D, title:String?)
    {
        self.init()
        
        guard let _ = title else
        {
            return nil
        }
        self.title = title!
        self.coordinates = location
        
    }
}