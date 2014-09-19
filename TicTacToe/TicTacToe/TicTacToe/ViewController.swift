//
//  ViewController.swift
//  TicTacToe
//
//  Created by DavidMcQueen on 19/09/2014.
//  Copyright (c) 2014 DavidMcQueen. All rights reserved.
//

import UIKit
import MultipeerConnectivity

class ViewController: UIViewController, MCBrowserViewControllerDelegate {

    
    // TODO: - Add in functionaltiy so that you cant take consequitive turns before the ther player has had their turn
    //After a person has played - set a BOOL to deactivate them. Only reactivate them when they recieve a message that the other person has played / game reset
    //An outlet collection. Which is like an array, for each of the outlets (image fields)
    @IBOutlet var fields: [TTTImageView]!
    var currentPlayer:String!;
    
    //Used to connect to the AppDelegate. Initalised in viewDidLoad()
    var appDelegate:AppDelegate!;
    
    override func viewDidLoad() {
        super.viewDidLoad()
        appDelegate = UIApplication.sharedApplication().delegate as AppDelegate;
        appDelegate.mpcHandler.setupPeerWithDisplayName(UIDevice.currentDevice().name); //The name of the device
        appDelegate.mpcHandler.setupSession();
        appDelegate.mpcHandler.advertiseSelf(true); //We want to advertise outself
        
        
        //Listen for the notifications, which are sent in the MPCHandler class. Call functions below
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "peerChangedStateWithNotification", name: "MPC_DidChangeStateNotification", object: nil);
        
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "handleReceivedDataWithNotification", name: "MPC_DidReceiveDataNotification", object: nil);
        
        setupField();
        currentPlayer = "x";
    }

    
    // MARK: - UIFunctions
    
    //Function connected to the 'Connect' button on the store board notification bar
    @IBAction func connectWithPlayer(sender: AnyObject) {
        if appDelegate.mpcHandler.session != nil{
            appDelegate.mpcHandler.setupBrowser();
            appDelegate.mpcHandler.browser.delegate = self;
            
            self.presentViewController(appDelegate.mpcHandler.browser, animated: true, completion: nil);
            
        }
    }
    
    @IBAction func newGame(sender: AnyObject) {
        resetField();
        
        let messageDict = ["string": "New Game"];
        
        let messageData = NSJSONSerialization.dataWithJSONObject(messageDict, options: NSJSONWritingOptions.PrettyPrinted, error: nil);
        
        var error:NSError?
        appDelegate.mpcHandler.session.sendData(messageData, toPeers: appDelegate.mpcHandler.session.connectedPeers, withMode: MCSessionSendDataMode.Reliable, error: &error);
        
        if error != nil {
            println("error: \(error?.localizedDescription)");
        }
        
    }
    
    // MARK: - Notification Functions
    
    //Functions called from the notifications
    func peerChangedStateWithNotification(notification:NSNotification){
        //Use the information that is stored in the dictionary passed in via the notification (in MPCHandler class)
        let userInfo = NSDictionary(dictionary: notification.userInfo!);
        
        let state = userInfo.objectForKey("state") as Int;
        
        //Use the state to check if we have successfully pair the 2 devices
        if state != MCSessionState.Connecting.toRaw(){
            self.navigationItem.title = "Connected"; //Diplayed in the navigation bar
        }
        // TODO: - Should check for all of the states. Disconnected, connecting, connected
    }
    
    func handleReceivedDataWithNotification(notification:NSNotification){
        let userInfo = notification.userInfo! as Dictionary //This is a swift data type. whereas the one above (NSDictionary) is not
        let receivedData:NSData = userInfo["data"] as NSData;
        
        //Get the message
        let message = NSJSONSerialization.JSONObjectWithData(receivedData, options: NSJSONReadingOptions.AllowFragments, error: nil) as NSDictionary;
        let senderPeerID:MCPeerID = userInfo["peerID"] as MCPeerID;
        let senderDisplayName = senderPeerID.displayName;
        
        //Check if a new game should be started
        if message.objectForKey("string")?.isEqualToString("New Game") == true {
            let alert = UIAlertController(title: "Tic Tac Toe", message: "\(senderDisplayName) started a new game", preferredStyle: UIAlertControllerStyle.Alert);
            alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.Default, handler: nil));
            
            self.presentViewController(alert, animated: true, completion: nil);
            
            resetField();
        }else{
            //We can now get the information we need out of the message
            var field:Int? = message.objectForKey("field")?.integerValue;
            var player:String? = message.objectForKey("player") as? String;
        
            if field != nil && player != nil {
                fields[field!].player = player;
                fields[field!].setPlayer(player!);
            
                if player == "x"{
                    currentPlayer = "o";
                }else {
                    currentPlayer = "x";
                }
            
            checkResults();
            }
        }
    }
    
    
    // MARK: - Functions
    
    func fieldTapped(recognizer:UITapGestureRecognizer){
        let tappedField = recognizer.view as TTTImageView;
        tappedField.setPlayer(currentPlayer);
        
        //We want to inform the other device about every tap on the game field
        let messageDict = ["field":tappedField.tag, "player":currentPlayer];
        //tappedField.tag is corresponding to the TAG we setup earlier on the image view
        
        
        //We cant send a dictionary, we can only send NSData objects
        let messageData = NSJSONSerialization.dataWithJSONObject(messageDict, options: NSJSONWritingOptions.PrettyPrinted, error: nil);
        // TODO: - Should not use nil for error. This should be handled correctly by checking for the error
        
        
        //To send the data
        var error:NSError?
        
        appDelegate.mpcHandler.session.sendData(messageData, toPeers: appDelegate.mpcHandler.session.connectedPeers, withMode: MCSessionSendDataMode.Reliable, error: &error);
        
        if error != nil {
            println("Error: \(error?.localizedDescription)");
        }
        
        checkResults();
        
    }
    
    func resetField() {
        for index in 0 ... (fields.count - 1){
            fields[index].image = nil;
            fields[index].activated = false;
            fields[index].player = "";
        }
        currentPlayer = "x";
    }
    
    func checkResults(){
        //Need to check all possible combinations of winning (3 in a row)
        var winner = ""
        
        // TODO: - Insert the algorithmn to determine the winner
        
        if winner != ""{
            //Display a popup to the users saying there is a winner
            let alert = UIAlertController(title: "Tic Tac Toe", message: "The Winner is \(winner)", preferredStyle: UIAlertControllerStyle.Alert)
            alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.Default, handler: { (alert:UIAlertAction!) -> Void in
                self.resetField();
            }));
            
            self.presentViewController(alert, animated: true, completion: nil);
        }
        
    }
    
    func setupField () {
        //As the image view has no UI interaction by default, we need to add a gesture recognizer to each of the image fields.
        for index in 0 ... (fields.count - 1){
            let gestureRecognizer = UITapGestureRecognizer(target:self, action:"fieldTapped");
            gestureRecognizer.numberOfTapsRequired = 1;
            
            fields[index].addGestureRecognizer(gestureRecognizer)
        }
    }
    
    
    func browserViewControllerDidFinish(browserViewController: MCBrowserViewController!) {
        appDelegate.mpcHandler.browser.dismissViewControllerAnimated(true, completion: nil);
    }
    
    func browserViewControllerWasCancelled(browserViewController: MCBrowserViewController!) {
        appDelegate.mpcHandler.browser.dismissViewControllerAnimated(true, completion: nil);
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

