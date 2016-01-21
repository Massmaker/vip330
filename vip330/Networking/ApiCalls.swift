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
    case RequestDiscountCardImage(userId:String)
    
    var requestParameters : (method: Alamofire.Method, path: String, parameters:[String:AnyObject]?, body:NSData?) {
        
        let method = Alamofire.Method.POST
        var data:NSData?
        var path:String = ""
        var params:[String:AnyObject]?
        
        switch self
        {
            case .Registeration(let userName, let email, let password) :
                let registerString = "option=com_users&task=registration.androidregister&aform[name]=\(userName)&aform[email1]=\(email)&aform[email2]=\(email)&aform[password1]=\(password)&aform[password2]=\(password)"
                data = registerString.dataUsingEncoding(NSUTF8StringEncoding)
                path = "user-register"
                params = ["task":"registration.androidregister"]
            
            case .Login(let email, let password):
                path = "user-loginFromAndroid"
                let bodyString = "option=com_users&task=user.loginFromAndroid&username=\(email)&password=\(password)"
                data = bodyString.dataUsingEncoding(NSUTF8StringEncoding)
                return (method:method, path:"com_users/loginFromAndroid", parameters:nil, body:data)
            
            case .RequestGeodata(let userId, let lattitude, let longtitude):
                let coordinatesString = "<userid>\(userId)<userid><lat>\(lattitude)</lat><lng>\(longtitude)</lng>"
                let data = coordinatesString.dataUsingEncoding(NSUTF8StringEncoding)
                return (method:method, path:"geoData", parameters:nil, body:data)
            case .RequestDiscountCardImage(let userId):
                print("\n - Todo: implement \"RequestDiscountCardImage\" case\n")
                print("userId  =  \(userId)")
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
    
    
    // to send geo data in request
    func createGeoBodystringFromInfo(parameters:[String:AnyObject]) -> String
    {
        var xmlString = ""
        return xmlString
    }
}