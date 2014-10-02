//
//  myViewController2ViewController.swift
//  NavTutorial
//
//  Created by DavidMcQueen on 02/10/2014.
//  Copyright (c) 2014 DavidMcQueen. All rights reserved.
//

import UIKit

class myViewController2ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func toView1Pressed(sender: AnyObject) {
        self.navigationController?.popToRootViewControllerAnimated(true)
    }
}
