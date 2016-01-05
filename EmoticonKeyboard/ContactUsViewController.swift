//
//  ContactUsViewController.swift
//  EmoticonKeyboard
//
//  Created by Ryan Cobelli on 1/4/16.
//  Copyright © 2016 Rybel LLC. All rights reserved.
//

import UIKit
import MessageUI

class ContactUsViewController: UIViewController, MFMailComposeViewControllerDelegate {

	@IBOutlet weak var supportSite: UIButton!
	@IBOutlet weak var emailOutlet: UIButton!
	
	
    override func viewDidLoad() {
        super.viewDidLoad()
		
		supportSite.layer.cornerRadius = 5
		supportSite.titleLabel?.adjustsFontSizeToFitWidth = true
		emailOutlet.layer.cornerRadius = 5
		emailOutlet.titleLabel?.adjustsFontSizeToFitWidth = true
	}

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
	@IBAction func visitSite(sender: AnyObject) {
		UIApplication.sharedApplication().openURL(NSURL(string: "http://support.rybel-llc.com")!)
	}

	@IBAction func emailUs(sender: AnyObject) {
		if MFMailComposeViewController.canSendMail() {
			let picker = MFMailComposeViewController()
			picker.mailComposeDelegate = self
			picker.setSubject(NSLocalizedString("Emoticon Keyboard: Emoticon Submission", comment: ""))
			presentViewController(picker, animated: true, completion: nil)
		}
	}
	
	func mailComposeController(controller: MFMailComposeViewController, didFinishWithResult result: MFMailComposeResult, error: NSError?) {
		dismissViewControllerAnimated(true, completion: nil)
	}

}
