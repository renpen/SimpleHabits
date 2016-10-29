//
//  Travel.swift
//  AlarmClock
//
//  Created by ReneUser on 25.10.16.
//  Copyright © 2016 ReneUser. All rights reserved.
//

import Foundation

class Travel{
    var destionation: String?
    var source: String?
    var travelTime : Int?
    var extraMin = 0 //for extra minutes that you need to wake up, eat etc.
    var calculatedGoogleJsonObject : GoogleDistanceMatrixObject?
    var plistDict = InternalHelper.sharedInstance.getProperties()
    
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
        let timeCalc = getCalculator()
        timeCalc.calculateOverallWakeUpTime(travel: self)
    }
    
    private func getCalculator() -> TimeCalculator
    {
        let travelCalculationAPI = self.plistDict["TravelCalculationAPI"]
        //0 --> Mapkit 1 --> Google API
        if(travelCalculationAPI as? Int == 1)
        {
            return GoogleApiTimeCalc()
        }
        else if(travelCalculationAPI as? Int == 0)
        {
            return MapKitTimeCalc()
        }
        else
        {
            return GoogleApiTimeCalc()
        }
    }
    func calculationFinished()
    {
        //errorHandling if status not ok
        print("FINISHED: " + (calculatedGoogleJsonObject?.durationText)!)
    }
}
