//
//  DataEntryViewController.swift
//  HeartLink
//
//  Created by User on 21/08/2016.
//  Copyright (c) 2016 Max. All rights reserved.
//

import UIKit

class DataEntryViewController: UITableViewController {
    
    var model = Model.sharedInstance
    
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
        return model.entryOptions.count
    }
    
    //fills the cells with the name of the city and returns the cell
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell
    {
        let cell = tableView.dequeueReusableCellWithIdentifier("Cell") as! UITableViewCell
        
        var options: String
        
        options = model.entryOptions[indexPath.row]
        
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
            self.performSegueWithIdentifier("bloodPressure", sender: self)
        }
            
        else if (indexPath.row == 1)
        {
            self.performSegueWithIdentifier("showWeight", sender: self)
        }
            
        else if (indexPath.row == 2)
        {
            self.performSegueWithIdentifier("showAlcohol", sender: self)
        }
            
        else if (indexPath.row == 3)
        {
            self.performSegueWithIdentifier("dietView", sender: self)
        }
        
        else if (indexPath.row == 4)
        {
            self.performSegueWithIdentifier("stressView", sender: self)
        }
        
        else if (indexPath.row == 5)
        {
            self.performSegueWithIdentifier("smokeView", sender: self)
        }
        
        /*let myIndexPath = self.tableView.indexPathForSelectedRow()
        
        let currentCell = self.tableView.cellForRowAtIndexPath(myIndexPath!) as UITableViewCell!*/
    }
}