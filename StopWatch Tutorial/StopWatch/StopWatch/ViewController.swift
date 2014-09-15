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
    @IBOutlet weak var splitButton: UIButton!
    
    var displayLink: CADisplayLink!;
    var lastDisplayLinkTimeStamp: CFTimeInterval!;
    
    override func viewDidLoad() {
        super.viewDidLoad();
        // Do any additional setup after loading the view, typically from a nib.
        
        //Set default view element values
        self.numericDisplay.text = "0.00";
        self.resetButton.setTitle("Reset", forState: UIControlState.Normal);
        self.startStopButton.setTitle("Start", forState: UIControlState.Normal);
        self.splitButton.setTitle("Split", forState: UIControlState.Normal);
        
        
        //Initialising the display link and directng it to call our displayLinkUpdate: method when an update is available
        self.displayLink = CADisplayLink(target: self, selector: "displayLinkUpdate:");
        
        //Ensure that the dislay link is initially not updating
        self.displayLink.paused = true;
        
        //Hide the split button whilst we are not timing
        self.splitButton.hidden = true;
        
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
        
        //Hide the split button whist we are not timing
        self.splitButton.hidden = true;
    }

    @IBAction func startStopButtonPressed(sender: AnyObject) {
        //Toggle the display link's paused bool value
        self.displayLink.paused = !(self.displayLink.paused);
        
        self.splitButton.hidden = !self.splitButton.hidden;
        
        //If the display link is not updating us...
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
    
    @IBAction func splitButtonPressed(sender: AnyObject) {
        
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

class SplitTimeDataSource : NSObject {
    var times:[Double] = [10.00, 11.00, 12.00, 13.00];
    
    func tableView(tableView: UITableView!, numbeOfRowsInSection section: Int) -> Int {
        return times.count;
    }
    
    func tableView(tableView: UITableView!, cellForRowAtIndexPath  indexPath: NSIndexPath!) -> UITableViewCell! {
        let cell = UITableViewCell(style: UITableViewCellStyle.Value2, reuseIdentifier: nil);
        
        return cell;
    }
}

