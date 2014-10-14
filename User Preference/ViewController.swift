//
//  ViewController.swift
//  User Preference
//
//  Created by Jason Ash on 10/8/14.
//  Copyright (c) 2014 JayWade. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
	
	var person = Person(defaults: NSUserDefaults.standardUserDefaults())
	let notificationCenter = NSNotificationCenter.defaultCenter()

	@IBOutlet weak var nameText: UITextField!
	@IBOutlet weak var numberTextField: UITextField!
	@IBOutlet weak var stepper: UIStepper!
	@IBOutlet weak var viewSwitch: UISwitch!
	@IBOutlet weak var segmentedControl: UISegmentedControl!
	
	@IBAction func doneEditing(sender: AnyObject) {
		sender.resignFirstResponder()
	}

	override func viewDidLoad() {
		super.viewDidLoad()
		// Do any additional setup after loading the view, typically from a nib.
		let app = UIApplication.sharedApplication()
		notificationCenter.addObserver(self, selector: "applicationWillEnterForeground:", name: UIApplicationWillEnterForegroundNotification, object: app)
		notificationCenter.addObserver(self, selector: "applicationWillResignActive:", name: UIApplicationWillResignActiveNotification, object: app)
		notificationCenter.addObserver(self, selector: "applicationWillTerminate:", name: UIApplicationWillTerminateNotification, object: app)
        
        segmentedControl.addTarget(self, action: "setColorKey:", forControlEvents: .ValueChanged)
		
		person.loadDataFromUserDefaults()
		
		displayModelData()
	}

	override func didReceiveMemoryWarning() {
		super.didReceiveMemoryWarning()
		// Dispose of any resources that can be recreated.
	}
    
    func setColorKey() {
        person.segmentKeyString = segmentedControl.selectedSegmentIndex.description
    }
	
//	let personObject: AnyObject = pListArray.objectAtIndex(0).objectAtIndex(0) 
	//	var pListPerson = Person(firstName: personObject["firstName"] as String, lastName: personObject["lastName"] as String)

	func displayModelData() {
		nameText.text = person.nameString
		numberTextField.text = "\(person.numberFloat)"
		stepper.value = Double(person.stepperInteger)
		viewSwitch.on = person.switchBool
//        switch (person.segmentKeyString) {
//            case "red":
//                segmentedControl.selectedSegmentIndex = 0
//                break
//            case "orange":
//                segmentedControl.selectedSegmentIndex = 1
//                break
//            case "yellow":
//                segmentedControl.selectedSegmentIndex = 2
//                break
//        default:
//            segmentedControl.selectedSegmentIndex = 0
//        }
	}
	
	func updateModelData() {
		person.nameString = nameText.text
		person.numberFloat = (numberTextField.text as NSString).floatValue
		person.stepperInteger = Int(stepper.stepValue)
		person.switchBool = viewSwitch.on
		person.segmentKeyString = segmentedControl.titleForSegmentAtIndex(segmentedControl.selectedSegmentIndex)
	}
	
	func applicationWillEnterForeground(notification : NSNotification) {
		person.userDefaults.synchronize()
		person.loadDataFromUserDefaults()
		displayModelData()
	}
	
	func applicationWillResignActive(notification : NSNotification) {
		updateModelData()
		person.saveDataToUserDefaults()
		person.userDefaults.synchronize()
	}
	
	func applicationWillTerminate(notification : NSNotification) {
		notificationCenter.removeObserver(self)
	}
}

