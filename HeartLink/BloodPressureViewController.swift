//
//  BloodPressureViewController.swift
//  HeartLink
//
//  Created by User on 23/08/2016.
//  Copyright (c) 2016 Max. All rights reserved.
//

import UIKit
import HealthKit

class BloodPressureViewController: UIViewController {
    
    @IBOutlet weak var okButton: UIImageView!
    @IBOutlet weak var systolic: UITextField!
    @IBOutlet weak var diastolic: UITextField!
    
    let healthKitStore:HKHealthStore = HKHealthStore()
    
    var model = Model.sharedInstance
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = UIColor(patternImage: UIImage(named: "blue.jpg")!)
        
        var imageView = okButton
        let tapGestureRecognizer = UITapGestureRecognizer(target:self, action:Selector("imageTapped:"))
        imageView.userInteractionEnabled = true
        imageView.addGestureRecognizer(tapGestureRecognizer)
        
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func imageTapped(img: AnyObject)
    {
        model.systolic = (systolic.text as NSString).integerValue
        model.diastolic = (diastolic.text as NSString).integerValue
        navigationController?.popViewControllerAnimated(true)
        saveBloodPressureIntoHealthStore(Double(model.systolic), bloodPressureValueDiastolic: Double(model.diastolic))
    }
    
    private func saveBloodPressureIntoHealthStore(bloodPressureValueSystolic: Double
        ,bloodPressureValueDiastolic: Double) -> Void {
            
            // Save the user's blood pressure into HealthKit.
            let bloodPressureUnit: HKUnit = HKUnit.millimeterOfMercuryUnit()
            
            let bloodPressureSystolicQuantity: HKQuantity = HKQuantity(unit: bloodPressureUnit, doubleValue: bloodPressureValueSystolic)
            
            let bloodPressureDiastolicQuantity: HKQuantity = HKQuantity(unit: bloodPressureUnit, doubleValue: bloodPressureValueDiastolic)
            
            let bloodPressureSystolicType: HKQuantityType = HKQuantityType.quantityTypeForIdentifier(HKQuantityTypeIdentifierBloodPressureSystolic)
            
            let bloodPressureDiastolicType: HKQuantityType = HKQuantityType.quantityTypeForIdentifier(HKQuantityTypeIdentifierBloodPressureDiastolic)
            
            let nowDate: NSDate = NSDate()
            
            let bloodPressureSystolicSample: HKQuantitySample = HKQuantitySample(type: bloodPressureSystolicType
                , quantity: bloodPressureSystolicQuantity, startDate: nowDate, endDate: nowDate)
            
            let bloodPressureDiastolicSample: HKQuantitySample = HKQuantitySample(type: bloodPressureDiastolicType
                , quantity: bloodPressureDiastolicQuantity, startDate: nowDate, endDate: nowDate)
            
            let completion: ((Bool, NSError!) -> Void) = {
                (success, error) -> Void in
                
                if !success {
                    println("An error occured saving the Blood pressure sample \(bloodPressureSystolicSample). error: \(error).")
                    
                    abort()
                }
                
            }// end completion
            
            var objects : NSSet = NSSet(objects: bloodPressureSystolicSample,bloodPressureDiastolicSample)
            
            var bloodPressureType: HKCorrelationType = HKObjectType.correlationTypeForIdentifier(HKCorrelationTypeIdentifierBloodPressure)
            
            var bloodPressureCorrelation : HKCorrelation = HKCorrelation(type: bloodPressureType, startDate: nowDate
                , endDate: nowDate, objects: objects as Set<NSObject>)
            
            self.healthKitStore.saveObject(bloodPressureCorrelation, withCompletion: completion)
            
    }// end saveBloodPressureIntoHealthStore
    
    /*@IBAction func okPressed(sender: UIImageView)
    {
        model.systolic = (systolic.text as NSString).integerValue
        model.diastolic = (diastolic.text as NSString).integerValue
        navigationController?.popViewControllerAnimated(true)
    }*/
    
    //ensures the number pad will close when the user presses anywhere on the screen outside of a text box
    override func touchesBegan(touches: Set<NSObject>, withEvent event: UIEvent)
    {
        systolic.resignFirstResponder()
        diastolic.resignFirstResponder()
    }
}
