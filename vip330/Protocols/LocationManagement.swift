//
//  LocationManagement.swift
//  vip330
//
//  Created by Ivan Yavorin on 1/19/16.
//  Copyright © 2016 Massmaker. All rights reserved.
//

import MapKit

protocol LocationManagement {
    var delegate:LocationManagerDelegate?{get set}
    var isUpdatingLocation:Bool{get}
    func checkPermissions()
    func checkLocationServicesEnabled() -> Bool
    func askForLocationUsage()
    func detectUserLocation()
    func stopMonitoringUserLocationn()
}
