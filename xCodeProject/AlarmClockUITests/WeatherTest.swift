//
//  File.swift
//  AlarmClock
//
//  Created by René Penkert on 16.06.17.
//  Copyright © 2017 ReneUser. All rights reserved.
//

import Foundation
import XCTest
class WeatherTest: XCTestCase
{
    var app: XCUIApplication!
    override func setUp() {
        app = XCUIApplication()
        app.launch()
    }
    func testWeather() {
        sleep(2)
        let goLabel = app.staticTexts.element(matching: .any, identifier: "weatherField").label
        XCTAssert(goLabel.contains("C"))
    }
    
}


