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
    
    private let baseAdress = "http://vip330.com"
    
    private var manager: Alamofire.Manager
    
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
    
    func loadGeoData(completion:((response:NetworkingResponse)->()))
    {
        let geodataRequest = getRequest(ApiCalls.RequestAllGeodata)
        
        manager.request(geodataRequest).responseData { (aResponse) -> Void in
            if aResponse.result.isFailure{
                
            }
            else if aResponse.result.isSuccess{
                guard let geoData = aResponse.data else
                {
                    assert(false, " No Response data .")
                    return
                }
                
                
                
                let bgParsingOperation = NSBlockOperation(){ _ in
                    NSLog("BG geodata parsing operation did START parsing xml")
                    let geodataResult = NetworkXMLResponseConverter.parseGeodataResponse(geoData)
                    switch geodataResult{
                    case .Success(let response):
                        if let geoDatas = response as? [DiscountGeodata]
                        {
                            completion(response: NetworkingResponse.Success(response: geoDatas))
                        }
                        else
                        {
                            completion(response: NetworkingResponse.Failure(error: NetworkingError.Unknown(message: "Could not parse recieved xml")))
                        }
                        case .Failure( _ ):
                            completion(response: geodataResult)
                    }
                }
                
                bgParsingOperation.qualityOfService = .Utility
                bgParsingOperation.completionBlock = {_ in NSLog("BG geodata parsing operation did FINISH parsing xml")}
                
                let queue = NSOperationQueue()
                queue.maxConcurrentOperationCount = 1
                queue.suspended = false
                queue.addOperation(bgParsingOperation)

            }
        }
    }
    
    func performDiscountCardRequest(userId:String, completion:((response:NetworkingResponse)->()))
    {
        let discountCardRequest = getRequest(ApiCalls.RequestDiscountCardImage(userId: userId))
//        manager.request(discountCardRequest).responseData { (responseFromServer) -> Void in
//            
////            if responseFromServer.result.isSuccess
////            {
//                guard let imageData = responseFromServer.data else
//                {
//                    assert(false, " No Response data .")
//                    return
//                }
//                
//                guard let image = UIImage(data: imageData) else
//                {
//                    completion(response: NetworkingResponse.Failure(error: NetworkingError.Unknown(message: "Colud not display image")))
//                    return
//                }
//                
//                completion(response: .Success(response:image))
////            }
//        }
        
        
        manager.request(discountCardRequest).response { (req, resp, responseData, responseError) -> Void in
            //print("response: \(resp)")
            guard let imageData = responseData else
            {
                assert(false, " No Response data .")
                return
            }
            
            if let anError = responseError
            {
                completion(response: NetworkingResponse.Failure(error: NetworkingError.Failure(code: anError.code, message: anError.localizedDescription)) )
                return
            }
            
            guard let image = UIImage(data: imageData) else
            {
                completion(response: NetworkingResponse.Failure(error: NetworkingError.Unknown(message: "Colud not display image")))
                return
            }
            
            completion(response: .Success(response:image))
        }
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