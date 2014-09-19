//
//  MPCHandler.swift
//  TicTacToe
//
//  Created by DavidMcQueen on 19/09/2014.
//  Copyright (c) 2014 DavidMcQueen. All rights reserved.
//

import UIKit
import MultipeerConnectivity

class MPCHandler: NSObject, MCSessionDelegate {
    
    // MARK: - Parameters
    
    var peerID:MCPeerID!;
    var session:MCSession!;
    var browser:MCBrowserViewController!;
    var advertiser:MCAdvertiserAssistant? = nil;
    
    
    // MARK: - Functions
    
    func setupPeerWithDisplayName (displayName:String){
        peerID = MCPeerID(displayName: displayName);
    }
    
    func setupSession() {
        session = MCSession(peer: peerID);
        session.delegate = self;
    }
    
    func setupBrowser() {
        browser = MCBrowserViewController(serviceType: "my-game", session: session);
    }
    
    func advertiseSelf(advertise:Bool){
        if advertise{
            advertiser = MCAdvertiserAssistant(serviceType: "my-game", discoveryInfo: nil, session: session);
            advertiser!.start();
        }else{
            advertiser!.stop();
            advertiser = nil;
        }
    }
    
    // MARK: - Notifications
    
    //These 2 are required to send Notifications, and we need to use them (for the purpose of this project)
    func session(session: MCSession!, peer peerID: MCPeerID!, didChangeState state: MCSessionState) {
        //Fired every time the state of the session changes
        let userInfo = ["peerID":peerID, "state":state.toRaw()];
        dispatch_async(dispatch_get_main_queue(), { () -> Void in
            NSNotificationCenter.defaultCenter().postNotificationName("MPC_DidChangeStateNotification", object: nil, userInfo: userInfo)
        });
    }
    
    func session(session: MCSession!, didReceiveData data: NSData!, fromPeer peerID: MCPeerID!) {
        let userInfo = ["data":data, "peerID":peerID];
        dispatch_async(dispatch_get_main_queue(), { () -> Void in
            NSNotificationCenter.defaultCenter().postNotificationName("MPC_DidReceiveDataNotification", object: nil, userInfo: userInfo)
        });
    }
    
    // MARK: - Required Methods
    
    // These methods are required, however we don't need to insert any code into them as they are unused by us.
    func session(session: MCSession!, didFinishReceivingResourceWithName resourceName: String!, fromPeer peerID: MCPeerID!, atURL localURL: NSURL!, withError error: NSError!) {
        
    }
    
    func session(session: MCSession!, didStartReceivingResourceWithName resourceName: String!, fromPeer peerID: MCPeerID!, withProgress progress: NSProgress!) {
        
    }
    
    func session(session: MCSession!, didReceiveStream stream: NSInputStream!, withName streamName: String!, fromPeer peerID: MCPeerID!) {
        
    }
}
