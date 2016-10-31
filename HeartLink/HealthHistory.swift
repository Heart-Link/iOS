//
//  DataEntryViewController.swift
//  HeartLink
//
//  Created by User on 21/08/2016.
//  Copyright (c) 2016 Max. All rights reserved.
//

import UIKit

class HealthHistoryViewController: UITableViewController {
    
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
        
        UINavigationBar.appearance().barTintColor = UIColor.whiteColor()
        UINavigationBar.appearance().barStyle = UIBarStyle.Black
        UINavigationBar.appearance().tintColor = UIColor.whiteColor()
        UINavigationBar.appearance().titleTextAttributes = [NSForegroundColorAttributeName : UIColor.whiteColor()]
        UINavigationBar.appearance().titleTextAttributes = [NSFontAttributeName: UIFont(name: "Avenir Next", size: 20)!]
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //distinguishes between the search results and the full list
    override func tableView(tableView: UITableView, numberOfRowsInSection: Int) -> Int
    {
        if (tableView == self.searchDisplayController!.searchResultsTableView)
        {
            return self.filteredDates.count
        }
            
        else
        {
            return model.dates.count
        }
    }
    
    //fills the cells with the name of the city and returns the cell
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell
    {
        let cell = self.tableView.dequeueReusableCellWithIdentifier("Cell") as! UITableViewCell
        
        var date: String
        
        if (tableView == self.searchDisplayController!.searchResultsTableView)
        {
            date = filteredDates[indexPath.row]
        }
            
        else
        {
            date = model.dates[indexPath.row]
        }
        
        cell.textLabel!.text = date
        cell.accessoryType = UITableViewCellAccessoryType.DisclosureIndicator
        
        return cell
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject!)
    {
        if (segue.identifier == "DateDetails")
        {
            //if the search results are being displayed rather than the full list, use the selected search result
            if (self.searchDisplayController!.active)
            {
                let myIndexPath = self.searchDisplayController!.searchResultsTableView.indexPathForSelectedRow()
                
                let destinationTitle = self.filteredDates[myIndexPath!.row]
                
                var detailViewController = segue.destinationViewController as! HistoryDetailViewController
                detailViewController.passedDate = destinationTitle
            }
                
                //otherwise, use the full list of dates
            else
            {
                let detailViewController = segue.destinationViewController
                    as! HistoryDetailViewController
                
                let myIndexPath = self.tableView.indexPathForSelectedRow()
                
                let currentCell = self.tableView.cellForRowAtIndexPath(myIndexPath!) as UITableViewCell!
                currentDate = currentCell.textLabel!.text!
                detailViewController.passedDate = currentDate
            }
        }
    }
    
    //when using the search function, compare the string entered by the user with the ones in the cells
    func filterContentForSearchText(searchText: String)
    {
        self.filteredDates = self.model.dates.filter({(date: String) -> Bool in
            let stringMatch = date.rangeOfString(searchText)
            return stringMatch != nil
        })
    }
    
    func searchDisplayController(controller: UISearchDisplayController!, shouldReloadTableForSearchString searchString: String!) -> Bool
    {
        self.filterContentForSearchText(searchString)
        return true
    }
    
    func searchDisplayController(controller: UISearchDisplayController!, shouldReloadTableForSearchScope searchOption: Int) -> Bool
    {
        self.filterContentForSearchText(self.searchDisplayController!.searchBar.text)
        return true
    }
}