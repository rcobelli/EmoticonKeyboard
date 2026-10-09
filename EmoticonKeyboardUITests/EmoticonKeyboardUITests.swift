//
//  EmoticonKeyboardUITests.swift
//  EmoticonKeyboardUITests
//
//  Created by Ryan Cobelli on 11/2/15.
//  Copyright © 2015 Rybel LLC. All rights reserved.
//

import XCTest

class EmoticonKeyboardUITests: XCTestCase {
    
    @MainActor func testExample() {
        let app = XCUIApplication()
        app.launchArguments = ["testing"]
        setupSnapshot(app)
        app.launch()
        
        let tabBarsQuery = XCUIApplication().tabBars
        tabBarsQuery.buttons.element(boundBy: 1).tap()
        sleep(1)
        snapshot("1-emoticonList")
        
        tabBarsQuery.buttons.element(boundBy: 0).tap()
        
        let testField = app.textFields.firstMatch
        XCTAssertTrue(testField.waitForExistence(timeout: 5))
        
        testField.tap()
        
        sleep(2)
        snapshot("0-keyboard")
    }
}

