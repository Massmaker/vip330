//
//  MainMapViewController+LocationManagerDelegate.swift
//  vip330
//
//  Created by Ivan Yavorin on 1/20/16.
//  Copyright © 2016 Massmaker. All rights reserved.
//

import Foundation
import MapKit

extension MainMapViewController:LocationManagerDelegate{
    func locationManagerPermissionsStatus(status: CLAuthorizationStatus) {
        
        switch status
        {
            case .NotDetermined:
                self.locationManager.askForLocationUsage()
            case .Restricted:
                //TODO: show alert
                print("Location access RESTRICTED")
            case .Denied:
                //TODO: show alert
                print("Location access DENIED")
            case .AuthorizedWhenInUse:
                self.locationManager.detectUserLocation()
            case .AuthorizedAlways:
                break
            
        }
    }
    
    func locationManagerDidFinishRequestingPermissions(status: CLAuthorizationStatus) {
        
        switch status
        {
            case .NotDetermined:
                self.locationManager.askForLocationUsage()
            case .Restricted:
                //TODO: show alert
                print("Location access RESTRICTED")
            case .Denied:
                //TODO: show alert
                print("Location access DENIED")
            case .AuthorizedWhenInUse:
                if !self.locationManager.isUpdatingLocation
                {
                    self.locationManager.detectUserLocation()
                }
            case .AuthorizedAlways:
                break
            
        }
    }
    
    func locationManagerDidStartRequestingUserLocation() {
        print(" DID START requesting location")
    }
    
    func locationManagerDidFinishRequestingUserLocation() {
        print(" DID FINISH requesting location")
    }
    
    func locationManagerUserLocationDidChange(location: CLLocation) {
        self.mapView.setCenterCoordinate(location.coordinate, animated: true)
    }
}