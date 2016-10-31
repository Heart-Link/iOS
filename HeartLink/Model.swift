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
    
    func generateJson() -> [String: AnyObject]
    {
        var jsonString: String
        
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
        ]
        
        return jsonObject
    }
    
    func generateLoginJson() -> [String: AnyObject]
    {
        let jsonObject: [String: AnyObject] = ["username": username, "password": password, "deviceID": deviceId]
        
        return jsonObject
    }
    
    private init()
    {
        self.systolic = -1
        self.diastolic = -1
        self.weight = -1
        self.drinks = -1
        self.stress = -1
        self.smoker = -1
        self.cigarettes = -1
        self.exerciseTime = -1
    }
}