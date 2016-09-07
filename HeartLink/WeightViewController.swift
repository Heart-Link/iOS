//
//  WeightViewController.swift
//  HeartLink
//
//  Created by User on 23/08/2016.
//  Copyright (c) 2016 Max. All rights reserved.
//

import UIKit

class WeightViewController: UIViewController {
    
    @IBOutlet weak var okButton: UIButton!
    @IBOutlet weak var weight: UITextField!
    
    var model = Model.sharedInstance
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func okPressed(sender: UIButton)
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
