//
//  LocationMamager.swift
//  vip330
//
//  Created by Ivan Yavorin on 1/19/16.
//  Copyright © 2016 Massmaker. All rights reserved.
//

import Foundation
import MapKit

class LocationManager: NSObject , LocationManagement {
    
    weak var delegate:LocationManagerDelegate?
    let locationManager:CLLocationManager
    override init()
    {
        self.locationManager = CLLocationManager()
    }
    
    func checkPermissions() {

        let status = CLLocationManager.authorizationStatus()
        self.delegate?.locationManagerPermissionsStatus(status)
    }
    
    func checkLocationServicesEnabled() -> Bool {
        return CLLocationManager.locationServicesEnabled()
    }
    
    func askForLocationUsage() {
        locationManager.requestWhenInUseAuthorization()
        locationManager.delegate = self
    }
    
    func detectUserLocation() {
        if locationManager.delegate == nil
        {
            locationManager.delegate = self
        }
        
        if let lastKnownLocation = locationManager.location
        {
            self.delegate?.locationManagerUserLocationDidChange(lastKnownLocation)
        }
        
        
        self.delegate?.locationManagerDidStartRequestingUserLocation()
        
        locationManager.distanceFilter = CLLocationDistance(10.0)
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.startUpdatingLocation()
    }
    
    func stopMonitoringUserLocationn() {
        locationManager.stopUpdatingLocation()
        self.delegate?.locationManagerDidFinishRequestingUserLocation()
    }
}

extension LocationManager:CLLocationManagerDelegate {
    func locationManager(manager: CLLocationManager, didChangeAuthorizationStatus status: CLAuthorizationStatus) {
        self.delegate?.locationManagerDidFinishRequestingPermissions(status)
    }
    
    func locationManager(manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if locations.isEmpty
        {
            print("updated no locations")
        }
        else
        {
            print("locations:")
            for aLoc in locations
            {
                print(aLoc.description)
            }
        }
    }
    
    func locationManager(manager: CLLocationManager, didFailWithError error: NSError) {
        print("location error: \(error.description)")
    }
    
}