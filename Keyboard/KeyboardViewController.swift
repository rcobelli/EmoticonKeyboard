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
    @IBOutlet var spaceOutlet: UIButton!
    
    var timer: Timer!
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
    var textColor = UIColor.black
    
    override func updateViewConstraints() {
        super.updateViewConstraints()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // load the nib file
        let calculatorNib = UINib(nibName: "Keyboard", bundle: nil)
        // instantiate the view
        self.view = calculatorNib.instantiate(withOwner: self, options: nil)[0] as! UIView
        
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(UITableViewCell.self, forCellReuseIdentifier:"cell")
        tableView.separatorColor = UIColor(red: 0.435, green: 0.443, blue: 0.443, alpha: 1.00)
        tableView.tableFooterView = UIView(frame: CGRect.zero)
        tableView.separatorInset = UIEdgeInsets.zero

        nextKeyboardButton.addTarget(self, action: #selector(UIInputViewController.advanceToNextInputMode), for: .touchUpInside)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        if (self.textDocumentProxy.keyboardAppearance == UIKeyboardAppearance.dark) {
            color = UIColor(red: 0.192, green: 0.196, blue: 0.208, alpha: 1.00)
            textColor = UIColor.white
			view.backgroundColor = color
			backSpaceOutlet.setImage(UIImage(named: "backspace_white.png"), for: .normal)
			spaceOutlet.setImage(UIImage(named: "space_white.png"), for: .normal)
			nextKeyboardButton.setImage(UIImage(named: "keyboard_white.png"), for: .normal)
        }
        else {
			textColor = UIColor.black
			view.backgroundColor = UIColor.white
			backSpaceOutlet.setImage(UIImage(named: "backspace.png"), for: .normal)
			spaceOutlet.setImage(UIImage(named: "space.png"), for: .normal)
			nextKeyboardButton.setImage(UIImage(named: "keyboard.png"), for: .normal)
        }
        tableView.reloadData()
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return emoticons.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell : UITableViewCell = tableView.dequeueReusableCell(withIdentifier: "cell")! as UITableViewCell
        cell.textLabel?.text = emoticons[indexPath.row]
        cell.textLabel?.textColor = textColor
        cell.backgroundColor = color
        cell.layoutMargins = UIEdgeInsets.zero
        cell.preservesSuperviewLayoutMargins = false
        let backgroundView = UIView()
        backgroundView.backgroundColor = UIColor(red: 0.722, green: 0.663, blue: 0.533, alpha: 1.00)
        cell.selectedBackgroundView = backgroundView

        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if tableView.cellForRow(at: indexPath)?.textLabel?.text == "🖕" {
            self.textDocumentProxy.insertText("                      /´¯/)\n                    ,/¯  /\n                   /    /\n             /´¯/'   '/´¯¯`·¸\n          /'/   /    /       /¨¯\\\n        ('(   ´   ´     ¯~/'   ')\n         \\                 '     /\n          \\               _ ·´\n            \\              (\n              \\             \\   ")
        }
        else {
            self.textDocumentProxy.insertText(emoticons[indexPath.row])
        }
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    override func textWillChange(_ textInput: UITextInput?) {}
    
    override func textDidChange(_ textInput: UITextInput?) {
        var textColor: UIColor
        let proxy = self.textDocumentProxy
        if proxy.keyboardAppearance == UIKeyboardAppearance.dark {
            textColor = UIColor.white
        } else {
            textColor = UIColor.black
        }
        self.nextKeyboardButton.setTitleColor(textColor, for: UIControlState())
    }
    
    func isOpenAccessGranted() -> Bool {
        return UIPasteboard.general.isKind(of: UIPasteboard.self)
    }
    
    @objc func backspace(_ sender: AnyObject) {
        self.textDocumentProxy.deleteBackward()
    }
    
    @IBAction func space(_ sender: AnyObject) {
        self.textDocumentProxy.insertText(" ")
    }
    
    @IBAction func buttonDown(_ sender: AnyObject) {
        backspace(self)
        timer = Timer.scheduledTimer(timeInterval: 0.2, target: self, selector: #selector(KeyboardViewController.backspace(_:)), userInfo: nil, repeats: true)
    }
    
    @IBAction func buttonUp(_ sender: AnyObject) {
        timer.invalidate()
    }

}
