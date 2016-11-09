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
        let alarm = cdh.getAlarmObject()
        alarm.name = "named alert"
        cdh.save()
        let alarm2 = cdh.getAlarmObject()
        alarm2.name = "nemaed alert2"
        cdh.save()
        for savedAlarm in cdh.getAllAlarms()! {
            let alarm = savedAlarm as! Alarm
            print(alarm.name)
        }
    }
    
}
