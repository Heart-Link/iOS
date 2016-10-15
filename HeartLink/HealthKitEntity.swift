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
    let healthKitStore:HKHealthStore = HKHealthStore()
    
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
    }
    
    /*func readProfile() -> (heartRate: Int?, steps: Int?)
    {
        var error: NSError?
        var heartRate: Int?
        
        //heartRate = healthKitStore.(&error)
        
        if error != nil
        {
            println("Error reading Birthday: \(error)")
        }
    
        var biologicalSex:HKBiologicalSexObject? = healthKitStore.biologicalSexWithError(&error)
        
        if error != nil
        {
            println("Error reading Biological Sex: \(error)")
        }
    
        var bloodType:HKBloodTypeObject? = healthKitStore.bloodTypeWithError(&error)
        
        if error != nil
        {
            println("Error reading Blood Type: \(error)")
        }
        
        return (age, biologicalSex, bloodType)
    }*/
}