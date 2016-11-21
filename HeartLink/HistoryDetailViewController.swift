//
//  HistoryDetailViewController.swift
//  HeartLink
//
//  Created by User on 31/10/2016.
//  Copyright (c) 2016 Max. All rights reserved.
//

import UIKit

class HistoryDetailViewController: UIViewController {
    
    var selection: Int!
    var passedDate = [String]()
    var passedAlcohol = [String]()
    var passedDiastolic = [String]()
    var passedHeartRate = [String]()
    var passedSmoke = [String]()
    var passedSteps = [String]()
    var passedStress = [String]()
    var passedWeight = [String]()
    var passedSystolic = [String]()
    
    @IBOutlet weak var diastolic: UILabel!
    @IBOutlet weak var systolic: UILabel!
    @IBOutlet weak var weight: UILabel!
    @IBOutlet weak var drinks: UILabel!
    @IBOutlet weak var stress: UILabel!
    @IBOutlet weak var smokes: UILabel!
    @IBOutlet weak var heartRate: UILabel!
    @IBOutlet weak var steps: UILabel!

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        println(selection)
        diastolic.text = passedDiastolic[selection]
        systolic.text = passedSystolic[selection]
        weight.text = passedWeight[selection]
        drinks.text = passedAlcohol[selection]
        stress.text = passedStress[selection]
        smokes.text = passedSmoke[selection]
        heartRate.text = passedHeartRate[selection]
        steps.text = passedSteps[selection]
        
        self.view.backgroundColor = UIColor(patternImage: UIImage(named: "blue.jpg")!)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
