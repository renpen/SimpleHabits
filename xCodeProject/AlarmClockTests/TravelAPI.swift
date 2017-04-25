//
//  TravelAPI.swift
//  AlarmClock
//
//  Created by René Penkert on 23.04.17.
//  Copyright © 2017 ReneUser. All rights reserved.
//

import Foundation
@testable import AlarmClock

class TravelAPI
{
    static let sharedInstance = TravelAPI()
    
    func createAlarmWithTravel() -> Int32
    {
        let alarm = AlarmCoreDataHandler.sharedInstance.fabricateAlarm()
        let alarmID = alarm.id
        alarm.travel?.destination = "DHBW Karlsruhe"
        alarm.travel?.mode = Mode.bicycling
        alarm.travel?.trafficModel = TrafficModel.best_guess
        alarm.save()
        return alarmID
    }
}


