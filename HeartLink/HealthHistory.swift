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
    
    var currentDate: String!
    var selectedDate: Int!
    
    var alcohol = [String]()
    var diastolic = [String]()
    var systolic = [String]()
    var date = [String]()
    var heartRate = [String]()
    var smoke = [String]()
    var steps = [String]()
    var stress = [String]()
    var weight = [String]()
    
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
        
        var alcoholStr: String!
        var diastolicStr: String!
        var systolicStr: String!
        var dateStr: String!
        var heartRateStr: String!
        var smokeStr: String!
        var stepsStr: String!
        var stressStr: String!
        var weightStr: String!
        
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
                
                alcoholStr = match.valueForKey("alcohol") as! String
                diastolicStr = match.valueForKey("diastolic") as! String
                dateStr = match.valueForKey("date") as! String
                heartRateStr = match.valueForKey("heartRate") as! String
                smokeStr = match.valueForKey("smoke") as! String
                stepsStr = match.valueForKey("steps") as! String
                stressStr = match.valueForKey("stress") as! String
                weightStr = match.valueForKey("weight") as! String
                systolicStr = match.valueForKey("systolic") as! String
                
                alcohol.append(alcoholStr)
                diastolic.append(diastolicStr)
                date.append(dateStr)
                heartRate.append(heartRateStr)
                smoke.append(smokeStr)
                stress.append(stressStr)
                steps.append(stepsStr)
                weight.append(weightStr)
                systolic.append(systolicStr)
            }
        }
        
        cell.textLabel!.text = dateStr
        cell.textLabel!.font = UIFont(name: "Avenir Next", size: 30)!
        cell.textLabel!.textColor = UIColor.whiteColor()
        cell.accessoryType = UITableViewCellAccessoryType.DisclosureIndicator
        
        return cell
    }
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath)
    {
        selectedDate = indexPath.row
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject!)
    {
        
                let detailViewController = segue.destinationViewController
                    as! HistoryDetailViewController
                
                let myIndexPath = self.tableView.indexPathForSelectedRow()
                
                let currentCell = self.tableView.cellForRowAtIndexPath(myIndexPath!) as UITableViewCell!
                currentDate = currentCell.textLabel!.text!
                
                detailViewController.selection = myIndexPath!.row
                detailViewController.passedDate = date
                detailViewController.passedAlcohol = alcohol
                detailViewController.passedDiastolic = diastolic
                detailViewController.passedHeartRate = heartRate
                detailViewController.passedSmoke = smoke
                detailViewController.passedSteps = steps
                detailViewController.passedStress = stress
                detailViewController.passedWeight = weight
                detailViewController.passedSystolic = systolic
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