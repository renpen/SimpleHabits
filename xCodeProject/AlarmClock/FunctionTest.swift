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
        let alarm = CoreDataHandler.sharedInstance.fabricateCoreDataObject(entityName: "Alarm") as! Alarm
        alarm.name = "alertWithTravelData6"
        alarm.travel?.destination = "Muenchen"
        alarm.travel?.source = "Karlsruhe"
        alarm.travel?.mode = Mode.driving
        alarm.travel?.trafficModel = TrafficModel.best_guess
        alarm.save()
        let alarmCore = CoreDataHandler.sharedInstance.getAlarmByName(name: "alertWithTravelData6")
        if let a = alarmCore?.travel?.destination
        {
            print(a)
        }
        if let a = alarmCore?.travel?.source
        {
            print(a)
        }
        if let a = alarmCore?.travel?.mode
        {
            print(a)
        }
        if let a = alarmCore?.travel?.trafficModel
        {
            print(a)
        }
        CoreDataHandler.sharedInstance.deleteAlarn(alarmName: alarm.name)
       // let alarmDe  = CoreDataHandler.sharedInstance.getAlarmByName(name: "alertWithTravelData6")
     //   print("gelöschter Name: " + (alarmDe?.name)!)
        }
    
}
