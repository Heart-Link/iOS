//
//  StressViewController.swift
//  HeartLink
//
//  Created by User on 23/08/2016.
//  Copyright (c) 2016 Max. All rights reserved.
//

import UIKit

class StressViewController: UIViewController {
    
    @IBOutlet weak var okButton: UIButton!
    @IBOutlet weak var stressLevel: UITextField!
    @IBOutlet weak var stressQuestion: UILabel!
    @IBOutlet weak var oneToTen: UILabel!
    
    var model = Model.sharedInstance
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        stressQuestion.lineBreakMode = .ByWordWrapping
        stressQuestion.numberOfLines = 0
        oneToTen.lineBreakMode = .ByWordWrapping
        oneToTen.numberOfLines = 0
        
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func okPressed(sender: UIButton)
    {
        model.stress = (stressLevel.text as NSString).integerValue
        navigationController?.popViewControllerAnimated(true)
    }
    
    //ensures the number pad will close when the user presses anywhere on the screen outside of a text box
    override func touchesBegan(touches: Set<NSObject>, withEvent event: UIEvent)
    {
        stressLevel.resignFirstResponder()
    }
}
