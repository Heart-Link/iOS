//
//  MessageViewController.swift
//  HeartLink
//
//  Created by User on 30/09/2016.
//  Copyright (c) 2016 Max. All rights reserved.
//

import UIKit
import Foundation
//import Firebase
import JSQMessagesViewController
import Alamofire

let messagesURL = "http://ec2-54-163-104-129.compute-1.amazonaws.com:8080/api/messages/patient/send"

class MessageViewController: JSQMessagesViewController {
    
    var messages = [JSQMessage]()
    var msgList = [String]()
    var outgoingBubbleImageView: JSQMessagesBubbleImage!
    var incomingBubbleImageView: JSQMessagesBubbleImage!
    var model = Model.sharedInstance
    var flag: Bool = true
    var i: Int = 0
    
    var convoIDs = [String]()
    var messageIDs = [String]()
    var messagesArray = [String]()
    var ids = [String]()
    var times = [String]()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationController!.navigationBar.barTintColor = UIColor(red: 30/255, green: 0, blue: 120/255, alpha: 1)
        
        title = "Contact Doctor"
        setupBubbles()
        collectionView!.collectionViewLayout.incomingAvatarViewSize = CGSizeZero
        collectionView!.collectionViewLayout.outgoingAvatarViewSize = CGSizeZero
        
        self.view.backgroundColor = UIColor(red: 135/255, green: 206/255, blue: 1, alpha: 1)
        
        DataManager.setJson(model.generateMessageJson())
        DataManager.getMessagesWithSuccess {(resultsData) -> Void in
            
            let json = JSON(data: resultsData)
            
            for(index, subJson):(String,JSON) in json
            {
                self.convoIDs.append(subJson["convoid"].string!)
                self.messageIDs.append(subJson["messengerid"].string!)
                self.messagesArray.append(subJson["message"].string!)
                self.times.append(subJson["timestamp"].string!)
            }
            
        }
        
        self.loadData()
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewWillAppear(animated: Bool) {
        
    }
    
    func loadData()
    {
        
    }
    
    override func collectionView(collectionView: JSQMessagesCollectionView!, messageDataForItemAtIndexPath indexPath: NSIndexPath!) -> JSQMessageData!
    {
            return messages[indexPath.item]
    }
    
    override func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int
    {
            return messages.count
    }
    
    private func setupBubbles()
    {
        let factory = JSQMessagesBubbleImageFactory()
        outgoingBubbleImageView = factory.outgoingMessagesBubbleImageWithColor(
            UIColor.jsq_messageBubbleBlueColor())
        incomingBubbleImageView = factory.incomingMessagesBubbleImageWithColor(
            UIColor.jsq_messageBubbleLightGrayColor())
    }
    
    override func collectionView(collectionView: JSQMessagesCollectionView!, messageBubbleImageDataForItemAtIndexPath indexPath: NSIndexPath!) -> JSQMessageBubbleImageDataSource!
    {
            let message = messages[indexPath.item]
            if message.senderId == senderId
            {
                return outgoingBubbleImageView
            }
            
            else
            {
                return incomingBubbleImageView
            }
    }
    
    override func collectionView(collectionView: JSQMessagesCollectionView!, avatarImageDataForItemAtIndexPath indexPath: NSIndexPath!) -> JSQMessageAvatarImageDataSource!
    {
            return nil
    }
    
    func addMessage(id: String, text: String)
    {
        let message = JSQMessage(senderId: id, displayName: "", text: text)
        messages.append(message)
    }
    
    override func viewDidAppear(animated: Bool)
    {
        super.viewDidAppear(animated)
        
        var i: Int = 0
        
        for (i = 0; i < messagesArray.count; i++)
        {
            if (messageIDs[i] == model.emrID)
            {
                addMessage(senderId, text: messagesArray[i])
            }
            
            else
            {
                addMessage(messageIDs[i], text: messagesArray[i])
            }
        }
        
        // messages from someone else
        /*addMessage("foo", text: "Hello patient!")
        
        // messages sent from local sender
        addMessage(senderId, text: "What's good man?")
        addMessage(senderId, text: "I'm sick")
        
        addMessage("foo", text: "Sucks for you")*/
        
        // animates the receiving of a new message on the view
        finishReceivingMessage()
    }
    
    override func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell
    {
            let cell = super.collectionView(collectionView, cellForItemAtIndexPath: indexPath)
                as! JSQMessagesCollectionViewCell
            
            let message = messages[indexPath.item]
            
            if message.senderId == senderId
            {
                cell.textView!.textColor = UIColor.whiteColor()
            }
            
            else
            {
                cell.textView!.textColor = UIColor.blackColor()
            }
            
            return cell
    }
    
    override func didPressSendButton(button: UIButton!, withMessageText text: String!, senderId: String!,
        senderDisplayName: String!, date: NSDate!) {
            
            model.messageJson = "{\"emrid\": \"" + model.emrID + "\", \"token\": \"" + model.tokenID + "\", \"message\": \"" + text + "\"}"
            var i = 0
            
            JSQSystemSoundPlayer.jsq_playMessageSentSound()
            
            DataManager.sendMessageWithSuccess {(messageData) -> Void in
                let json = JSON(data: messageData)
            }
            
            finishSendingMessageAnimated(true)
            //messagesArray.append(text)
            //self.viewDidAppear(true)
            self.collectionView?.reloadData()
            
            /*var seconds = 1.0
            var delay = seconds * Double(NSEC_PER_SEC)
            var dispatchTime = dispatch_time(DISPATCH_TIME_NOW, Int64(delay))
            
            dispatch_after(dispatchTime, dispatch_get_main_queue(),
                {
                    DataManager.setJson(self.model.generateMessageJson())
                    DataManager.getMessagesWithSuccess {(resultsData) -> Void in
                        
                        let json = JSON(data: resultsData)
                        
                        /*for(index, subJson):(String,JSON) in json
                        {
                        self.convoIDs.append(subJson["convoid"].string!)
                        self.messageIDs.append(subJson["messengerid"].string!)
                        self.messagesArray.append(subJson["message"].string!)
                        self.times.append(subJson["timestamp"].string!)
                        }*/
                        
                    }
            
                
            })
            
            seconds = 2.0
            delay = seconds * Double(NSEC_PER_SEC)
            dispatchTime = dispatch_time(DISPATCH_TIME_NOW, Int64(delay))
            
            dispatch_after(dispatchTime, dispatch_get_main_queue(),
                {
                    self.addMessage(senderId, text: text)
                    self.viewDidAppear(true)
                })*/
    }
    
    override func didPressAccessoryButton(sender: UIButton) {
        
    }
    
    //override

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
