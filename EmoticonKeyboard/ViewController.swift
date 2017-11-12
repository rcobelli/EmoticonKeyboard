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
		NSLocalizedString("Settings", comment: ""),
		NSLocalizedString("General", comment: ""),
		NSLocalizedString("Keyboard", comment: ""),
		NSLocalizedString("Keyboards", comment: ""),
		NSLocalizedString("Add New Keyboard...", comment: ""),
		NSLocalizedString("Emoticon Keyboard", comment: "")
	]
	
	override func viewDidLoad() {
		super.viewDidLoad()
		
		tableView.register(UITableViewCell.self, forCellReuseIdentifier:"cell")
		tableView.separatorColor = UIColor.black
		tableView.separatorInset = UIEdgeInsets.zero
		tableView.tableFooterView = UIView(frame: CGRect.zero)
	}

	// MARK: - Table view data source
	
	func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
		return "To enable the keyboard:"
	}
	
	func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
		
		let returnedView = UIView(frame: CGRect(x: 0, y: 0, width: self.view.frame.width, height: 30)) //set these values as necessary
		returnedView.backgroundColor = UIColor.darkGray
		
		let label = UILabel(frame: CGRect(x: 15, y: 2.5, width: self.view.frame.width, height: 20))
		label.text = "To enable the keyboard:"
		label.textColor = UIColor.white
		returnedView.addSubview(label)
		
		return returnedView
	}
	
	func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		return emoticons.count
	}
	
	func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		let cell : UITableViewCell = tableView.dequeueReusableCell(withIdentifier: "cell")! as UITableViewCell
		cell.textLabel?.text = emoticons[indexPath.row]
		cell.textLabel?.textColor = UIColor.black
		cell.selectionStyle = .none
		if indexPath.row == 0 {
			cell.textLabel?.font = UIFont.boldSystemFont(ofSize: 16.0)
			cell.textLabel?.textColor = UIColor.blue
			cell.accessoryType = .disclosureIndicator
			cell.selectionStyle = .blue
		}
		cell.backgroundColor = UIColor(red: 1.000, green: 1.000, blue: 1.000, alpha: 1.00)
		cell.layoutMargins = UIEdgeInsets.zero
		cell.preservesSuperviewLayoutMargins = false
		
		let backgroundView = UIView()
		backgroundView.backgroundColor = UIColor(red: 0.722, green: 0.663, blue: 0.533, alpha: 1.00)
		cell.selectedBackgroundView = backgroundView
		
		return cell
	}
	
	func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
		tableView.deselectRow(at: indexPath, animated: true)
		self.view.endEditing(true)
		if indexPath.row == 0 {
			UIApplication.shared.openURL(URL(string: UIApplicationOpenSettingsURLString)!)
		}
	}
}
