//
//  DataManager.swift
//  HeartLink
//
//  Created by User on 12/09/2016.
//  Copyright (c) 2016 Max. All rights reserved.
//

import Foundation
import Alamofire

let messageURL = "http://ec2-54-163-104-129.compute-1.amazonaws.com:8080/patient/submitData"
let loginURL = "http://ec2-54-163-104-129.compute-1.amazonaws.com:8080/login/patient"

var response: NSURLResponse?
var error: NSError?
var responseData = NSMutableData()
var jsonResponse: String?
var session = NSURLSession.sharedSession()
var jsonRequest: AnyObject!

class DataManager {
    
    class func getMessageWithSuccess(success: ((messageData: NSData!) -> Void)) {
        
        var model = Model.sharedInstance
        /*jsonRequest = model.generateJson()
        
        var request = NSMutableURLRequest(URL: NSURL(string: messageURL)!, cachePolicy: NSURLRequestCachePolicy.ReloadIgnoringLocalCacheData, timeoutInterval: 5)
        
        request.HTTPBody = jsonRequest.dataUsingEncoding(NSUTF8StringEncoding, allowLossyConversion: true)
        request.HTTPMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.setValue("application/json", forHTTPHeaderField: "Accept")
        
        var task = session.dataTaskWithRequest(request, completionHandler: {messageData, response, error -> Void in
            println("Response: \(response)")
            var strData = NSString(data: messageData, encoding: NSUTF8StringEncoding)
            println("Body: \(strData)")
            jsonResponse = strData as? String
            var err: NSError?
            var json = NSJSONSerialization.JSONObjectWithData(messageData, options: .MutableLeaves, error: &err) as? NSDictionary
            
            if let messData = messageData
            {
                success(messageData: messData)
            }
        })
        
        task.resume()
        println(task.state)*/
        
        Alamofire.request(.POST, messageURL, parameters: model.generateJson(), encoding: .URL).validate().response{request, response, data, error in let dataString = NSString(data: data! as! NSData, encoding: NSUTF8StringEncoding)
            println(dataString)}
    }
    
    class func getLoginWithSuccess(success: ((loginData: NSData!) -> Void)) {
        
        var model = Model.sharedInstance
        
        Alamofire.request(.POST, loginURL, parameters: model.generateLoginJson(), encoding: .URL).validate().response{request, response, data, error in let dataString = NSString(data: data! as! NSData, encoding: NSUTF8StringEncoding)
            println(dataString)}
    }
    
    class func setJson(searchJson: AnyObject) -> Void
    {
        jsonRequest = searchJson
    }
}