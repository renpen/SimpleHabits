//
//  FunctionTest.swift
//  AlarmClock
//
//  Created by ReneUser on 09.11.16.
//  Copyright © 2016 ReneUser. All rights reserved.
//

import Foundation

class FunctionTest {
    
    func testSomething() {
        let cdh = CoreDataHandler()
        let alarm = cdh.fabricateCoreDataObject(entityName: "Alarm") as! Alarm
        alarm.name = "named alert"
        cdh.save()
        let alarm2 = cdh.fabricateCoreDataObject(entityName: "Alarm") as! Alarm
        alarm2.name = "nemaed alert2"
        cdh.save()
        for savedAlarm in cdh.getObjects(entityName: "Alarm")! {
            let alarm = savedAlarm as! Alarm
            print(alarm.name)
        }
    }
    
}
