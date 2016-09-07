//
//  SmokeViewController.swift
//  HeartLink
//
//  Created by User on 23/08/2016.
//  Copyright (c) 2016 Max. All rights reserved.
//

import UIKit

class SmokeViewController: UIViewController {
    
    @IBOutlet weak var okButton: UIButton!
    @IBOutlet weak var yesButton: UISegmentedControl!
    @IBOutlet weak var cigarettes: UITextField!
    @IBOutlet weak var smokeQuestion: UILabel!
    
    var model = Model.sharedInstance
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        smokeQuestion.lineBreakMode = .ByWordWrapping
        smokeQuestion.numberOfLines = 0
        
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func okPressed(sender: UIButton)
    {
        model.smoker = yesButton.selectedSegmentIndex
        model.cigarettes = (cigarettes.text as NSString).integerValue
        navigationController?.popViewControllerAnimated(true)
    }
    
    //ensures the number pad will close when the user presses anywhere on the screen outside of a text box
    override func touchesBegan(touches: Set<NSObject>, withEvent event: UIEvent)
    {
        cigarettes.resignFirstResponder()
    }
}
