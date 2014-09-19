//
//  DismissSegue.swift
//  TaskMe
//
//  Created by DavidMcQueen on 19/09/2014.
//  Copyright (c) 2014 DavidMcQueen. All rights reserved.
//

import UIKit

@objc(DismissSegue) class DismissSegue: UIStoryboardSegue {
   
    override func perform() {
        (sourceViewController.presentingViewController as UIViewController!).dismissViewControllerAnimated(true, completion: nil)
    }
}
