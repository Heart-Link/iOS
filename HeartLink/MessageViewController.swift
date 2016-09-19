//
//  MessageViewController.swift
//  HeartLink
//
//  Created by User on 16/09/2016.
//  Copyright (c) 2016 Max. All rights reserved.
//

import UIKit

class MessageViewController: UIViewController {
    
    @IBOutlet weak var lab: UILabel!
    var newJson: String!

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        createJson()
        DataManager.setJson(newJson)
        DataManager.getMessageWithSuccess {(messageData) -> Void in
            let json = JSON(data: messageData)
            
            if let message = json["message"].string
            {
                println(message + "IIIIII")
            }
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func createJson() -> Void
    {
        newJson = "{\"request\": {\"message\" : \"text\"}}"
        //newJson = ""
        //"{\"request\": {\"passengers\": {\"adultCount\": 1},\"slice\": [{\"origin\": \"BOS\",\"destination\": \"LAX\",\"date\": \"2015-08-20\"},{\"origin\": \"LAX\",\"destination\": \"BOS\",\"date\": \"2015-08-25\"}], \"solutions\": 10}}"
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
