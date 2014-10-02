//
//  AppDelegate.swift
//  iBeacon Tutorial
//
//  Created by DavidMcQueen on 02/10/2014.
//  Copyright (c) 2014 DavidMcQueen. All rights reserved.
//

import UIKit
import CoreLocation

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate, CLLocationManagerDelegate {

    var window: UIWindow?
    var locationManager: CLLocationManager?


    func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool {
        
        let uuidString = "EBEFD083-70A2-47C8-9837-E7B5634DF524";
        //The UUID assigned to the iBeacon. The same UUID can be applied to multiple beacons (which are then differentiated via the Major & Minor values
        
        let beaconIdentifier = "iBeaconModules.us";
        //Not sure yet. This is the website tutorial is on
        
        let beaconUUID:NSUUID = NSUUID(UUIDString: uuidString);
        //not sure yet
        
        let beaconRegion:CLBeaconRegion = CLBeaconRegion(proximityUUID: beaconUUID, identifier: beaconIdentifier);
        
        locationManager = CLLocationManager();
        if(locationManager!.respondsToSelector("requestAlwaysAuthorization")){
            locationManager!.requestAlwaysAuthorization();
        }
        
        locationManager!.delegate = self;
        locationManager!.pausesLocationUpdatesAutomatically = false;
        
        locationManager!.startMonitoringForRegion(beaconRegion);
        locationManager!.startRangingBeaconsInRegion(beaconRegion);
        locationManager!.startUpdatingLocation();
        
        
        //If iOS 8 we need the users permission to send notifications
        if(application.respondsToSelector("registerUserNotificationSettings:")){
            application.registerUserNotificationSettings(UIUserNotificationSettings(
                forTypes: UIUserNotificationType.Alert | UIUserNotificationType.Sound, categories: nil
                )
            )
        }
        
        // TODO: - Handle if the above permission request is declined
        
        // TODO: - Add in the "9. CLean Up" section of the tutorial.
        return true
    }

    func applicationWillResignActive(application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
    }

    func applicationDidEnterBackground(application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }

    func applicationWillEnterForeground(application: UIApplication) {
        // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
    }

    func applicationDidBecomeActive(application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }

    func applicationWillTerminate(application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }


}

extension AppDelegate: CLLocationManagerDelegate {
    
    func sendLocalNotificationWithMessage(message: String!) {
        
        let notification:UILocalNotification = UILocalNotification();
        notification.alertBody = message;
        UIApplication.sharedApplication().scheduleLocalNotification(notification);
    }
    
    func locationManager(manager: CLLocationManager!, didRangeBeacons beacons: [AnyObject]!, inRegion region: CLBeaconRegion!){
        
        NSLog("didRangeBeacons");
        var message:String = "";
        
        if(beacons.count > 0){
            let nearestBeacon:CLBeacon = beacons[0] as CLBeacon;
            
            switch nearestBeacon.proximity {
            case CLProximity.Far:
                message = "You are far away from the Beacon";
            case CLProximity.Near:
                message = "You are near the beacon";
            case CLProximity.Immediate:
                message = "You are in the immediate proximity of the beacon";
            case CLProximity.Unknown:
                return;
            }
        } else{
            message = "No beacons are nearby";
        }
        
        NSLog("%@", message);
        sendLocalNotificationWithMessage(message);
    }
}



