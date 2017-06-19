//
//  File.swift
//  AlarmClock
//
//  Created by René Penkert on 16.06.17.
//  Copyright © 2017 ReneUser. All rights reserved.
//

import Foundation
import XCTest
class CreateAlarm: XCTestCase
{
    var app: XCUIApplication!
    override func setUp() {
        app = XCUIApplication()
        app.launch()
    }
    func testCreateAlarm()
    {
        
        let app = XCUIApplication()
        app.children(matching: .window).element(boundBy: 0).children(matching: .other).element.children(matching: .other).element.children(matching: .other).element.children(matching: .button).element.tap()
        app.tables.staticTexts["Alarms"].tap()
        app.navigationBars["AlarmClock.AlarmListView"].buttons["Add"].tap()
        app.children(matching: .window).element(boundBy: 0).children(matching: .other).element.tap()
        app.textFields["alarmName"].tap()
        app.textFields["alarmName"].typeText("UITESTALARM")
        app.switches["1"].tap()
        app.datePickers.pickerWheels["06 o’clock"].swipeUp()
        app.buttons["Save"].tap()
        XCTAssert(app.staticTexts["UITESTALARM"].exists)
    }
}


