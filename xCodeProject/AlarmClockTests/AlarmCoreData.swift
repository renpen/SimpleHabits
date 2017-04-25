//
//  AlarmCoreData.swift
//  AlarmClock
//
//  Created by René Penkert on 23.04.17.
//  Copyright © 2017 ReneUser. All rights reserved.
//

import XCTest
@testable import AlarmClock
class AlarmCoreData: XCTestCase {
    let alarmCoreDataHandler = AlarmCoreDataHandler.sharedInstance
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
    func testAlarmCreationAndSaving()
    {
        let alarmId = createAlarm()
        let coreDateAlarm = alarmCoreDataHandler.getAlarmByID(id: alarmId)
        XCTAssertEqual(coreDateAlarm?.name, "TestSmartAlarm","Der Alarm wurde nicht korrekt gespeichert oder konnte nicht korrekt wieder aus der Datenbank abgefragt werden")
    }
    func testAlarmDeletion()
    {
        let alarmId = createAlarm()
        let alarm = alarmCoreDataHandler.getAlarmByID(id: alarmId)
        XCTAssertNotNil(alarm,"Der zu löschende Alarm existiert garnicht und kann somit auch nicht gelöscht werden")
        alarmCoreDataHandler.deleteAlarm(alarmID: alarmId)
        let coreDateAlarm = alarmCoreDataHandler.getAlarmByID(id: alarmId)
        XCTAssertNil(coreDateAlarm, "Gelöschter Alarm existiert immernoch")
    }
    private func createAlarm() -> Int32
    {
        let alarm = alarmCoreDataHandler.fabricateAlarm()
        alarm.name = "TestSmartAlarm"
        alarm.smartAlarm = true
        alarm.save()
        return alarm.id
    }
}

