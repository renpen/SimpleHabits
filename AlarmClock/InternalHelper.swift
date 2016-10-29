//
//  InternalHelper.swift
//  AlarmClock
//
//  Created by ReneUser on 29.10.16.
//  Copyright © 2016 ReneUser. All rights reserved.
//

import Foundation

class InternalHelper
{
    static let sharedInstance = InternalHelper()
    private let propertiesName = "Properties"
    func getProperties() -> NSDictionary
    {
        let pathOfProperties = Bundle.main.path(forResource: propertiesName, ofType: "plist")
        return NSDictionary(contentsOfFile: pathOfProperties!)!
    }
    func getTravel() -> Travel
    {
        let travelCalculationAPI = self.getProperties()["TravelCalculationAPI"]
        //0 --> Mapkit 1 --> Google API
        if(travelCalculationAPI as? Int == 1)
        {
            return GoogleDistanceMatrixTravel()
        }
        else if(travelCalculationAPI as? Int == 0)
        {
            return MapKitTravel()
        }
        else
        {
            return GoogleDistanceMatrixTravel()
        }
    }

}
