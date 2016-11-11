//
//  HealthHistoryViewController.swift
//  HeartLink
//
//  Created by User on 21/08/2016.
//  Copyright (c) 2016 Max. All rights reserved.
//

import Foundation
import UIKit
import CoreData

class HealthHistory: UITableViewController {
    
    let managedObjectContext =
    (UIApplication.sharedApplication().delegate
        as! AppDelegate).managedObjectContext
    
    var model = Model.sharedInstance
    var filteredDates = [String]()
    var currentDate: String = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view, typically from a nib.
        
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
    
    //returns the number of days
    override func tableView(tableView: UITableView, numberOfRowsInSection: Int) -> Int
    {
            let entityDescription =
            NSEntityDescription.entityForName("Patient",
                inManagedObjectContext: managedObjectContext!)
            
            let request = NSFetchRequest()
            request.entity = entityDescription
            
            var error: NSError?
            
            var objects = managedObjectContext?.executeFetchRequest(request,
                error: &error)
            
            if let results = objects
            {
                return results.count
            }
            return 1
    }
    
    //fills the cells with the name of the city and returns the cell
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell
    {
        let cell = self.tableView.dequeueReusableCellWithIdentifier("Cell") as! UITableViewCell
        
        var alcohol: String!
        var diastolic: String!
        var systolic: String!
        var date: String!
        var heartRate: String!
        var smoke: String!
        var steps: String!
        var stress: String!
        var weight: String!
        
        let entityDescription =
        NSEntityDescription.entityForName("Patient",
            inManagedObjectContext: managedObjectContext!)
        
        let request = NSFetchRequest()
        request.entity = entityDescription
        
        var error: NSError?
        
        var objects = managedObjectContext?.executeFetchRequest(request,
            error: &error)
        
        if let results = objects {
            if results.count > 0 {
                let match = results[indexPath.row] as! NSManagedObject
                
                println(String(results.count))
                alcohol = match.valueForKey("alcohol") as! String
                diastolic = match.valueForKey("diastolic") as! String
                date = match.valueForKey("date") as! String
                heartRate = match.valueForKey("heartRate") as! String
                smoke = match.valueForKey("smoke") as! String
                steps = match.valueForKey("steps") as! String
                stress = match.valueForKey("stress") as! String
                weight = match.valueForKey("weight") as! String
                systolic = match.valueForKey("systolic") as! String
            }
            
            //numRows = results.count
        }
        //println(date)
        cell.textLabel!.text = "HI"
        cell.accessoryType = UITableViewCellAccessoryType.DisclosureIndicator
        
        return cell
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject!)
    {
        
                let detailViewController = segue.destinationViewController
                    as! HistoryDetailViewController
                
                let myIndexPath = self.tableView.indexPathForSelectedRow()
                
                let currentCell = self.tableView.cellForRowAtIndexPath(myIndexPath!) as UITableViewCell!
                currentDate = currentCell.textLabel!.text!
                detailViewController.passedDate = currentDate
    }
    
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        // #warning Potentially incomplete method implementation.
        // Return the number of sections.
        return 1
    }
    
    /*func setDataForCell(cell:HistoryTableViewCell, indexPath:NSIndexPath) {
        var origin: String!
        var destination: String!
        var departDay: String!
        var departMonth: String!
        var departYear: String!
        var returnDay: String!
        var returnMonth: String!
        var returnYear: String!
        var trip: String!
        
        let entityDescription =
        NSEntityDescription.entityForName("Patient",
            inManagedObjectContext: managedObjectContext!)
        
        let request = NSFetchRequest()
        request.entity = entityDescription
        
        var error: NSError?
        
        var objects = managedObjectContext?.executeFetchRequest(request,
            error: &error)
        
        if let results = objects {
            if results.count > 0 {
                let match = results[indexPath.row] as! NSManagedObject
                
                origin = match.valueForKey("origin") as! String
                destination = match.valueForKey("destination") as! String
                departDay = match.valueForKey("departDay") as! String
                departMonth = match.valueForKey("departMonth") as! String
                departYear = match.valueForKey("departYear") as! String
                returnDay = match.valueForKey("returnDay") as! String
                returnMonth = match.valueForKey("returnMonth") as! String
                returnYear = match.valueForKey("returnYear") as! String
                if (origin != nil)
                {
                    self.slash1 = "/"
                    self.slash2 = "/"
                    self.slash3 = "/"
                    self.slash4 = "/"
                    self.arrow1 = "→"
                    self.arrow2 = "→"
                }
                
                i++
            }
            numRows = results.count
        }
        
        cell.origin.text = origin
        cell.dest.text = destination
        cell.departureDay.text = departDay
        cell.departureMonth.text = departMonth
        cell.departureYear.text = departYear
        cell.retDay.text = returnDay
        cell.retMonth.text = returnMonth
        cell.retYear.text = returnYear
        cell.slash1.text = slash1
        cell.slash2.text = slash2
        cell.slash3.text = slash3
        cell.slash4.text = slash4
        cell.arrow1.text = arrow1
        cell.arrow2.text = arrow2
    }*/
}