//
//  ApiCalls.swift
//  vip330
//
//  Created by Ivan Yavorin on 1/18/16.
//  Copyright © 2016 Massmaker. All rights reserved.
//

import Foundation
import Alamofire

enum ApiCalls{
    case Registeration(userName:String, email:String, password:String)
    case Login(email:String, password:String)
    case RequestGeodata(usedId:String, lattitude:Int, longtitude:Int)
    
    var requestParameters : (method: Alamofire.Method, path: String, parameters:[String:AnyObject]?, body:NSData?) {
        
        var method = Alamofire.Method.POST
        var data:NSData?
        var path:String = ""
        var params:[String:AnyObject]?
        
        switch self
        {
            case .Registeration(let userName, let email, let password) :
                let registerString = "username=\(userName)\nemail=\(email)\n<confirmemail=\(email)\npassword=\(password)\nconfirmpassword=\(password)"
                data = registerString.dataUsingEncoding(NSUTF8StringEncoding)
                path = "com_users/registerFromAndroid"
            
            case .Login(let email, let password):
                let bodyString = "username=\(email)&password=\(password)"
                data = bodyString.dataUsingEncoding(NSUTF8StringEncoding)
                return (method:method, path:"com_users/loginFromAndroid", parameters:nil, body:data)
            
            case .RequestGeodata(let userId, let lattitude, let longtitude):
                let coordinatesString = "<userid>\(userId)<userid><lat>\(lattitude)</lat><lng>\(longtitude)</lng>"
                let data = coordinatesString.dataUsingEncoding(NSUTF8StringEncoding)
                return (method:method, path:"geoData", parameters:nil, body:data)
        }
        
        return (method:method, path:path, parameters:params , body:data)
    }
    
    
    
    func createBodystringFromInfo(parametersInfo:[String:AnyObject]) -> String
    {
        var xmlString = ""
        if let userName = parametersInfo["username"] as? String
        {
            xmlString += "username=\(userName)"
        }
        if let email = parametersInfo["email"] as? String
        {
            if xmlString.characters.isEmpty
            {
                xmlString += "email=\(email)"
            }
            else
            {
                xmlString += "&email=\(email)"
            }
        }
        if let password = parametersInfo["password"] as? String
        {
            xmlString += "&password=\(password)"
        }
        return xmlString
    }
    
    func createGeoBodystringFromInfo(parameters:[String:AnyObject]) -> String
    {
        var xmlString = ""
        return xmlString
    }
}