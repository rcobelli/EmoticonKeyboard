//
//  ViewController.swift
//  EmoticonKeyboard
//
//  Created by Ryan Cobelli on 11/2/15.
//  Copyright © 2015 Rybel LLC. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
	
	
	@IBOutlet weak var tableView: UITableView!
	
	var emoticons: [String] = [
		NSLocalizedString("To enable the keyboard, go into:", comment: ""),
		NSLocalizedString("Settings", comment: ""),
		NSLocalizedString("Back", comment: ""),
		NSLocalizedString("General", comment: ""),
		NSLocalizedString("Keyboard", comment: ""),
		NSLocalizedString("Keyboards", comment: ""),
		NSLocalizedString("Add New Keyboard...", comment: ""),
		NSLocalizedString("Emoticon Keyboard", comment: "")
	]
	
	override func viewDidLoad() {
		super.viewDidLoad()
		
		tableView.registerClass(UITableViewCell.self, forCellReuseIdentifier:"cell")
		tableView.separatorColor = UIColor.blackColor()
		tableView.tableFooterView = UIView(frame: CGRectZero)
		UINavigationBar.appearance().tintColor = UIColor(red: 0.435, green: 0.443, blue: 0.443, alpha: 1.00)
	}
	
	override func didReceiveMemoryWarning() {
		super.didReceiveMemoryWarning()
		// Dispose of any resources that can be recreated.
	}
	
	// MARK: - Table view data source
	
	func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		return emoticons.count
	}
	
	func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
		let cell : UITableViewCell = tableView.dequeueReusableCellWithIdentifier("cell")! as UITableViewCell
		cell.textLabel?.text = emoticons[indexPath.row]
		cell.textLabel?.textColor = UIColor.blackColor()
		if indexPath.row == 1 {
			cell.textLabel?.font = UIFont.boldSystemFontOfSize(16.0)
		}
		cell.backgroundColor = UIColor(red: 1.000, green: 1.000, blue: 1.000, alpha: 1.00)
		cell.layoutMargins = UIEdgeInsetsZero
		cell.preservesSuperviewLayoutMargins = false
		let backgroundView = UIView()
		backgroundView.backgroundColor = UIColor(red: 0.722, green: 0.663, blue: 0.533, alpha: 1.00)
		cell.selectedBackgroundView = backgroundView
		return cell
	}
	
	func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
		tableView.deselectRowAtIndexPath(indexPath, animated: true)
		self.view.endEditing(true)
		if indexPath.row == 1 {
			UIApplication.sharedApplication().openURL(NSURL(string: UIApplicationOpenSettingsURLString)!)
		}
	}
}