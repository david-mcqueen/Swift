//
//  ViewController.swift
//  StopWatch
//
//  Created by DavidMcQueen on 09/09/2014.
//  Copyright (c) 2014 David McQueen. All rights reserved.
//

import UIKit;
import QuartzCore;

class ViewController: UIViewController {
    @IBOutlet weak var numericDisplay: UILabel!;
    @IBOutlet weak var resetButton: UIButton!;
    @IBOutlet weak var startStopButton: UIButton!;
    
    var displayLink: CADisplayLink!;
    var lastDisplayLinkTimeStamp: CFTimeInterval!;
    
    override func viewDidLoad() {
        super.viewDidLoad();
        // Do any additional setup after loading the view, typically from a nib.
        
        //Set default view element values
        self.numericDisplay.text = "0.00";
        self.resetButton.setTitle("Reset", forState: UIControlState.Normal);
        self.startStopButton.setTitle("Start", forState: UIControlState.Normal);
        
        //Initialising the display link and directng it to call our displayLinkUpdate: method when an update is available
        self.displayLink = CADisplayLink(target: self, selector: "displayLinkUpdate:");
        
        //Ensure that the pdislay link is initially not updating
        self.displayLink.paused = true;
        
        //Scheduling the display link to send notifications
        self.displayLink.addToRunLoop(NSRunLoop.mainRunLoop(), forMode: NSRunLoopCommonModes);
        
        //Initial timestamp
        self.lastDisplayLinkTimeStamp = self.displayLink.timestamp;
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning();
        // Dispose of any resources that can be recreated.
    }

    @IBAction func resetButtonPressed(sender: AnyObject) {
        //pause display link updates
        self.displayLink.paused = true;
        
        //Set efault numeric display value
        self.numericDisplay.text = "0.00";
        
        //Set button to start state
        self.startStopButton.setTitle("Start", forState: UIControlState.Normal);
    }

    @IBAction func startStopButtonPressed(sender: AnyObject) {
        //Toggle the displa link's paused bool value
        self.displayLink.paused = !(self.displayLink.paused);
        
        //If the displau lin is not updating us...
        var buttonText:String = "Stop";
        if self.displayLink.paused {
            if self.lastDisplayLinkTimeStamp > 0 {
                buttonText = "Resume";
            } else {
                buttonText = "Start";
            }
        }
        
        self.startStopButton.setTitle(buttonText, forState: UIControlState.Normal)
    }
    
    func displayLinkUpdate(sender: CADisplayLink){
        //Update running tally
        self.lastDisplayLinkTimeStamp = self.lastDisplayLinkTimeStamp + self.displayLink.duration;
        
        //Format the running tally to display on the last 2 significatdigits
        let formattedString:String = String(format: "%0.2f", self.lastDisplayLinkTimeStamp);
        
        //Display theformatted running tally
        self.numericDisplay.text = formattedString;
    }
    
    
    
}

