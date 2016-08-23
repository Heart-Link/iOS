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
    let welcomeOptions = ["Enter Health Data", "See Gamification", "See Health History", "Contact Doctor"]
    let entryOptions = ["Blood Pressure", "Weight", "Alcohol Intake", "Diet", "Stress", "Smoking"]
    let name = "Helga"
    
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
    
    private init()
    {
        
    }
}