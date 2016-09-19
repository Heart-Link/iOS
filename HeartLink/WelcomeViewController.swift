//
//  WelcomeViewController.swift
//  HeartLink
//
//  Created by User on 27/06/2016.
//  Copyright (c) 2016 Max. All rights reserved.
//

import UIKit

class WelcomeViewController: UITableViewController {
    
    var model = Model.sharedInstance
    
    @IBOutlet weak var nameLabel: UILabel!
    //@IBOutlet weak var tableV: UITableView!

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        self.tableView.backgroundColor = UIColor(red: 30/255, green: 0, blue: 120/255, alpha: 1)
        //navigationController!.navigationBar.barTintColor = UIColor(red: 50/255, green: 1, blue: 125/255, alpha: 1)
        
        navigationController!.navigationBar.barTintColor = UIColor(red: 30/255, green: 0, blue: 120/255, alpha: 1)
        
        navigationController!.navigationBar.titleTextAttributes = [NSForegroundColorAttributeName: UIColor.whiteColor()]
        
        UINavigationBar.appearance().barTintColor = UIColor.whiteColor()
        UINavigationBar.appearance().barStyle = UIBarStyle.Black
        UINavigationBar.appearance().tintColor = UIColor.whiteColor()
        UINavigationBar.appearance().titleTextAttributes = [NSForegroundColorAttributeName : UIColor.whiteColor()]
        UINavigationBar.appearance().titleTextAttributes = [NSFontAttributeName: UIFont(name: "Arial", size: 20)!]
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection: Int) -> Int
    {
        return model.welcomeOptions.count
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
    
    //fills the cells with the name of the city and returns the cell
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell
    {
        let cell = tableView.dequeueReusableCellWithIdentifier("Cell") as! UITableViewCell
        
        var options: String
        
        options = model.welcomeOptions[indexPath.row]
        
        cell.textLabel!.text = options
        cell.textLabel!.font = UIFont(name: "Arial", size: 30)!
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
            self.performSegueWithIdentifier("dataView", sender: self)
        }
        
        else if (indexPath.row == 1)
        {
            //let detailViewController = segue.destinationViewController
                //as! GameViewController
            self.performSegueWithIdentifier("gameView", sender: self)
        }
        
        else if (indexPath.row == 2)
        {
            self.performSegueWithIdentifier("historyView", sender: self)
        }
        
        else if (indexPath.row == 3)
        {
            //let detailViewController = segue.destinationViewController
                //as! DoctorContactViewController
            self.performSegueWithIdentifier("contactView", sender: self)
        }
        
        /*let myIndexPath = self.tableView.indexPathForSelectedRow()
                
        let currentCell = self.tableView.cellForRowAtIndexPath(myIndexPath!) as UITableViewCell!*/
    }
}
