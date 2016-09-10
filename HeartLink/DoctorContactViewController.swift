//
//  DataEntryViewController.swift
//  HeartLink
//
//  Created by User on 21/08/2016.
//  Copyright (c) 2016 Max. All rights reserved.
//

import UIKit

class DoctorContactViewController: UIViewController {
    
    @IBOutlet weak var warning: UILabel!
    
    var model = Model.sharedInstance
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        warning.lineBreakMode = .ByWordWrapping
        warning.numberOfLines = 0
        
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}