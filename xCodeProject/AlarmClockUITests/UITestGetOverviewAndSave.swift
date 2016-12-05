//
//  AlarmClockUITestGetOverviewAndSave.swift
//  AlarmClock
//
//  Created by ReneUser on 05.12.16.
//  Copyright © 2016 ReneUser. All rights reserved.
//

import XCTest

class UITestGetOverviewAndSave: XCTestCase {        //This Testcase Includes also the Usecase for OffSetInput
        
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
        let app = XCUIApplication()
        let bgStartScreenPngElementsQuery = app.otherElements.containing(.image, identifier:"BG Start Screen.png")
        bgStartScreenPngElementsQuery.children(matching: .button).matching(identifier: "Button").element(boundBy: 0).tap()
        app.pickerWheels.element(boundBy: 0).adjust(toPickerWheelValue: "Birthdays")
        let element = app.children(matching: .window).element(boundBy: 0).children(matching: .other).element(boundBy: 1)
        element.swipeLeft()
        element.swipeLeft()
        element.tap()
        app.textFields["30"].tap()
        app.textFields[""].typeText("23")
        element.swipeLeft()
        element.swipeLeft()
        element.swipeLeft()
        XCTAssert(app.staticTexts["23"].exists)
        XCTAssert(app.staticTexts["Birthdays"].exists)
        app.buttons["Save"].tap()

    }
}
