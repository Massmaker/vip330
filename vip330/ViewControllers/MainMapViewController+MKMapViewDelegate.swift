//
//  MainMapViewController+MKMapViewDelegate.swift
//  vip330
//
//  Created by CloudCraft on 1/21/16.
//  Copyright © 2016 Massmaker. All rights reserved.
//

import Foundation
import MapKit

extension MainMapViewController:MKMapViewDelegate {
    func mapView(mapView: MKMapView, didAddAnnotationViews views: [MKAnnotationView]) {
        print("\n\n - - Map did display pins - - \n")
    }
}