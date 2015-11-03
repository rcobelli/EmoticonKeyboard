//
//  KeyboardViewController.swift
//  Keyboard
//
//  Created by Ryan Cobelli on 11/2/15.
//  Copyright © 2015 Rybel LLC. All rights reserved.
//

import UIKit

class KeyboardViewController: UIInputViewController, UITableViewDelegate, UITableViewDataSource {
	
	@IBOutlet var nextKeyboardButton: UIButton!
	
	@IBOutlet var tableView: UITableView! = UITableView()
	
	var emoticons: [String] = [
		"¯\\_(ツ)_/¯",
		"(งಠ_ಠ)ง",
		"(╯°益°)╯彡┻━┻",
		"( ͡° ͜ʖ ͡°)",
		"(͡° ͜ʖ ͡°)",
		"╭∩╮(Ο_Ο)╭∩╮",
		"ಠ_ಠ",
		"＼(◎o◎)／",
		"(◠‿◠)",
		"(◕‿◕)",
		"＼(＾▽＾)／",
		"(ノ*ﾟ▽ﾟ*)",
		"(￢_￢)",
		"(¬‿¬ )",
		"(⊙_⊙)",
		"(・▽・)ノ",
		"( -‿・)",
		"(・▽・)/♫•*¨*•.¸¸♪",
		"(￣^￣)ゞ",
		"(　･ω･)☞",
		"▄︻̷̿┻̿═━一",
		"༼ つ ◕_◕ ༽つ",
		"(づ￣ ³￣)づ",
		"[̲̅$̲̅(̲̅5̲̅)̲̅$̲̅]",
		"ʕ•ᴥ•ʔ",
		"(▀̿Ĺ̯▀̿ ̿)",
		"(ಥ﹏ಥ)",
		"(☞ﾟヮﾟ)☞ ☜(ﾟヮﾟ☜)",
		"┬┴┬┴┤(･_├┬┴┬┴",
		"ᕙ(⇀‸↼‶)ᕗ",
		"ヽ(⌐■_■)ノ♪♬"
	]
	
	override func updateViewConstraints() {
		super.updateViewConstraints()
	}
	
	override func viewDidLoad() {
		super.viewDidLoad()
		
		// load the nib file
		let calculatorNib = UINib(nibName: "Keyboard", bundle: nil)
		// instantiate the view
		self.view = calculatorNib.instantiateWithOwner(self, options: nil)[0] as! UIView
		
		tableView.delegate = self
		tableView.dataSource = self
		tableView.registerClass(UITableViewCell.self, forCellReuseIdentifier:"cell")
		tableView.separatorColor = UIColor(red: 0.435, green: 0.443, blue: 0.443, alpha: 1.00)
		tableView.tableFooterView = UIView(frame: CGRectZero)
		tableView.separatorInset = UIEdgeInsetsZero

		nextKeyboardButton.addTarget(self, action: "advanceToNextInputMode", forControlEvents: .TouchUpInside)
	}

	
	func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		return emoticons.count
	}
	
	func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
		let cell : UITableViewCell = tableView.dequeueReusableCellWithIdentifier("cell")! as UITableViewCell
		cell.textLabel?.text = emoticons[indexPath.row]
		cell.backgroundColor = UIColor(red: 0.647, green: 0.894, blue: 0.953, alpha: 1.00)
		cell.layoutMargins = UIEdgeInsetsZero
		cell.preservesSuperviewLayoutMargins = false
		let backgroundView = UIView()
		backgroundView.backgroundColor = UIColor(red: 0.306, green: 0.416, blue: 0.439, alpha: 1.00)
		cell.selectedBackgroundView = backgroundView
		return cell
	}
	
	func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
		self.textDocumentProxy.insertText(emoticons[indexPath.row])
		tableView.deselectRowAtIndexPath(indexPath, animated: true)
	}
	
	override func textWillChange(textInput: UITextInput?) {
		// The app is about to change the document's contents. Perform any preparation here.
	}
	
	override func textDidChange(textInput: UITextInput?) {
		// The app has just changed the document's contents, the document context has been updated.
		
		var textColor: UIColor
		let proxy = self.textDocumentProxy
		if proxy.keyboardAppearance == UIKeyboardAppearance.Dark {
			textColor = UIColor.whiteColor()
		} else {
			textColor = UIColor.blackColor()
		}
		self.nextKeyboardButton.setTitleColor(textColor, forState: .Normal)
	}
	
	@IBAction func backspace(sender: AnyObject) {
		self.textDocumentProxy.deleteBackward()
	}


}
