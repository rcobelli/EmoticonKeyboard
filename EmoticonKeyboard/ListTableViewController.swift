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
		
		tableView.separatorColor = UIColor.black
		tableView.separatorInset = UIEdgeInsets.zero
    }

    // MARK: - Table view data source

	override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		return emoticons.count
	}
	
	override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		let cell : UITableViewCell = tableView.dequeueReusableCell(withIdentifier: "cell")! as UITableViewCell
		cell.textLabel?.text = emoticons[indexPath.row]
		cell.textLabel?.textColor = UIColor.black
		cell.backgroundColor = UIColor(red: 1.000, green: 1.000, blue: 1.000, alpha: 1.00)
		cell.layoutMargins = UIEdgeInsets.zero
		cell.preservesSuperviewLayoutMargins = false
		let backgroundView = UIView()
		backgroundView.backgroundColor = UIColor(red: 0.722, green: 0.663, blue: 0.533, alpha: 1.00)
		cell.selectedBackgroundView = backgroundView
		return cell
	}
	
	override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
		DispatchQueue.global(qos: .background).async {
			let pasteboard = UIPasteboard.general
			pasteboard.string = tableView.cellForRow(at: indexPath)?.textLabel?.text
		}
		
		tableView.deselectRow(at: indexPath, animated: true)
	}

}
