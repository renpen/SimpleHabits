//
//  TravelCalculation.swift
//  AlarmClock
//
//  Created by René Penkert on 23.04.17.
//  Copyright © 2017 ReneUser. All rights reserved.
//

import XCTest
@testable import AlarmClock
class TravelCalculation: XCTestCase {
    var temp_expectation : XCTestExpectation? = nil
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }
    func testTravelCalculation()
    {
        temp_expectation = self.expectation(description: "Berechnung der Travelstrecke und Zeit ist asynchron")
        let alarmID = TravelAPI.sharedInstance.createAlarmWithTravel()
        let alarm = AlarmCoreDataHandler.sharedInstance.getAlarmByID(id: alarmID)
        alarm?.travel?.source = "Ludwig Erhard Allee 32 76131 Karlsruhe"
        alarm?.travel?.calculateTravelTime(closure: testTravel)
        waitForExpectations(timeout: 10) { error in
            if let error = error {
                print("Error: \(error.localizedDescription)")
                XCTAssert(false)
            }
        }

    }
    private func testTravel(travelTime : Int)
    {
        XCTAssertNotEqual(travelTime, 0)
        print(travelTime)
        temp_expectation?.fulfill()
    }
}
