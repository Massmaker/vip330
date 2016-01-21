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
    private var updatingLocation:Bool = false

    var isUpdatingLocation:Bool{
        return self.updatingLocation
    }
    
    private let locationManager:CLLocationManager
    
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
        
        if self.updatingLocation{
            return
        }
        
        self.updatingLocation = true
        
        self.delegate?.locationManagerDidStartRequestingUserLocation()
        
        locationManager.distanceFilter = CLLocationDistance(50.0)
        locationManager.desiredAccuracy = kCLLocationAccuracyHundredMeters
        locationManager.startUpdatingLocation()
        
    }
    
    func stopMonitoringUserLocationn() {
        locationManager.stopUpdatingLocation()
        self.updatingLocation = false
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
//            print("locations:")
//            for aLoc in locations
//            {
//                print(aLoc.description)
//            }
            
            self.delegate?.locationManagerUserLocationDidChange(locations.first!)
        }
    }
    
    func locationManager(manager: CLLocationManager, didFailWithError error: NSError) {
        print("location error: \(error.userInfo)")
        
//        locationManager.stopUpdatingLocation()
//        self.updatingLocation = false
//        
//        self.delegate?.locationManagerDidFinishRequestingUserLocation()
    }
    
    func locationManagerDidPauseLocationUpdates(manager: CLLocationManager) {
        print(" PAUSED location updates")
    }
    
    func locationManagerDidResumeLocationUpdates(manager: CLLocationManager) {
        print(" RESUMED location updates")
    }
    
}