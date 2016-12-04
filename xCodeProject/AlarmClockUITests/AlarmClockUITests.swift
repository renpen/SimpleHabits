//
//  AlarmClockUITests.swift
//  AlarmClockUITests
//
//  Created by ReneUser on 24.10.16.
//  Copyright © 2016 ReneUser. All rights reserved.
//

import XCTest

class AlarmClockUITests: XCTestCase {
        
    override func setUp() {
        super.setUp()
        
        // Put setup code here. This method is called before the invocation of each test method in the class.
        
        // In UI tests it is usually best to stop immediately when a failure occurs.
        continueAfterFailure = false
        // UI tests must launch the application that they test. Doing this in setup will make sure it happens for each test method.
        XCUIApplication().launch()

        // In UI tests it’s important to set the initial state - such as interface orientation - required for your tests before they run. The setUp method is a good place to do this.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testExample() {
        // Use recording to get started writing UI tests.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
        
        let app = XCUIApplication()
        
        app.otherElements.containing(.image, identifier:"BG Start Screen.png").children(matching: .button).matching(identifier: "Button").element(boundBy: 0).tap()
        
        let app2 = app
        app2.pickerWheels.element(boundBy: 0).adjust(toPickerWheelValue: "Birthdays")
        let element = app.children(matching: .window).element(boundBy: 0).children(matching: .other).element(boundBy: 1)
        app.staticTexts["Birthdays"] //läuft nur durch wenns existiert
        element.swipeLeft()
        element.swipeLeft()


        
        
        
        
        
    }
    
}
