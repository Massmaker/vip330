//
//  MainMapViewController.swift
//  vip330
//
//  Created by Ivan Yavorin on 1/19/16.
//  Copyright © 2016 Massmaker. All rights reserved.
//

import UIKit
import MapKit

class MainMapViewController: UIViewController {

    @IBOutlet weak var mapView:MKMapView!
    lazy var locationManager = LocationManager()
    lazy var discountsManager = GeodataObjectsManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.mapView.setRegion(locationManager.defaultLocation, animated: false)
        
        self.discountsManager.delegate = self
        self.discountsManager.loadGeodatasFromServer()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        mapView.showsUserLocation = true
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewWillAppear(animated)
        locationManager.delegate = self
        if self.locationManager.checkLocationServicesEnabled()
        {
            self.locationManager.checkPermissions()
        }
    }

}
