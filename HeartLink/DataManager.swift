//
//  DataManager.swift
//  HeartLink
//
//  Created by User on 12/09/2016.
//  Copyright (c) 2016 Max. All rights reserved.
//

import Foundation
import Alamofire

let messageURL = "http://ec2-54-163-104-129.compute-1.amazonaws.com:8080/api/messages/patient/send"

var response: NSURLResponse?
var error: NSError?
var responseData = NSMutableData()
var jsonResponse: String?
var session = NSURLSession.sharedSession()
var jsonRequest: String!

class DataManager {
    
    /*Alamofire.upload(
    .POST,
    "http://api.imagga.com/v1/content",
    headers: ["Authorization" : "Basic xxx"],
    multipartFormData: { multipartFormData in
    multipartFormData.appendBodyPart(data: imageData, name: "imagefile",
    fileName: "image.jpg", mimeType: "image/jpeg")
    },
    encodingCompletion: { encodingResult in
    }
    )*/
    
    class func getMessageWithSuccess(success: ((messageData: NSData!) -> Void)) {
        
        var model = Model.sharedInstance
        jsonRequest = model.messageJson
        
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
    
    /*class func getAirportCodeFromFileWithSuccess(success: ((data: NSData) -> Void)) {
        //1
        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), {
            //2
            let filePath = NSBundle.mainBundle().pathForResource("AirportCodes",ofType:"json")
            
            var readError:NSError?
            if let data = NSData(contentsOfFile:filePath!,
                options: NSDataReadingOptions.DataReadingUncached,
                error:&readError) {
                    success(data: data)
            }
        })
    }*/
    
    class func setJson(searchJson: String) -> Void
    {
        jsonRequest = searchJson
    }
}