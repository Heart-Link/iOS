//
//  WelcomeViewController.swift
//  HeartLink
//
//  Created by User on 27/06/2016.
//  Copyright (c) 2016 Max. All rights reserved.
//

import UIKit
import HealthKit

class WelcomeViewController: UITableViewController {
    
    var model = Model.sharedInstance
    var selected: Int!
    let healthKitEntity: HealthKitEntity = HealthKitEntity()
    
    @IBOutlet weak var nameLabel: UILabel!
    //@IBOutlet weak var tableV: UITableView!

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        UINavigationBar.appearance().hidden = false
        
        self.tableView.backgroundColor = UIColor(red: 30/255, green: 0, blue: 120/255, alpha: 1)
        //navigationController!.navigationBar.barTintColor = UIColor(red: 50/255, green: 1, blue: 125/255, alpha: 1)
        
        navigationController!.navigationBar.barTintColor = UIColor(red: 30/255, green: 0, blue: 120/255, alpha: 1)
        
        navigationController!.navigationBar.titleTextAttributes = [NSForegroundColorAttributeName: UIColor.whiteColor()]
        
        //UINavigationBar.appearance().barTintColor = UIColor.whiteColor()
        UINavigationBar.appearance().barStyle = UIBarStyle.Black
        UINavigationBar.appearance().tintColor = UIColor.whiteColor()
        UINavigationBar.appearance().titleTextAttributes = [NSForegroundColorAttributeName : UIColor.whiteColor()]
        UINavigationBar.appearance().titleTextAttributes = [NSFontAttributeName: UIFont(name: "Avenir Next", size: 20)!]
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //asks for permission to access user's health app
    
    override func tableView(tableView: UITableView, numberOfRowsInSection: Int) -> Int
    {
        return model.welcomeOptions.count
    }
    
    //handles the segue if contact doctor is chosen
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?)
    {
        if (selected == 3)
        {
            super.prepareForSegue(segue, sender: sender)
            let navVc = segue.destinationViewController as! UINavigationController // 1
            let chatVc = navVc.viewControllers.first as! MessageViewController // 2
            chatVc.senderId = "" // 3
            chatVc.senderDisplayName = "" // 4
        }
    }
    
    //sets cell colors
    override func tableView(tableView: UITableView, willDisplayCell cell: UITableViewCell, forRowAtIndexPath indexPath: NSIndexPath) {
        
        if (indexPath.row % 4 == 0)
        {
            cell.backgroundColor = UIColor(red: 135/255, green: 206/255, blue: 1, alpha: 1)
        }
        
        else if (indexPath.row % 4 == 1)
        {
            cell.backgroundColor = UIColor(red: 126/255, green: 192/255, blue: 238/255, alpha: 1)
        }
            
        else if (indexPath.row % 4 == 2)
        {
            cell.backgroundColor = UIColor(red: 108/255, green: 166/255, blue: 205/255, alpha: 1)
        }
        
        else if (indexPath.row % 4 == 3)
        {
            cell.backgroundColor = UIColor(red: 74/255, green: 112/255, blue: 139/255, alpha: 1)
        }
        
        tableView.separatorStyle = .None
    }
    
    //fills the cells with the appropriate welcome options and returns the cell
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell
    {
        let cell = tableView.dequeueReusableCellWithIdentifier("Cell") as! UITableViewCell
        
        var options: String
        
        options = model.welcomeOptions[indexPath.row]
        
        cell.textLabel!.text = options
        cell.textLabel!.font = UIFont(name: "Avenir Next", size: 30)!
        cell.textLabel!.textColor = UIColor.whiteColor()
        cell.accessoryType = UITableViewCellAccessoryType.DisclosureIndicator
        
        return cell
    }
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath)
    {
        let myIndexPath = self.tableView.indexPathForSelectedRow()
        
        let currentCell = self.tableView.cellForRowAtIndexPath(myIndexPath!) as UITableViewCell!
        let currentSelection = currentCell.textLabel!.text!
        
        if (indexPath.row == 0)
        {
            selected = 0
            self.performSegueWithIdentifier("dataView", sender: self)
        }
        
        else if (indexPath.row == 1)
        {
            //let detailViewController = segue.destinationViewController
                //as! GameViewController
            selected = 1
            self.performSegueWithIdentifier("gameView", sender: self)
        }
        
        else if (indexPath.row == 2)
        {
            selected = 2
            self.performSegueWithIdentifier("historyView", sender: self)
        }
        
        else if (indexPath.row == 3)
        {
            //let detailViewController = segue.destinationViewController
                //as! DoctorContactViewController
            selected = 3
            self.performSegueWithIdentifier("contactView", sender: self)
        }
        
        else if (indexPath.row == 4)
        {
            selected = 4
            self.performSegueWithIdentifier("logout", sender: self)
        }
        
        /*let myIndexPath = self.tableView.indexPathForSelectedRow()
                
        let currentCell = self.tableView.cellForRowAtIndexPath(myIndexPath!) as UITableViewCell!*/
    }
}
