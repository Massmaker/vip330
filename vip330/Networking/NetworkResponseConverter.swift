//
//  NetworkResponseConverter.swift
//  vip330
//
//  Created by Ivan Yavorin on 1/19/16.
//  Copyright © 2016 Massmaker. All rights reserved.
//

import Foundation
import AEXML

class NetworkXMLResponseConverter {
    
    @warn_unused_result
    class func parseLoginResponse(data:NSData) -> NetworkingResponse
    {
        do{
            let xmlDoc = try AEXMLDocument(xmlData:data)
            print(" - starting")
            print(xmlDoc.xmlString)
            let root = xmlDoc.root
            
            if let firstChild = root.children.first, value = firstChild.value
            {
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
                    return NetworkingResponse.Failure(error:NetworkingError.Failure(code: -1, message: "error from server"))
                }
            }
        }
        catch let error{
            print(" error while parsing XML:")
            print(error)
        }
        return NetworkingResponse.Success(response: nil)
    }
}