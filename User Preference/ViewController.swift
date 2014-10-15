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
	@IBOutlet weak var progressView: UIProgressView!
	
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
		notificationCenter.addObserver(self, selector: "colorSetAlert:", name: "colorSetNotification", object: nil)
        
      segmentedControl.addTarget(self, action: "setColorKey:", forControlEvents: .ValueChanged)
		
		person.loadDataFromUserDefaults()
	}
	
	override func viewDidAppear(animated: Bool) {
		displayModelData()
		setColorKey(0)
	}

	override func didReceiveMemoryWarning() {
		super.didReceiveMemoryWarning()
		// Dispose of any resources that can be recreated.
	}
	
	func colorSetAlert(notification:NSNotification) {
		let actionSheetController: UIAlertController = UIAlertController(title: "Color Set", message: "Color has been set as \(person.segmentString)", preferredStyle: .Alert)
		let ok = UIAlertAction(title: "OK", style: .Default, handler: { (action) -> Void in })
		actionSheetController.addAction(ok)
		presentViewController(actionSheetController, animated: true, completion: nil)
	}
    
	func setColorKey(value : Int) {
		progressView.setProgress(100, animated: false)
		switch (segmentedControl.selectedSegmentIndex) {
		case 0:
			person.segmentString = "red"
         changeObjectsColor(UIColor.redColor())
			break
		case 1:
			person.segmentString = "orange"
         changeObjectsColor(UIColor.orangeColor())
			break
		case 2:
			person.segmentString = "yellow"
         changeObjectsColor(UIColor.yellowColor())
			break
		default:
			person.segmentString = "red"
         changeObjectsColor(UIColor.redColor())
			break
		}
		if (value != 0) {
			notificationCenter.postNotificationName("colorSetNotification", object : nil)
		}
    }
   
   func changeObjectsColor(color : UIColor) {
      segmentedControl.tintColor = color
      progressView.progressTintColor = color
      stepper.tintColor = color
      viewSwitch.tintColor = color
      viewSwitch.onTintColor = color
   }

	func displayModelData() {
		nameText.text = person.nameString
		numberTextField.text = "\(person.numberFloat)"
		stepper.value = Double(person.stepperInteger)
		viewSwitch.on = person.switchBool
      if (person.segmentString != nil) {
        switch (person.segmentString) {
            case "red":
                segmentedControl.selectedSegmentIndex = 0
                break
            case "orange":
                segmentedControl.selectedSegmentIndex = 1
                break
            case "yellow":
                segmentedControl.selectedSegmentIndex = 2
                break
        default:
            segmentedControl.selectedSegmentIndex = 0
        }
      }
	}
	
	func updateModelData() {
		person.nameString = nameText.text
		person.numberFloat = (numberTextField.text as NSString).floatValue
		person.stepperInteger = Int(stepper.stepValue)
		person.switchBool = viewSwitch.on
		setColorKey(1)
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

