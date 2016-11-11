//
//  WeightViewController.swift
//  HeartLink
//
//  Created by User on 23/08/2016.
//  Copyright (c) 2016 Max. All rights reserved.
//

import UIKit
import CoreData

class WeightViewController: UIViewController {
    
    @IBOutlet weak var okButton: UIImageView!
    @IBOutlet weak var weight: UITextField!
    @IBOutlet weak var button: UIButton!
    
    var model = Model.sharedInstance
    let healthKitEntity: HealthKitEntity = HealthKitEntity()
    
    let managedObjectContext =
    (UIApplication.sharedApplication().delegate
        as! AppDelegate).managedObjectContext
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view, typically from a nib.
        
        self.view.backgroundColor = UIColor(patternImage: UIImage(named: "blue.jpg")!)
        
        var imageView = okButton
        let tapGestureRecognizer = UITapGestureRecognizer(target:self, action:Selector("imageTapped:"))
        imageView.userInteractionEnabled = true
        imageView.addGestureRecognizer(tapGestureRecognizer)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func buttPressed(sender: UIButton)
    {
        healthKitEntity.readHealthData()
        var i: Int = 0
        
        DataManager.setJson(model.generateJson())
        DataManager.getMessageWithSuccess {(resultsData) -> Void in
        let json = JSON(data: resultsData)
        }
        
        println(model.generateJson())
        
        let entityDescription =
        NSEntityDescription.entityForName("Patient",
            inManagedObjectContext: managedObjectContext!)
        
        //let patientData = Patient(entity: entityDescription!,
            //insertIntoManagedObjectContext: managedObjectContext)
        
        let patientData = NSEntityDescription.insertNewObjectForEntityForName("Patient", inManagedObjectContext: self.managedObjectContext!) as! Patient
        
        model.drinks = 33
        println(String(model.drinks))
        patientData.setValue(String(model.drinks), forKey: "alcohol")
        patientData.diastolic = String(model.diastolic)
        patientData.date = model.date
        println(patientData.date)
        patientData.heartRate = String(stringInterpolationSegment: model.heartRate)
        patientData.smoke = String(model.cigarettes)
        patientData.steps = String(stringInterpolationSegment: model.steps)
        patientData.stress = String(model.stress)
        patientData.weight = String(model.weight)
        patientData.systolic = String(model.systolic)
        
        var error: NSError?
        managedObjectContext?.save(&error)
        
        if let err = error {
            //status.text = err.localizedFailureReason
        } else {
            //name.text = ""
            //address.text = ""
            //phone.text = ""
        }
        
        /*let request = NSFetchRequest()
        request.entity = entityDescription
        
        var objects = managedObjectContext?.executeFetchRequest(request,
            error: &error)
        
        if let results = objects {
            if results.count > 0 {
                let match = results[0] as! NSManagedObject
                
                alcohol = match.valueForKey("alcohol") as! String
                diastolic = match.valueForKey("diastolic") as! String
                date = match.valueForKey("date") as! String
                heartRate = match.valueForKey("heartRate") as! String
                smoke = match.valueForKey("smoke") as! String
                steps = match.valueForKey("steps") as! String
                stress = match.valueForKey("stress") as! String
                weight = match.valueForKey("weight") as! String
                systolic = match.valueForKey("systolic") as! String
            }
            
            //numRows = results.count
        }*/
    }
    
    func imageTapped(img: AnyObject)
    {
        model.weight = (weight.text as NSString).integerValue
        navigationController?.popViewControllerAnimated(true)
    }
    
    
    //ensures the number pad will close when the user presses anywhere on the screen outside of a text box
    override func touchesBegan(touches: Set<NSObject>, withEvent event: UIEvent)
    {
        weight.resignFirstResponder()
    }
}
