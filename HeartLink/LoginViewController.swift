//
//  LoginViewController.swift
//  HeartLink
//
//  Created by User on 15/10/2016.
//  Copyright (c) 2016 Max. All rights reserved.
//

import UIKit
import Foundation
import CoreData

class LoginViewController: UIViewController {
    
    @IBOutlet weak var heartLinkLabel: UILabel!
    @IBOutlet weak var heartLinkImage: UIImageView!
    @IBOutlet weak var usernameField: UITextField!
    @IBOutlet weak var passwordField: UITextField!
    @IBOutlet weak var loginButton: UIButton!
    @IBOutlet weak var spinningWheel: UIActivityIndicatorView!
    @IBOutlet weak var invalidLabel: UILabel!
    
    var model = Model.sharedInstance
    
    let healthKitEntity: HealthKitEntity = HealthKitEntity()
    
    let managedObjectContext =
    (UIApplication.sharedApplication().delegate
        as! AppDelegate).managedObjectContext
    
    var networkID: String!
    var convoID: String!
    var tokenID: String!
    var emrID: String!
    var gameification: String!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.heartLinkLabel.center = self.view.center
        
        UIView.animateWithDuration(1.0, delay: 0.5, options: UIViewAnimationOptions.CurveEaseInOut, animations: {
            var labelFrame = self.heartLinkLabel.frame
            labelFrame.origin.y -= (self.view.frame.size.height / 5.15)
            self.heartLinkLabel.frame = labelFrame
            
            var imageFrame = self.heartLinkImage.frame
            imageFrame.origin.y -= (self.view.frame.size.height / 5.15)
            self.heartLinkImage.frame = imageFrame
            }, completion: {finished in
            self.usernameField.hidden = false
            self.passwordField.hidden = false
            self.loginButton.hidden = false})

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func authorizeHealthKit()
    {
        healthKitEntity.authorizeHealthKit { (authorized,  error) -> Void in
            
            if (authorized && self.model.loginFailure == false)
            {
                self.performSegueWithIdentifier("loginSuccess", sender: self.loginButton)
                println("HealthKit authorization received.")
            }
                
            else
            {
                println("HealthKit authorization denied!")
                
                if error != nil
                {
                    println("\(error)")
                }
            }
        }
    }
    
    override func prefersStatusBarHidden() -> Bool {
        return navigationController?.navigationBarHidden == true
    }
    
    override func preferredStatusBarUpdateAnimation() -> UIStatusBarAnimation {
        return UIStatusBarAnimation.Slide
    }
    
    //ensures the keyboard will close when the user presses anywhere on the screen outside of a text box
    override func touchesBegan(touches: Set<NSObject>, withEvent event: UIEvent)
    {
        usernameField.resignFirstResponder()
        passwordField.resignFirstResponder()
    }
    
    @IBAction func loginPressed(sender: UIButton)
    {
        self.spinningWheel.hidden = false
        model.username = usernameField.text
        model.password = passwordField.text
        model.deviceId = UIDevice.currentDevice().identifierForVendor!.UUIDString
        
        let entityDescription =
        NSEntityDescription.entityForName("LoginDeets",
            inManagedObjectContext: managedObjectContext!)
        
        let loginData = LoginDeets(entity: entityDescription!,
            insertIntoManagedObjectContext: managedObjectContext)
        
        DataManager.setJson(model.generateLoginJson())
        DataManager.getLoginWithSuccess {(resultsData) -> Void in
            let json = JSON(data: resultsData)
            
            if let networkID = json["networkid"].string
            {
                self.model.networkID = networkID
                loginData.networkID = networkID
                println("patientID stored successfully in core data")
            }
            
            if let convoID = json["convoid"].string
            {
                self.model.convoID = convoID
                loginData.convoID = convoID
                println("convoID stored successfully in core data")
            }
            
            if let gameification = json["gameification"].string
            {
                self.model.gameification = gameification
                loginData.gameification = gameification
                println("gameification stored successfully in core data")
            }
            
            if let emrID = json["emrid"].string
            {
                self.model.emrID = emrID
                loginData.emrID = emrID
                println("emrID stored successfully in core data")
            }
            
            if let tokenID = json["token"].string
            {
                self.model.tokenID = tokenID
                loginData.tokenID = tokenID
                println("tokenID stored successfully in core data")
            }
        }
        
        
        
        var seconds = 2.0
        var delay = seconds * Double(NSEC_PER_SEC)
        var dispatchTime = dispatch_time(DISPATCH_TIME_NOW, Int64(delay))
        
        dispatch_after(dispatchTime, dispatch_get_main_queue(),
            {
        if (self.model.loginFailure == true)
        {
            self.spinningWheel.hidden = true
            self.invalidLabel.hidden = false
        }
        
        else
        {
            var error: NSError?
        
            self.managedObjectContext?.save(&error)
        
            self.authorizeHealthKit()
        }
                })
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
