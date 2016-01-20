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

extension LocationManagement{
    var defaultLocation:MKCoordinateRegion{
        let region = MKCoordinateRegionMakeWithDistance(CLLocationCoordinate2D(latitude: 52.234641, longitude: 21.018184), 2000, 2000)
        return region
    }
}
