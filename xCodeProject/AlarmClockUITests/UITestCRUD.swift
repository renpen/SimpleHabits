//
//  UITestCRUD.swift
//  AlarmClock
//
//  Created by ReneUser on 06.12.16.
//  Copyright © 2016 ReneUser. All rights reserved.
//

import XCTest

class UITestCRUD: XCTestCase {
        
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
        app.buttons["Enter CRUD"].tap()
        app.buttons["Create"].tap()
        let name = app.textFields["CrudNameTextField"]
        name.tap()
        name.typeText("CrudDEMO")
        let offset = app.textFields["CrudOffSetTextField"]
        offset.tap()
        offset.typeText("12")
        let source = app.textFields["CrudSourceTextField"]
        source.tap()
        source.typeText("CrudSourceDemo")
        let destination = app.textFields["CrudDestinationTextField"]
        destination.tap()
        destination.typeText("CrudDestinationDemo")
        app.buttons["Save"].tap()
        app.buttons["Show"].tap()
        XCTAssert(app.tables.staticTexts["CrudDEMO"].exists)
        XCTAssert(app.tables.staticTexts["12"].exists)
        XCTAssert(app.tables.staticTexts["CrudSourceDemo"].exists)
        XCTAssert(app.tables.staticTexts["CrudDestinationDemo"].exists)
        app.buttons["back"].tap()
        app.buttons["Update"].tap()
        let updateName = app.textFields["CRUDUpdateNameField"]
        updateName.tap()
        updateName.typeText("CrudDEMO")
        let updateDestiantion = app.textFields["CrudUpdateDestinationTextField"]
        updateDestiantion.tap()
        updateDestiantion.typeText("CrudDestinationUpdated")
        app.buttons["Update!"].tap()
        app.buttons["Show"].tap()
        XCTAssert(app.tables.staticTexts["CrudDEMO"].exists)
        XCTAssert(app.tables.staticTexts["CrudDestinationUpdated"].exists)
        let tablesQuery = app.tables.cells
        tablesQuery.element(boundBy: 0).swipeLeft()
        tablesQuery.element(boundBy: 0).buttons["Delete"].tap()
        XCTAssert(!app.tables.staticTexts["CrudDEMO"].exists)
        app.buttons["back"].tap()
        app.buttons["close CRUD"].tap()
        
        
        
        
    }
    
}
