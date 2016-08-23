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
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection: Int) -> Int
    {
        return model.welcomeOptions.count
    }
    
    //fills the cells with the name of the city and returns the cell
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell
    {
        let cell = tableView.dequeueReusableCellWithIdentifier("Cell") as! UITableViewCell
        
        var options: String
        
        options = model.welcomeOptions[indexPath.row]
        
        cell.textLabel!.text = options
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
