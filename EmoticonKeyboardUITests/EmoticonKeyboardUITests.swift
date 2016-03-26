//
//  EmoticonKeyboardUITests.swift
//  EmoticonKeyboardUITests
//
//  Created by Ryan Cobelli on 11/2/15.
//  Copyright © 2015 Rybel LLC. All rights reserved.
//

import XCTest

class EmoticonKeyboardUITests: XCTestCase {
        
    override func setUp() {
        super.setUp()

		let app = XCUIApplication()
		continueAfterFailure = false
		setupSnapshot(app)
//		app.launchArguments += ["-AppleLanguages", "it"]
		app.launch()

    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
	func testDark() {
		let app = XCUIApplication()
		print(app.launchArguments)
		XCUIDevice.sharedDevice().orientation = .FaceUp
		sleep(1)
		
		let tabBarsQuery = XCUIApplication().tabBars
		tabBarsQuery.buttons.elementBoundByIndex(1).tap()
		sleep(1)
		snapshot("2-emoticonList")
		
		tabBarsQuery.buttons.elementBoundByIndex(0).tap()
		
		app.textFields["Text Field Dark"].tap()
		
		if deviceLanguage.containsString("en") {
			app.buttons["Next keyboard"].tap()
		}
		else if deviceLanguage.containsString("fr") {
			app.buttons["Clavier suivant"].tap()
		}
		else if deviceLanguage.containsString("de") {
			app.buttons["Nächste Tastatur"].tap()
		}
		else if deviceLanguage.containsString("it") {
			app.buttons["Tastiera successiva"].tap()
		}
		else if deviceLanguage.containsString("es") {
			app.buttons["Teclado siguiente"].tap()
		}
		sleep(2)
		snapshot("0-keyboardDark")
    }
	
	func testLight() {
		let app = XCUIApplication()
		
		sleep(1)
		
		app.textFields["Text Field Light"].tap()
		
//		if deviceLanguage.containsString("en") {
//			app.buttons["Next keyboard"].tap()
//		}
//		else if deviceLanguage.containsString("fr") {
//			app.buttons["Clavier suivant"].tap()
//		}
//		else if deviceLanguage.containsString("de") {
//			app.buttons["Nächste Tastatur"].tap()
//		}
//		else if deviceLanguage.containsString("it") {
//			app.buttons["Tastiera successiva"].tap()
//		}
//		else if deviceLanguage.containsString("es") {
//			app.buttons["Teclado siguiente"].tap()
//		}
		sleep(2)
		snapshot("1-keyboardLight")
	}
}

