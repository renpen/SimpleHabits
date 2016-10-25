//
//  Travel.swift
//  AlarmClock
//
//  Created by ReneUser on 25.10.16.
//  Copyright © 2016 ReneUser. All rights reserved.
//

class Travel{
    var destionation: String?
    var source: String?
    var travelTime : Int?
    var extraMin = 0 //for extra minutes that you need to wake up, eat etc.
    var isTravelTimeCalculated = false
    
    func completeToCalculate() -> Bool
    {
        if ((destionation != nil) && (source != nil) )
        {
            return true
        }
        else{
            return false
        }
    }
    func calculateTime()
    {
        let timeCalc = TimeCalculator()
        timeCalc.calculateOverallWakeUpTime(travel: self)
    }
}
