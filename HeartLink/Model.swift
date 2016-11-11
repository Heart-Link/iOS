//
//  Model.swift
//  HeartLink
//
//  Created by User on 7/08/2016.
//  Copyright (c) 2016 Max. All rights reserved.
//

import Foundation
import HealthKit
import CoreData

public class Model
{
    //these are the options for the first screen
    let welcomeOptions = ["Enter Health Data", "See Gamification", "See Health History", "Contact Doctor", "Logout"]
    let entryOptions = ["Blood Pressure", "Weight", "Alcohol Intake", "Diet", "Stress", "Smoking"]
    let msgSenders = ["Dr. Smith"]
    let msgSubjects = ["Check up"]
    let name = "Helga"
    
    var systolic: Int!
    var diastolic: Int!
    var weight: Int!
    var drinks: Int!
    var stress: Int!
    var smoker: Int!
    var cigarettes: Int!
    var exerciseTime: Int!
    var heartRate: HKQuantity!
    var steps: HKQuantity!
    var dates = [String]()
    var patientId: String = "7779"
    
    var messageJson: String!
    var username: String!
    var password: String!
    var deviceId: String!
    var date: String
    
    let dateC = NSDateComponents()
    
    private struct Static
    {
        static var instance: Model?
    }
    
    class var sharedInstance: Model
    {
        if !(Static.instance != nil)
        {
            Static.instance = Model()
        }
        
        return Static.instance!
    }
    
    func generateJson() -> String
    {
        /*var jsonString: String
        
        let jsonObject: [String: AnyObject] = [
            "bpHigh": String(self.systolic),
            "bpLow": String(self.diastolic),
            "weight": String(self.weight),
            "exerciseTime": String(self.exerciseTime),
            "alcoholIntake": String(self.drinks),
            "steps": String(stringInterpolationSegment: self.steps),
            "averageHR": String(stringInterpolationSegment: self.heartRate),
            "stressLevel": String(self.stress),
            "smoke": String(self.cigarettes),
            "patientID": patientId
        ]*/
        
        let jsonObject: String = "{\"bpHigh\": \"" + String(systolic) + "\", \"bpLow\": \"" + String(diastolic) + "\", \"weight\": \"" + String(weight) + "\", \"exerciseTime\": \"" + String(exerciseTime) + "\", \"alcoholIntake\": \"" + String(drinks) + "\", \"steps\": \"" + String(stringInterpolationSegment: steps) + "\", \"averageHR\": \"" + String(stringInterpolationSegment: heartRate) + "\", \"stressLevel\": \"" + String(stress) + "\", \"smoke\": \"" + String(cigarettes) + "\", \"patientID\": \"" + String(patientId) + "\"}"
        
        return jsonObject
    }
    
    /*func generateLoginJson() -> [String: AnyObject]
    {
        let jsonObject: [String: AnyObject] = ["email": username, "password": password, "deviceID": deviceId]
        
        return jsonObject
    }*/
    
    func generateLoginJson() -> String
    {
        let jsonObject: String = "{\"email\": \"" + username + "\", \"password\": \"" + password + "\", \"deviceID\": \"" + deviceId + "\"}"
        
        return jsonObject
    }
    
    class func getDate() -> String
    {
        let todayDate = NSDate()
        let calendar = NSCalendar.currentCalendar()
        let components = calendar.components(.CalendarUnitDay | .CalendarUnitMonth | .CalendarUnitYear, fromDate: todayDate)
        
        let year =  components.year
        let month = components.month
        let day = components.day
        
        //let date = " " + month + " "
        //date += "/" + day
        //date += "/" + year
        println("\(month)/\(day)/\(year)")
        return "\(month)/\(day)/\(year)"
    }
    
    private init()
    {
        self.systolic = -1
        self.diastolic = -1
        self.weight = -1
        self.drinks = 7
        self.stress = -1
        self.smoker = -1
        self.cigarettes = -1
        self.exerciseTime = -1
        //self.date = " " + dateC.weekday + " "
        //self.date += ", " + String(dateC.day) + " "
        //self.date += String(dateC.month) + " " + String(dateC.year)
        self.date = Model.getDate()
    }
}