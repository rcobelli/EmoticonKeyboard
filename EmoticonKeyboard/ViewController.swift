//
//  ViewController.swift
//  EmoticonKeyboard
//
//  Created by Ryan Cobelli on 11/2/15.
//  Copyright © 2015 Rybel LLC. All rights reserved.
//

import UIKit
import MessageUI

class ViewController: UIViewController, MFMailComposeViewControllerDelegate {
	
	@IBOutlet weak var label: UILabel!
	@IBOutlet weak var buttonOne: UIButton!
	@IBOutlet weak var buttonTwo: UIButton!
	@IBOutlet weak var buttonThree: UIButton!
	@IBOutlet weak var buttonFour: UIButton!
	@IBOutlet weak var buttonFive: UIButton!
	@IBOutlet weak var buttonSix: UIButton!
	@IBOutlet weak var backgroundImage: UIImageView!
	@IBOutlet weak var anotherButton: UIButton!

	override func viewDidLoad() {
		super.viewDidLoad()
		label.iOS6ParallaxIntensity = 10
		buttonOne.iOS6ParallaxIntensity = 10
		buttonTwo.iOS6ParallaxIntensity = 10
		buttonThree.iOS6ParallaxIntensity = 10
		buttonFour.iOS6ParallaxIntensity = 10
		buttonFive.iOS6ParallaxIntensity = 10
		buttonSix.iOS6ParallaxIntensity = 10
		anotherButton.iOS6ParallaxIntensity = 10
		UINavigationBar.appearance().tintColor = UIColor(red: 0.435, green: 0.443, blue: 0.443, alpha: 1.00)
	}

	override func didReceiveMemoryWarning() {
		super.didReceiveMemoryWarning()
		// Dispose of any resources that can be recreated.
	}

	@IBAction func openSettings(sender: AnyObject) {
		UIApplication.sharedApplication().openURL(NSURL(string: UIApplicationOpenSettingsURLString)!)
	}
	
	@IBAction func openMail(sender: AnyObject) {
		if MFMailComposeViewController.canSendMail() {
			let picker = MFMailComposeViewController()
			picker.mailComposeDelegate = self
			picker.setSubject("Emoticon Keyboard: Emoticon Submission")
			presentViewController(picker, animated: true, completion: nil)
		}
	}

	func mailComposeController(controller: MFMailComposeViewController, didFinishWithResult result: MFMailComposeResult, error: NSError?) {
		dismissViewControllerAnimated(true, completion: nil)
	}
	
}