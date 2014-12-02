//
//  ViewController.swift
//  BMI Calculator
//
//  Created by DavidMcQueen on 02/12/2014.
//  Copyright (c) 2014 David McQueen. All rights reserved.
//

import UIKit
import HealthKit

class ViewController: UIViewController {
    
    var healthStore: HKHealthStore? = nil;
    
    @IBOutlet weak var heightInput: UITextField!
    @IBOutlet weak var weightInput: UITextField!
    @IBOutlet weak var BMIOutput: UITextField!

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        // TODO:- Get height and weight, pre populate the fields?
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func calculatePressed(sender: AnyObject) {
        var height = (NSString(string:heightInput.text).doubleValue);
        var weight = (NSString(string: weightInput.text)).doubleValue;
        var BMIInput: Double = (weight/height) / height;
        NSLog(String(format:"%f", BMIInput));
        writeBMI(BMIInput);
        //writeHeight(height);
        writeWeight(weight*1000)
        BMIOutput.text = String(format:"%f", BMIInput);
    }
    
    
    func writeBodyTemperature(){
        let identifier = HKQuantityTypeIdentifierBodyTemperature;
        let quantityType = HKObjectType.quantityTypeForIdentifier(identifier);
        
        let authorisationStatus = healthStore?.authorizationStatusForType(quantityType);
        
        if (authorisationStatus != HKAuthorizationStatus.SharingAuthorized){
            NSLog("Not authorised to write body temp");
            return;
        }
        
        let min: UInt32 = 977;
        let max: UInt32 = 995;
        //Generate a random temp value
        let temperatureValueInDegF = Double((arc4random() % (max - min)) + min) / 10;
        
        let temperatureQuantity = HKQuantity(unit: HKUnit.degreeFahrenheitUnit(), doubleValue: temperatureValueInDegF);
        
        let startDate = NSDate();
        let endDate = NSDate();
        
        //TAdd metadata, saying that the body temp is from the ear
        let metadata = [HKMetadataKeyBodyTemperatureSensorLocation:HKBodyTemperatureSensorLocation.Ear.rawValue];
        
        let temperatureSample = HKQuantitySample(type: quantityType, quantity: temperatureQuantity, startDate: startDate, endDate: endDate, metadata: metadata);
        
        
        healthStore?.saveObject(temperatureSample, withCompletion: {
            (success: Bool, error: NSError!) -> Void in
            if success {
                dispatch_async(dispatch_get_main_queue(), {
                    var alert = UIAlertController(title: "Information", message: "Body temp saved", preferredStyle: UIAlertControllerStyle.Alert);
                    self.presentViewController(alert, animated: true, completion: nil);
                    alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.Default, handler: nil));
                    NSLog("Temp was saved OK");
                })
            }else{
                NSLog("Failed to save temperature. Error: \(error)");
            }
        })
    }
    
    func writeHeight(HeightInput: Double){
        let identifier = HKQuantityTypeIdentifierHeight;
        let quantityType = HKObjectType.quantityTypeForIdentifier(identifier);
        let authorisationStatus = healthStore?.authorizationStatusForType(quantityType);
        
        if (authorisationStatus != HKAuthorizationStatus.SharingAuthorized){
            NSLog("Not authorised to write Height");
            return;
        }
        
        let startDate = NSDate();
        let endDate = NSDate();
        
        let HeightQuantity = HKQuantity(unit: HKUnit.meterUnit(), doubleValue: HeightInput);
        
        let HeightSample = HKQuantitySample(type: quantityType, quantity: HeightQuantity, startDate: startDate, endDate: endDate);
        
        healthStore?.saveObject(HeightSample, withCompletion: {
            (success: Bool, error: NSError!) -> Void in
            if success {
                dispatch_async(dispatch_get_main_queue(), {
                    NSLog("Height was saved OK");
                })
            }else{
                NSLog("Failed to save Height. Error: \(error)");
            }
        })
        
    }
    
    func writeWeight(WeightInput: Double){
        //Saves as Gram's
        let identifier = HKQuantityTypeIdentifierBodyMass;
        let quantityType = HKObjectType.quantityTypeForIdentifier(identifier);
        let authorisationStatus = healthStore?.authorizationStatusForType(quantityType);
        
        if (authorisationStatus != HKAuthorizationStatus.SharingAuthorized){
            NSLog("Not authorised to write Weight");
            return;
        }
        
        let startDate = NSDate();
        let endDate = NSDate();
        
        let WeightQuantity = HKQuantity(unit: HKUnit.gramUnit(), doubleValue: WeightInput);
        
        let WeightSample = HKQuantitySample(type: quantityType, quantity: WeightQuantity, startDate: startDate, endDate: endDate);
        
        healthStore?.saveObject(WeightSample, withCompletion: {
            (success: Bool, error: NSError!) -> Void in
            if success {
                dispatch_async(dispatch_get_main_queue(), {
                    NSLog("Weight was saved OK");
                })
            }else{
                NSLog("Failed to save Weight. Error: \(error)");
            }
        })
        
    }
    
    func writeBMI(BMIInput: Double){
        let identifier = HKQuantityTypeIdentifierBodyMassIndex;
        let quantityType = HKObjectType.quantityTypeForIdentifier(identifier);
        let authorisationStatus = healthStore?.authorizationStatusForType(quantityType);
        
        if (authorisationStatus != HKAuthorizationStatus.SharingAuthorized){
            NSLog("Not authorised to write BMI");
            return;
        }
        
        let startDate = NSDate();
        let endDate = NSDate();
        
//        let weight: Double = 79.5; //kg
//        let height: Double = 1.90; //m
//        let BMI: Double = (weight/height) / height;
        
        let BMIQuantity = HKQuantity(unit: HKUnit.countUnit(), doubleValue: BMIInput);
        
        let BMISample = HKQuantitySample(type: quantityType, quantity: BMIQuantity, startDate: startDate, endDate: endDate);
        
        healthStore?.saveObject(BMISample, withCompletion: {
            (success: Bool, error: NSError!) -> Void in
            if success {
                dispatch_async(dispatch_get_main_queue(), {
                    var alert = UIAlertController(title: "Information", message: "BMI saved", preferredStyle: UIAlertControllerStyle.Alert);
                    self.presentViewController(alert, animated: true, completion: nil);
                    alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.Default, handler: nil));
                    NSLog("BMI was saved OK");
                })
            }else{
                NSLog("Failed to save BMI. Error: \(error)");
            }
        })
        
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated);
        
        //Check we are able to access healthkit
        if(!HKHealthStore.isHealthDataAvailable()){
            dispatch_async(dispatch_get_main_queue(), {
                var alert = UIAlertController(title: "Alert", message: "Healthkit is not supported on this device", preferredStyle: UIAlertControllerStyle.Alert);
                self.presentViewController(alert, animated: true, completion: nil);
                alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.Default, handler: nil));
                NSLog("Temp was saved OK");
                NSLog("Healthkit is not supported on this device");
            })
            return;
        }
        
        self.healthStore = HKHealthStore();
        
        let dataTypesToWrite = [
            HKQuantityType.quantityTypeForIdentifier(HKQuantityTypeIdentifierHeight),
            HKQuantityType.quantityTypeForIdentifier(HKQuantityTypeIdentifierBodyMass),
            HKQuantityType.quantityTypeForIdentifier(HKQuantityTypeIdentifierBodyMassIndex)
        ]
        let dataTypesToRead = [
            HKQuantityType.quantityTypeForIdentifier(HKQuantityTypeIdentifierBodyMass),
            HKQuantityType.quantityTypeForIdentifier(HKQuantityTypeIdentifierHeight),
            HKQuantityType.quantityTypeForIdentifier(HKQuantityTypeIdentifierBodyMassIndex)
        ]
        
        self.healthStore?.requestAuthorizationToShareTypes(NSSet(array: dataTypesToWrite), readTypes: NSSet(array: dataTypesToRead), completion: {
            (success, error) in
            if success {
                NSLog("User completed authorisation request");
                dispatch_async(dispatch_get_main_queue(), {
                    //Call to write information
                    //self.writeBodyTemperature();
                    //self.writeBMI();
                    NSLog("Ready to go!");
                })
            }else{
                dispatch_async(dispatch_get_main_queue(), {
                    var alert = UIAlertController(title: "Alert", message: "You cancelled the authorisation request", preferredStyle: UIAlertControllerStyle.Alert);
                    self.presentViewController(alert, animated: true, completion: nil);
                    alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.Default, handler: nil));
                        NSLog("The user cancelled the authorisation request \(error)");
                    
                })
            }
        })
    }

}

