//
//  Model.swift
//  HeartLink
//
//  Created by User on 7/08/2016.
//  Copyright (c) 2016 Max. All rights reserved.
//

import Foundation

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
    
    var messageJson: String!
    
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
    
    let format = ["name": 1]
    
    let jsonObject: [String: AnyObject] = [
        "systolic": 1,
        "diastolic": 1,
        "weight": 1,
        "drinks": 1,
        "stress": 1,
        "smoker": 1,
        "cigarettes": 1]
    
    //apparently my scope is off because it cannot find the variables declared at the top of the model
    // :(
    func generateJson() -> String
    {
        var jsonString: String
    
        /*jsonString = "{ \"systolic\":" + String(self.systolic)
        jsonString += ", \"diastolic\":" + String(self.diastolic)
        jsonString += ", \"weight\":" + String(self.weight)
        jsonString += ", \"drinks\":" + String(self.drinks)
        jsonString += ", \"stress\":" + String(self.stress)
        jsonString += ", \"smoker\":" + String(self.smoker)
        jsonString += ",\"cigarettes\":" + String(self.cigarettes) + "}"
        */
        
        jsonString = "recommendedVitals:{bpHigh:{type:" + String(self.systolic) + "}, "
        jsonString += "bpLow:{type:" + String(self.diastolic) + "}, "
        jsonString += "weight:{type:" + String(self.weight) + "}, "
        //jsonString += "exerciseTime:{type:" + exerciseTime + "}, "
        jsonString += "alcoholIntake:{type:" + String(self.drinks) + "}, "
        //jsonString += "steps:{type:" + steps + "}, "
        //jsonString += "averageHR:{type:" + bpm + "}, "
        jsonString += "stressLevel:{type:" + String(self.stress) + "}}"
        return jsonString
    }
    
    private init()
    {
        
    }
}