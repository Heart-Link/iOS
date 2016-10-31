//
//  WeightViewController.swift
//  HeartLink
//
//  Created by User on 23/08/2016.
//  Copyright (c) 2016 Max. All rights reserved.
//

import UIKit

class WeightViewController: UIViewController {
    
    @IBOutlet weak var okButton: UIImageView!
    @IBOutlet weak var weight: UITextField!
    @IBOutlet weak var button: UIButton!
    
    var model = Model.sharedInstance
    let healthKitEntity: HealthKitEntity = HealthKitEntity()
    
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
        var noLegs: Int = 0
        
        DataManager.setJson(model.generateJson())
        DataManager.getMessageWithSuccess {(resultsData) -> Void in
        let json = JSON(data: resultsData)
        }
        
        println(model.generateJson())
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
