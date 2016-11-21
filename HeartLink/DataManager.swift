//
//  DataManager.swift
//  HeartLink
//
//  Created by User on 12/09/2016.
//  Copyright (c) 2016 Max. All rights reserved.
//

import Foundation
import Alamofire
import UIKit

let dataURL = "http://ec2-54-163-104-129.compute-1.amazonaws.com:8080/api/patient/submitData"
let loginURL = "http://ec2-54-163-104-129.compute-1.amazonaws.com:8080/login/patient"
let messageURL = "http://ec2-54-163-104-129.compute-1.amazonaws.com:8080/api/messages/mobile"
let sendMessageURL = "http://ec2-54-163-104-129.compute-1.amazonaws.com:8080/api/messages/patient/send"

var response: NSURLResponse?
var error: NSError?
var responseData = NSMutableData()
var jsonResponse: String?
var session = NSURLSession.sharedSession()
var jsonRequest: String!

class DataManager {
    
    //for messaging
    class func getMessagesWithSuccess(success: ((messageData: NSData!) -> Void)) {
        
        var model = Model.sharedInstance
        
        jsonRequest = model.generateMessageJson()
        
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
        println(task.state)
    }
    
    //for patient data
    class func getMessageWithSuccess(success: ((messageData: NSData!) -> Void)) {
        
        var model = Model.sharedInstance
        
        jsonRequest = model.generateJson()
        
        var request = NSMutableURLRequest(URL: NSURL(string: dataURL)!, cachePolicy: NSURLRequestCachePolicy.ReloadIgnoringLocalCacheData, timeoutInterval: 5)
        
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
        println(task.state)
    }
    
    class func getLoginWithSuccess(success: ((loginData: NSData!) -> Void)) {
        
        var model = Model.sharedInstance
        
        jsonRequest = model.generateLoginJson()
        
        var request = NSMutableURLRequest(URL: NSURL(string: loginURL)!, cachePolicy: NSURLRequestCachePolicy.ReloadIgnoringLocalCacheData, timeoutInterval: 5)
        
        request.HTTPBody = jsonRequest.dataUsingEncoding(NSUTF8StringEncoding, allowLossyConversion: true)
        request.HTTPMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.setValue("application/json", forHTTPHeaderField: "Accept")
        
        var task = session.dataTaskWithRequest(request, completionHandler: {loginData, response, error -> Void in
        println("Response: \(response)")
            
            if (response == nil)
            {
                model.loginFailure = true
            }
            
            else
            {
                model.loginFailure = false
            }
            
        var strData = NSString(data: loginData, encoding: NSUTF8StringEncoding)
        println("Body: \(strData)")
        var err: NSError?
        var json = NSJSONSerialization.JSONObjectWithData(loginData, options: .MutableLeaves, error: &err) as? NSDictionary
        
        if let messData = loginData
        {
            success(loginData: messData)
        }
        })
        
        task.resume()
        println(task.state)
    }
    
    class func sendMessageWithSuccess(success: ((responseData: NSData!) -> Void)) {
        
        var model = Model.sharedInstance
        
        jsonRequest = model.generateSendMessageJson()
        
        var request = NSMutableURLRequest(URL: NSURL(string: sendMessageURL)!, cachePolicy: NSURLRequestCachePolicy.ReloadIgnoringLocalCacheData, timeoutInterval: 5)
        
        request.HTTPBody = jsonRequest.dataUsingEncoding(NSUTF8StringEncoding, allowLossyConversion: true)
        request.HTTPMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.setValue("application/json", forHTTPHeaderField: "Accept")
        
        var task = session.dataTaskWithRequest(request, completionHandler: {responseData, response, error -> Void in
            println("Response: \(response)")
            var strData = NSString(data: responseData, encoding: NSUTF8StringEncoding)
            println("Body: \(strData)")
            var err: NSError?
            var json = NSJSONSerialization.JSONObjectWithData(responseData, options: .MutableLeaves, error: &err) as? NSDictionary
            
            if let messData = responseData
            {
                success(responseData: messData)
            }
        })
        
        task.resume()
        println(task.state)
    }
    
    class func setJson(searchJson: String) -> Void
    {
        jsonRequest = searchJson
    }
}