//
//  GeodataObjectsManager.swift
//  vip330
//
//  Created by Ivan Yavorin on 1/21/16.
//  Copyright © 2016 Massmaker. All rights reserved.
//

import Foundation
import MapKit

class GeodataObjectsManager {
    private lazy var networkRequester = NetworkApiCaller()
    private var _currentDiscountGeodatas = [DiscountGeodata]()
    weak var delegate:GeodataObjectsManagerDeleate?
    weak var mapView:MKMapView?
    var currentDiscountGeodatas:[DiscountGeodata] {
        return self._currentDiscountGeodatas
    }
    
    func loadGeodatasFromServer()
    {
        self.delegate?.managerDidStartLoadingGeodata()
        self.networkRequester.loadGeoData { (response) -> () in
            switch response
            {
                case .Success(let response):
                    if let discountDatas = response as? [DiscountGeodata]
                    {
                        self._currentDiscountGeodatas = discountDatas
                        
                        var annotations = [MKPointAnnotation]()
                        
                        for aDiscount in self.currentDiscountGeodatas
                        {
                            let anAnnotation = MKPointAnnotation()
                            anAnnotation.title = aDiscount.title
                            anAnnotation.subtitle = aDiscount.details
                            anAnnotation.coordinate = aDiscount.coordinates
                            annotations.append(anAnnotation)
                        }
                        
                        dispatchAsyncMain(){[weak self] in
                            self?.mapView?.addAnnotations(annotations)
                            self?.delegate?.managerDidFinishLoadingGeodata(discountDatas)
                        }
                    }
                case .Failure(let error):
                    dispatchAsyncMain(){[weak self] in
                        self?.delegate?.managerDidFailToLoadGeodata(error)
                    }
            }
            
        }
    }
    
}