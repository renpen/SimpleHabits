//
//  TravelCoreDate.swift
//  AlarmClock
//
//  Created by René Penkert on 23.04.17.
//  Copyright © 2017 ReneUser. All rights reserved.
//

import XCTest
@testable import AlarmClock
class TravelCoreDate: XCTestCase {
    
    
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
    func testTravelCreationAndSaving()
    {
        let alarmID = TravelAPI.sharedInstance.createAlarmWithTravel()
        let coreDataAlarm = AlarmCoreDataHandler.sharedInstance.getAlarmByID(id: alarmID)
        XCTAssertEqual(coreDataAlarm?.travel?.destination, "DHBW Karlsruhe")
        XCTAssertEqual(coreDataAlarm?.travel?.mode, Mode.bicycling)
        XCTAssertEqual(coreDataAlarm?.travel?.trafficModel, TrafficModel.best_guess)
    }
    
    func testTravelDeletion()
    {
        let alarmID = TravelAPI.sharedInstance.createAlarmWithTravel()
        let coreDataAlarm = AlarmCoreDataHandler.sharedInstance.getAlarmByID(id: alarmID)
        let travelID = coreDataAlarm?.travel_f_key
        AlarmCoreDataHandler.sharedInstance.deleteAlarm(alarmID: alarmID)
        let travel = TravelCoreDataHandler.sharedInstance.getTravelById(id: travelID!)
        let alarm = AlarmCoreDataHandler.sharedInstance.getAlarmByID(id: alarmID)
        
        XCTAssertNil(travel,"Es existiert immernoch ein Objekt mit der TravelID die an dem Alarm war. -> Travel wurde nicht richtig gelöscht.")
        XCTAssertNil(alarm,"Der Alarm wurde nicht gelöscht")
    }    

}
