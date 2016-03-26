//
//  KeyboardViewController.swift
//  Keyboard
//
//  Created by Ryan Cobelli on 11/2/15.
//  Copyright © 2015 Rybel LLC. All rights reserved.
//

import UIKit

class KeyboardViewController: UIInputViewController, UITableViewDelegate, UITableViewDataSource, UIGestureRecognizerDelegate {
	
	@IBOutlet var nextKeyboardButton: UIButton!
	@IBOutlet var tableView: UITableView! = UITableView()
	@IBOutlet var backSpaceOutlet: UIButton!
	
	var timer: NSTimer!
	var popupView = UIView()
	
	var emoticons: [String] = [
		"¯\\_(ツ)_/¯",
		"(งಠ_ಠ)ง",
		"(╯°益°)╯彡┻━┻",
		"(ヘ＿　＿)ヘ",
		"[ ± _ ± ]",
		"( ͡° ͜ʖ ͡°)",
		"(͡° ͜ʖ ͡°)",
		"ಠ_ಠ",
		"٩(͡๏̯͡๏)۶",
		"(⊙_☉)",
		"(っ- ‸ – ς)",
		"(∪｡∪)｡｡｡zzz",
		"＼(◎o◎)／",
		"┗(°0°)┛",
		"(-_ゞ",
		"(◑́_◑᷅ )",
		"u_u",
		"(◕‿◕)",
		"＼(＾▽＾)／",
		"(ノ*ﾟ▽ﾟ*)",
		"(￢_￢)",
		"(¬‿¬ )",
		"(⊙_⊙)",
		"╭∩╮(Ο_Ο)╭∩╮",
		"🖕",
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
		"ᕙ( ︡'︡益'︠)ง",
		"ᕙ(⇀‸↼‶)ᕗ",
		"ヽ(⌐▀̿_▀̿)ノ♪♬"
	]
	
	var color = UIColor(red: 1.000, green: 1.000, blue: 1.000, alpha: 1.00)
	var textColor = UIColor.blackColor()
	
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

		nextKeyboardButton.addTarget(self, action: #selector(UIInputViewController.advanceToNextInputMode), forControlEvents: .TouchUpInside)
	}
	
	override func viewWillAppear(animated: Bool) {
		if (self.textDocumentProxy.keyboardAppearance == UIKeyboardAppearance.Dark) {
			color = UIColor(red: 0.192, green: 0.196, blue: 0.208, alpha: 1.00)
			textColor = UIColor.whiteColor()
			backSpaceOutlet.titleLabel?.textColor = UIColor.whiteColor()
		}
		else {
			backSpaceOutlet.titleLabel?.textColor = UIColor.blackColor()
		}
		tableView.reloadData()
	}

	func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		return emoticons.count
	}
	
	func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
		let cell : UITableViewCell = tableView.dequeueReusableCellWithIdentifier("cell")! as UITableViewCell
		cell.textLabel?.text = emoticons[indexPath.row]
		cell.textLabel?.textColor = textColor
		cell.backgroundColor = color
		cell.layoutMargins = UIEdgeInsetsZero
		cell.preservesSuperviewLayoutMargins = false
		let backgroundView = UIView()
		backgroundView.backgroundColor = UIColor(red: 0.722, green: 0.663, blue: 0.533, alpha: 1.00)
		cell.selectedBackgroundView = backgroundView
		
		// Add long press gesure recognizer for copying contents
		let lpgr = UILongPressGestureRecognizer(target: self, action: #selector(KeyboardViewController.handleLongPress(_:)))
		lpgr.minimumPressDuration = 1.5
		lpgr.delegate = self
		cell.addGestureRecognizer(lpgr)

		return cell
	}
	
	func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
		if tableView.cellForRowAtIndexPath(indexPath)?.textLabel?.text == "🖕" {
			self.textDocumentProxy.insertText("                      /´¯/)\n                    ,/¯  /\n                   /    /\n             /´¯/'   '/´¯¯`·¸\n          /'/   /    /       /¨¯\\\n        ('(   ´   ´     ¯~/'   ')\n         \\                 '     /\n          \\               _ ·´\n            \\              (\n              \\             \\   ")
		}
		else {
			self.textDocumentProxy.insertText(emoticons[indexPath.row])
		}
		tableView.deselectRowAtIndexPath(indexPath, animated: true)
	}
	
	// Copy cell contents to clipboard
	func handleLongPress(gestureReconizer: UILongPressGestureRecognizer) {
		if gestureReconizer.state != UIGestureRecognizerState.Ended {
			return
		}
		
		if (!isOpenAccessGranted()) {
			return
		}
		
		let p = gestureReconizer.locationInView(self.tableView)
		let indexPath = self.tableView.indexPathForRowAtPoint(p)
		
		if let _ = indexPath {
			if emoticons[(indexPath?.row)!] == "🖕" {
				UIPasteboard.generalPasteboard().string = "                      /´¯/)\n                    ,/¯  /\n                   /    /\n             /´¯/'   '/´¯¯`·¸\n          /'/   /    /       /¨¯\\\n        ('(   ´   ´     ¯~/'   ')\n         \\                 '     /\n          \\               _ ·´\n            \\              (\n              \\             \\   "
			}
			else {
				UIPasteboard.generalPasteboard().string = emoticons[(indexPath?.row)!]
			}
			createPopup()
		}
		else {
			print("Could not find index path")
		}
	}
	
	// Create popup with check mark over copy icon
	func createPopup() {
		popupView = UIView(frame: CGRectMake(self.view.frame.size.width/2-50, self.view.frame.size.height/2-50, 100, 100))
		popupView.backgroundColor = UIColor(white: 0.8, alpha: 0.8)
		popupView.layer.cornerRadius = 25
		popupView.layer.borderWidth = 2
		popupView.alpha = 0
		
		let backgroundImage = UIImageView(frame: CGRectMake(12.5, 12.5, 75, 75))
		backgroundImage.image = UIImage(named: "checkmark")
		backgroundImage.tintColor = UIColor.greenColor()
		popupView.addSubview(backgroundImage)
		self.view.addSubview(popupView)
		
		UIView.animateWithDuration(0.5, delay: 0.0, options: .CurveEaseInOut, animations: {
			self.popupView.alpha = 1
			}, completion: { _ in
				self.removePopup()
			})
	}
	
	func removePopup() {
		UIView.animateWithDuration(0.5, delay: 2.0, options: .CurveEaseInOut, animations: {
			self.popupView.alpha = 0
		}, completion: nil)
	}
	
	override func textWillChange(textInput: UITextInput?) {}
	
	override func textDidChange(textInput: UITextInput?) {
		var textColor: UIColor
		let proxy = self.textDocumentProxy
		if proxy.keyboardAppearance == UIKeyboardAppearance.Dark {
			textColor = UIColor.whiteColor()
		} else {
			textColor = UIColor.blackColor()
		}
		self.nextKeyboardButton.setTitleColor(textColor, forState: .Normal)
	}
	
	func isOpenAccessGranted() -> Bool {
		return UIPasteboard.generalPasteboard().isKindOfClass(UIPasteboard)
	}
	
	func backspace(sender: AnyObject) {
		self.textDocumentProxy.deleteBackward()
	}
	
	@IBAction func buttonDown(sender: AnyObject) {
		backspace(self)
		timer = NSTimer.scheduledTimerWithTimeInterval(0.2, target: self, selector: #selector(KeyboardViewController.backspace(_:)), userInfo: nil, repeats: true)
	}
	
	@IBAction func buttonUp(sender: AnyObject) {
		timer.invalidate()
	}

}
