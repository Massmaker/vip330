//
//  NetworkApiCaller.swift
//  vip330
//
//  Created by Ivan Yavorin on 1/18/16.
//  Copyright © 2016 Massmaker. All rights reserved.
//

import Foundation
import Alamofire

class NetworkApiCaller{
    let baseAdress = "http://vip330.com"
    
    private var manager: Alamofire.Manager
    
    private lazy var responseParser = NetworkXMLResponseConverter()
    
    init(){
        let serverTrustPolicies: Dictionary<String, ServerTrustPolicy> = ["baseAdress": .DisableEvaluation]
        
        let configuration = NSURLSessionConfiguration.defaultSessionConfiguration()
        configuration.timeoutIntervalForRequest = 90.0
        
        manager = Manager(configuration: configuration, serverTrustPolicyManager: ServerTrustPolicyManager(policies: serverTrustPolicies))
    }
    
    func performLogin(parameters:[String], completion:((response:NetworkingResponse)->()))
    {
        let request = getRequest(ApiCalls.Login(email: parameters.first!, password: parameters.last!))
        manager.request(request).responseData {(responseWithData) in
            if let data = responseWithData.data
            {
                let bgQueue = dispatch_queue_create("LoginResponseParsingQueue", DISPATCH_QUEUE_SERIAL)
                dispatch_async(bgQueue){
                    let parsedResponse = NetworkXMLResponseConverter.parseLoginResponse(data)
                    
                    dispatchAsyncMain(){
                        completion(response: parsedResponse)
                    }
                }
                
            }
        }
    }
    
    func performRegistration(userData:UserRegistrationData, completion:((response:NetworkingResponse)->()))
    {
        let regRequest = getRequest(ApiCalls.Registeration(userName: userData.username, email: userData.email, password: userData.password))
        manager.request(regRequest).responseData { (xmlDataOrErrorResponse) in
            if let data = xmlDataOrErrorResponse.data
            {
                let bgQueue = dispatch_queue_create("RegistrationResponseParsingQueue", DISPATCH_QUEUE_SERIAL)
                dispatch_async(bgQueue){
                    let parsedResponse = NetworkXMLResponseConverter.parseRegistrationResponse(data)
                    dispatchAsyncMain(){
                       completion(response: parsedResponse)
                    }
                }
            }
            if xmlDataOrErrorResponse.result.isSuccess
            {
                
            }
            if xmlDataOrErrorResponse.result.isFailure
            {
                
            }
        }
    }
    
    func performDiscountCardRequest(userId:String, completion:((response:NetworkingResponse)->()))
    {
        
    }
    
    
    private func getRequest(apiCall: ApiCalls) -> NSURLRequest {
        let info = apiCall.requestParameters
        
        let url = NSURL(string: baseAdress)!.URLByAppendingPathComponent(info.path)
        var urlRequest = NSMutableURLRequest(URL: url)
        urlRequest.HTTPMethod = info.method.rawValue
        
        if let requestParams = info.parameters
        {
            let urlRequestResult = Alamofire.ParameterEncoding.URL.encode(urlRequest, parameters: requestParams)
            urlRequest = urlRequestResult.0
            if let headerError = urlRequestResult.1
            {
                logError(headerError)
            }
        }
        
        if let bodyData = info.body
        {
            urlRequest.HTTPBody = bodyData
        }
        
        logRequest(urlRequest)
        
        return urlRequest
    }
    
    private func logRequest(request: NSURLRequest) {
        NSLog("Request URL: \(request.URL!)")
        NSLog("Request METHOD: \(request.HTTPMethod!)")
        
        if let _ = request.HTTPBody {
            let body = String(data: request.HTTPBody!, encoding: NSUTF8StringEncoding)
            NSLog("Request BODY: \(body!)")
        }
    }
    
    private func logResponse(response: NSHTTPURLResponse) {
        NSLog("Response URL: \(response.URL!)")
        NSLog("Response StatusCode: \(response.statusCode)")
    }
    
    private func logError(error:NSError)
    {
        NSLog("Error: \n")
        NSLog("domain: %@", error.domain)
        NSLog("code: %ld", error.code)
        NSLog("UserInfo: %@",error.userInfo)
    }
}