//
//  ViewController.swift
//  User Preference
//
//  Created by Jason Ash on 10/8/14.
//  Copyright (c) 2014 JayWade. All rights reserved.
//

import UIKit

enum SegmentColorEnum : UInt {
	case red = 0, orange, yellow
}

class ViewController: UIViewController {
	
	var person = Person(defaults: NSUserDefaults.standardUserDefaults())
	let notificationCenter = NSNotificationCenter.defaultCenter()
	let colorDictionary : [String : SegmentColorEnum] = ["red" : .red, "orange" : .orange, "yellow" : .yellow]

	@IBOutlet weak var nameText: UITextField!
	@IBOutlet weak var numberTextField: UITextField!
	@IBOutlet weak var stepper: UIStepper!
	@IBOutlet weak var viewSwitch: UISwitch!
	@IBOutlet weak var segmentedControl: UISegmentedControl!
	@IBOutlet weak var progressView: UIProgressView!
	@IBOutlet weak var circleView: CircleView!
	
	@IBAction func doneEditing(sender: AnyObject) {
		sender.resignFirstResponder()
	}

	
	@IBAction func segmentChanged(sender: UISegmentedControl) {
		let segmentColorSelection = SegmentColorEnum(rawValue: UInt(sender.selectedSegmentIndex))
		
		if let segmentColor = segmentColorSelection {
			for (key, value) in colorDictionary {
				if value == segmentColorSelection {
					circleView.colorName = key
					setColorKey(Int(colorDictionary[circleView.colorName]!.rawValue))
					circleView.setNeedsDisplay()
					break
				}
			}
		}
	}
	
	
	@IBAction func stepperChanged(sender: UIStepper) {
		circleView.radius = Int(stepper.value) * 10
		circleView.setNeedsDisplay()
	}
	
	
	@IBAction func switchChanged(sender: UISwitch) {
		circleView.hidden = !sender.on
		person.switchBool = circleView.hidden
	}
	
	override func viewDidLoad() {
		super.viewDidLoad()
		// Do any additional setup after loading the view, typically from a nib.
		let app = UIApplication.sharedApplication()
		notificationCenter.addObserver(self, selector: "applicationWillEnterForeground:", name: UIApplicationWillEnterForegroundNotification, object: app)
		notificationCenter.addObserver(self, selector: "applicationWillResignActive:", name: UIApplicationWillResignActiveNotification, object: app)
		notificationCenter.addObserver(self, selector: "applicationWillTerminate:", name: UIApplicationWillTerminateNotification, object: app)
		notificationCenter.addObserver(self, selector: "colorSetAlert:", name: "colorSetNotification", object: nil)
		
		person.loadDataFromUserDefaults()
		displayModelData()
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
         changeObjectsColor(UIColor.redColor())
			break
		case 1:
         changeObjectsColor(UIColor.orangeColor())
			break
		case 2:
         changeObjectsColor(UIColor.yellowColor())
			break
		default:
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
      nameText.textColor = color
      numberTextField.textColor = color
   }

	func displayModelData() {
		nameText.text = person.nameString
		numberTextField.text = "\(person.numberFloat)"
		stepper.value = Double(person.stepperInteger)
		viewSwitch.on = person.switchBool
		circleView.colorName = person.segmentString
		circleView.radius = Int(stepper.value)*10
		circleView.setNeedsDisplay()
		segmentedControl.selectedSegmentIndex = Int(colorDictionary[circleView.colorName]!.rawValue)
	}
	
	func updateModelData() {
		person.nameString = nameText.text
		person.numberFloat = (numberTextField.text as NSString).floatValue
		person.stepperInteger = Int(stepper.stepValue)
		person.switchBool = viewSwitch.on
		person.segmentString = circleView.colorName
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

