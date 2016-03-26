//
//  ContactButton.swift
//  EmoticonKeyboard
//
//  Created by Ryan Cobelli on 3/5/16.
//  Copyright © 2016 Rybel LLC. All rights reserved.
//

import UIKit
import QuartzCore

class ContactButton: UIButton {
	
	override init(frame: CGRect) {
		super.init(frame: frame)
	}
	
	required init?(coder aDecoder: NSCoder) {
		super.init(coder: aDecoder)
	}
	
	override func layoutSubviews() {
		super.layoutSubviews()
		
		layer.cornerRadius = 15
		clipsToBounds = true
		titleLabel?.adjustsFontSizeToFitWidth = true
	}

//	override func drawRect(rect: CGRect) {
//		self.layer.cornerRadius = 15
//		self.
//	}
}
