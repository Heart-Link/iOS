//
//  HealthKitEntity.swift
//  HeartLink
//
//  Created by User on 11/10/2016.
//  Copyright (c) 2016 Max. All rights reserved.
//

import Foundation
import HealthKit

class HealthKitEntity
{
    var model = Model.sharedInstance
    
    let healthKitStore:HKHealthStore = HKHealthStore()
    let heartRateType: HKSampleType = HKQuantityType.quantityTypeForIdentifier(HKQuantityTypeIdentifierHeartRate)
    var HRQuery: HKSampleQuery?
    
    let stepsCount = HKQuantityType.quantityTypeForIdentifier(HKQuantityTypeIdentifierStepCount)
    
    func authorizeHealthKit(completion: ((success: Bool, error: NSError!) -> Void)!)
    {
        //reads from healthkit
        let healthKitTypesToRead = NSSet(objects: HKObjectType.quantityTypeForIdentifier(HKQuantityTypeIdentifierHeartRate),
            HKObjectType.quantityTypeForIdentifier(HKQuantityTypeIdentifierStepCount))

        //pushes to health app
        let healthKitTypesToWrite = NSSet(objects: HKObjectType.quantityTypeForIdentifier(HKQuantityTypeIdentifierBloodPressureDiastolic),
            HKObjectType.quantityTypeForIdentifier(HKQuantityTypeIdentifierBloodPressureSystolic),
            HKObjectType.quantityTypeForIdentifier(HKQuantityTypeIdentifierBodyMass))
        
        //error if health not available, like on an ipad
        if !HKHealthStore.isHealthDataAvailable()
        {
            let error = NSError(domain: "com.raywenderlich.tutorials.healthkit", code: 2, userInfo: [NSLocalizedDescriptionKey:"HealthKit is not available in this Device"])
            if( completion != nil )
            {
                completion(success:false, error:error)
            }
            return;
        }
        
        //request HealthKit authorization
            healthKitStore.requestAuthorizationToShareTypes(healthKitTypesToWrite as Set<NSObject>, readTypes: healthKitTypesToRead as Set<NSObject>) { (success, error) -> Void in
            
            if( completion != nil )
            {
                completion(success:success,error:error)
            }
        }
        
        /*let stepsQuery = HKSampleQuery(sampleType: HKQuantityType.quantityTypeForIdentifier(HKQuantityTypeIdentifierStepCount), predicate: nil, limit: 100, sortDescriptors: nil)
            { (query, results, error) in
                if let results = results as? [HKQuantitySample] {
                    let steps = results
                    println(steps)
                    //self.tableView.reloadData()
                }
                //self.activityIndicator.stopAnimating()
        }
        
        let HRQuery = HKSampleQuery(sampleType: HKQuantityType.quantityTypeForIdentifier(HKQuantityTypeIdentifierHeartRate), predicate: nil, limit: 100, sortDescriptors: nil)
            { (query, results, error) in
                if let results = results as? [HKQuantitySample] {
                    let rate = results
                    println(rate)
                    //self.tableView.reloadData()
                }
                //self.activityIndicator.stopAnimating()
        }
        
        healthKitStore.executeQuery(stepsQuery)
        healthKitStore.executeQuery(HRQuery)*/
        
        readHealthData()
    }
    
    func readHealthData()
    {
        var error: NSError?
        var heartRate: Int?
        
        let sortDescriptors = [NSSortDescriptor(key: HKSampleSortIdentifierEndDate, ascending: false)]
        
        let heartRateType: HKQuantityType = HKQuantityType.quantityTypeForIdentifier(HKQuantityTypeIdentifierHeartRate)!
        let calendar = NSCalendar.currentCalendar()
        let now = NSDate()
        let year = calendar.components(NSCalendarUnit.YearCalendarUnit, fromDate: now)
        let month = calendar.components(NSCalendarUnit.MonthCalendarUnit, fromDate: now)
        let day = calendar.components(NSCalendarUnit.DayCalendarUnit, fromDate: now)
        let dateComponents = NSDateComponents()
        dateComponents.year = year.year
        dateComponents.month = month.month
        dateComponents.day = day.day
        
        let startDate: NSDate = calendar.dateFromComponents(dateComponents)!
        let endDate: NSDate? = calendar.dateByAddingUnit(NSCalendarUnit.DayCalendarUnit, value: 1, toDate: startDate, options: nil)
        let predicate = HKQuery.predicateForSamplesWithStartDate(startDate, endDate: endDate, options: .None)
        
        HRQuery = HKSampleQuery(sampleType: HKQuantityType.quantityTypeForIdentifier(HKQuantityTypeIdentifierHeartRate), predicate: predicate, limit: 25, sortDescriptors: nil)
            { (query, results, error) in
                if let results = results as? [HKQuantitySample] {
                    if results.count > 0
                    {
                        self.model.heartRate = results[0].quantity
                        println(self.model.heartRate)
                    }
                }
        }
        
            healthKitStore.executeQuery(HRQuery)
        
        let stepQuery = HKSampleQuery(sampleType: HKQuantityType.quantityTypeForIdentifier(HKQuantityTypeIdentifierStepCount), predicate: predicate, limit: 25, sortDescriptors: nil)
            { (query, results, error) in
                if let results = results as? [HKQuantitySample] {
                    if results.count > 0
                    {
                        self.model.steps = results[0].quantity
                        println(self.model.steps)
                    }
                }
        }
        
        healthKitStore.executeQuery(stepQuery)
        }
    }
