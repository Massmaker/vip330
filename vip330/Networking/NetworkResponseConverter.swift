//
//  NetworkResponseConverter.swift
//  vip330
//
//  Created by Ivan Yavorin on 1/19/16.
//  Copyright © 2016 Massmaker. All rights reserved.
//

import Foundation
import AEXML
import MapKit

let UnparsableXMLError = NetworkingResponse.Failure(error:NetworkingError.Failure(code: -2, message: "unable to parse response"))

class NetworkXMLResponseConverter {
    
    @warn_unused_result
    class func parseLoginResponse(data:NSData) -> NetworkingResponse
    {
        do{
            let xmlDoc = try AEXMLDocument(xmlData:data)
            print(" - starting")
            //print(xmlDoc.xmlString)
            let root = xmlDoc.root
            
            guard let firstChild = root.children.first, value = firstChild.value else
            {
                return UnparsableXMLError
            }
            
            if value == "success"
            {
                let secondChild = root.children[1]
                if let userId = secondChild.value
                {
                    print(" - Logged user id: \(userId)")
                    return NetworkingResponse.Success(response: ["userId":userId])
                }
            }
            else if value == "error"
            {
                return NetworkingResponse.Failure(error:NetworkingError.Failure(code: -1, message: "check entered data"))
            }
        }
        catch let error{
            print(" error while parsing XML:")
            print(error)
            return UnparsableXMLError
        }
        return NetworkingResponse.Success(response: nil)
    }
    
    @warn_unused_result
    class func parseRegistrationResponse(data:NSData) -> NetworkingResponse
    {
        do{
            let xmlDoc = try AEXMLDocument(xmlData: data)
            print("- Starting reg response parsing")
            //print(xmlDoc.xmlString)
            let root = xmlDoc.root
            
            guard let firstChild = root.children.first, value = firstChild.value else
            {
                return UnparsableXMLError
            }
            
            if value == "Success"
            {
                let secondChild = root.children[1]
                if let userId = secondChild.value
                {
                    print(" - Registered user id: \(userId)")
                    return NetworkingResponse.Success(response: ["userId":userId])
                }
            }
            else if value == "error"
            {
                return NetworkingResponse.Failure(error:NetworkingError.Failure(code: -1, message: "check entered data"))
            }

        }
        catch let xmlError{
            print(" error while parsing XML:")
            print(xmlError)
            return UnparsableXMLError
        }
        return NetworkingResponse.Success(response: nil)
    }
    
    @warn_unused_result
    class func parseGeodataResponse(data:NSData) -> NetworkingResponse
    {
        do{
            
            let xmlDoc = try AEXMLDocument(xmlData: data)
            print("- Starting reg response parsing")
            //print(xmlDoc.xmlString)
            let root = xmlDoc.root
            //print("root: \(root)")
            
            guard root.children.count > 0 else
            {
                return UnparsableXMLError
            }
            
            var discountDatasToReturn = [DiscountGeodata]()
            
            for aChild in root.children
            {
                guard let title = aChild["title"].value else
                {
                    continue
                }
                let description = aChild["description"].value
                let phoneNumber = aChild["phone"].value
                let address = aChild["address"].value
                let longtitudeValue = aChild["lng"].doubleValue
                let lattitudeValue = aChild["lat"].doubleValue
                let coordinate = CLLocationCoordinate2D(latitude: CLLocationDegrees(lattitudeValue), longitude: CLLocationDegrees(longtitudeValue))
                
                guard let discountMarker = DiscountGeodata(location: coordinate, title: title) else
                {
                    continue
                }
                
                discountMarker.phone = phoneNumber
                discountMarker.address = address
                discountMarker.details = description
                discountDatasToReturn.append(discountMarker)
            }
            
            return NetworkingResponse.Success(response: discountDatasToReturn)
            
        }
        catch let error
        {
            print(" error while parsing XML:")
            print(error)
            return UnparsableXMLError
        }

    }
    
    @warn_unused_result
    class func convertImageDataToImage(data:NSData) -> NetworkingResponse
    {
        return NetworkingResponse.Failure(error: NetworkingError.Unknown(message: "default implementation"))
    }
    
}