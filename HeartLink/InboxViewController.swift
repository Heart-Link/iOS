//
//  DataEntryViewController.swift
//  HeartLink
//
//  Created by User on 21/08/2016.
//  Copyright (c) 2016 Max. All rights reserved.
//

import UIKit

class InboxViewController: UITableViewController {
    
    var model = Model.sharedInstance
    var numMessages = 1    //temporary until we can load the actual number
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationController!.toolbarHidden = false;
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection: Int) -> Int
    {
        return numMessages
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        return resultsTableViewCellAtIndexPath(indexPath)
    }
    
    func resultsTableViewCellAtIndexPath(indexPath:NSIndexPath) -> InboxTableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("Cell") as! InboxTableViewCell
        setDataForCell(cell, indexPath: indexPath)
        
        return cell
    }

    //fills the cells with the sender and subject of the email and returns the cell
    func setDataForCell(cell:InboxTableViewCell, indexPath:NSIndexPath) {
        var subject: String
        var sender: String
        
        subject = model.msgSubjects[indexPath.row]
        sender = model.msgSenders[indexPath.row]
        
        cell.subjectLabel.text = subject
        cell.senderLabel.text = sender
    }
}
