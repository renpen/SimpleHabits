//
//  GoogleApiTimeCalc.swift
//  AlarmClock
//
//  Created by ReneUser on 29.10.16.
//  Copyright © 2016 ReneUser. All rights reserved.
//

import Foundation
import SwiftyJSON

class GoogleApiTimeCalc: TimeCalculator {
    let properties = InternalHelper.sharedInstance.getProperties()
    func calculateOverallWakeUpTime(travel : Travel)
    {
        calcTravelTime(travel: travel)
    }
    func calcTravelTime(travel: Travel)
    {
        RestApiManager.sharedInstance.request(url: properties["GoogleDistanceMatrixBaseUrl"] as! String + "?origins=Ludwig+Erhard+Allee+32+76131+Karlsruhe&destinations=Belgien"){ (json: JSON) in
            travel.calculatedGoogleJsonObject =  GoogleDistanceMatrixObject(json : json)
            DispatchQueue.main.async(execute: {         //the thing that need toDo when the Request is finished
                travel.calculationFinished()
            })
            }
        }
//    func buildUrl(<#parameters#>) -> <#return type#> {
//        <#function body#>
//    }
}

    

