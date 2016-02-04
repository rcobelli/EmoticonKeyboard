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
		"ᗧʻ̑ ˙̫ ʻ̑ᗤ⍝",
		"(◠‿◠)",
		"( •́ X •̀)",
		"┗(°0°)┛",
		"(-_ゞ",
		"u_u",
		"(◕‿◕)",
		"＼(＾▽＾)／",
		"(ノ*ﾟ▽ﾟ*)",
		"(￢_￢)",
		"(¬‿¬ )",
		"(⊙_⊙)",
		"⁀⊙﹏☉⁀ ",
		"╭∩╮(Ο_Ο)╭∩╮",
		"🖕",
		"(・﹃・)",
		"(・◇・)",
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

    override func viewDidLoad() {
        super.viewDidLoad()

		tableView.registerClass(UITableViewCell.self, forCellReuseIdentifier:"cell")
		tableView.separatorColor = UIColor(red: 0.435, green: 0.443, blue: 0.443, alpha: 1.00)
		tableView.tableFooterView = UIView(frame: CGRectZero)
		tableView.separatorInset = UIEdgeInsetsZero
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
		cell.backgroundColor = UIColor(red: 0.647, green: 0.894, blue: 0.953, alpha: 1.00)
		cell.layoutMargins = UIEdgeInsetsZero
		cell.preservesSuperviewLayoutMargins = false
		let backgroundView = UIView()
		backgroundView.backgroundColor = UIColor(red: 0.306, green: 0.416, blue: 0.439, alpha: 1.00)
		cell.selectedBackgroundView = backgroundView
		return cell
	}
	
	override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
		tableView.deselectRowAtIndexPath(indexPath, animated: true)
	}

}
