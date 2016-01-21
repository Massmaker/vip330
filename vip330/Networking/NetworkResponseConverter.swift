//
//  NetworkResponseConverter.swift
//  vip330
//
//  Created by Ivan Yavorin on 1/19/16.
//  Copyright © 2016 Massmaker. All rights reserved.
//

import Foundation
import AEXML

let UnparsableXMLError = NetworkingResponse.Failure(error:NetworkingError.Failure(code: -2, message: "unable to parse response"))

class NetworkXMLResponseConverter {
    
    @warn_unused_result
    class func parseLoginResponse(data:NSData) -> NetworkingResponse
    {
        do{
            let xmlDoc = try AEXMLDocument(xmlData:data)
            print(" - starting")
            print(xmlDoc.xmlString)
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
            print(xmlDoc.xmlString)
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
}