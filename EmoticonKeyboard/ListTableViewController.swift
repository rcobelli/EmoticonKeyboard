//
//  ListTableViewController.swift
//  EmoticonKeyboard
//
//  Created by Ryan Cobelli on 1/4/16.
//  Copyright © 2016 Rybel LLC. All rights reserved.
//

import UIKit

class ListTableViewController: UITableViewController {
	
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
		"(・▽・)/♫•*¨*•.¸¸♪",
		"(￣^￣)ゞ",
		"(　･ω･)☞",
		"╭∩╮(Ο_Ο)╭∩╮",
		"🖕",
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

    override func viewDidLoad() {
        super.viewDidLoad()

		tableView.registerClass(UITableViewCell.self, forCellReuseIdentifier:"cell")
		tableView.separatorColor = UIColor.blackColor()
		tableView.tableFooterView = UIView(frame: CGRectZero)
		tableView.contentInset = UIEdgeInsetsMake(20.0, 0.0, 49.0, 0.0)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

	override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		return emoticons.count
	}
	
	override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
		let cell : UITableViewCell = tableView.dequeueReusableCellWithIdentifier("cell")! as UITableViewCell
		cell.textLabel?.text = emoticons[indexPath.row]
		cell.textLabel?.textColor = UIColor.blackColor()
		cell.backgroundColor = UIColor(red: 1.000, green: 1.000, blue: 1.000, alpha: 1.00)
		cell.layoutMargins = UIEdgeInsetsZero
		cell.preservesSuperviewLayoutMargins = false
		let backgroundView = UIView()
		backgroundView.backgroundColor = UIColor(red: 0.722, green: 0.663, blue: 0.533, alpha: 1.00)
		cell.selectedBackgroundView = backgroundView
		return cell
	}
	
	override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
		tableView.deselectRowAtIndexPath(indexPath, animated: true)
	}

}
