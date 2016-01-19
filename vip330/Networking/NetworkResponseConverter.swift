//
//  NetworkResponseConverter.swift
//  vip330
//
//  Created by Ivan Yavorin on 1/19/16.
//  Copyright © 2016 Massmaker. All rights reserved.
//

import Foundation

class NetworkXMLResponseConverter {
    
    func parseResponse(data:NSData) -> NetworkingResponse
    {
        do{
            let xmlDoc = try AEXMLDocument(xmlData:data)
        }
        catch{
            
        }
        return NetworkingResponse.Success(response: nil)
    }
}