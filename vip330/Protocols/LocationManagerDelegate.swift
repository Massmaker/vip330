//
//  LocationManagerDelegate.swift
//  vip330
//
//  Created by Ivan Yavorin on 1/19/16.
//  Copyright © 2016 Massmaker. All rights reserved.
//

import Foundation
import MapKit

protocol LocationManagerDelegate : class {
    func locationManagerPermissionsStatus(status:CLAuthorizationStatus)
    func locationManagerDidFinishRequestingPermissions(status:CLAuthorizationStatus)
    func locationManagerDidStartRequestingUserLocation()
    func locationManagerUserLocationDidChange(location:CLLocation)
    func locationManagerDidFinishRequestingUserLocation()
}