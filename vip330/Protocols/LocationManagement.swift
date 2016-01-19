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
    func checkPermissions()
    func askForLocationUsage()
    func detectUserLocation()
}