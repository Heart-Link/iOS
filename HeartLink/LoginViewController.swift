//
//  LoginViewController.swift
//  HeartLink
//
//  Created by User on 15/10/2016.
//  Copyright (c) 2016 Max. All rights reserved.
//

import UIKit

class LoginViewController: UIViewController {
    
    @IBOutlet weak var heartLinkLabel: UILabel!
    @IBOutlet weak var heartLinkImage: UIImageView!
    @IBOutlet weak var usernameField: UITextField!
    @IBOutlet weak var passwordField: UITextField!
    @IBOutlet weak var loginButton: UIButton!
    @IBOutlet weak var spinningWheel: UIActivityIndicatorView!
    
    let healthKitEntity: HealthKitEntity = HealthKitEntity()

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
            
            if authorized
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
    
    //ensures the keyboard will close when the user presses anywhere on the screen outside of a text box
    override func touchesBegan(touches: Set<NSObject>, withEvent event: UIEvent)
    {
        usernameField.resignFirstResponder()
        passwordField.resignFirstResponder()
    }
    
    @IBAction func loginPressed(sender: UIButton)
    {
        self.spinningWheel.hidden = false
        authorizeHealthKit()
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
