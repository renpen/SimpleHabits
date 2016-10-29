//
//  GoogleDistanceMatrixTravel.swift
//  AlarmClock
//
//  Created by ReneUser on 29.10.16.
//  Copyright © 2016 ReneUser. All rights reserved.
//

import Foundation
import SwiftyJSON

class GoogleDistanceMatrixTravel : Travel
{
    var offset : Int?
    var calculatedJsonObject: GoogleDistanceMatrixObject?
    var departure_time : Int?
    var source : String?
    var destination : String?
    var transitmode : TransitMode?
    var trafficModel: TrafficModel?
    var mode : Mode?
    
    func getTravelTimeInS() -> Int
    {
        return calculatedJsonObject!.durationValue!
    }
    func calculationFinished()
    {
        print("FINSIHED: YEEEES " + (self.calculatedJsonObject?.durationText)!)
    }
    func calculateTravelTime()
    {
        RestApiManager.sharedInstance.request(url: properties["GoogleDistanceMatrixBaseUrl"] as! String + "?origins=Ludwig+Erhard+Allee+32+76131+Karlsruhe&destinations=Belgien"){ (json: JSON) in
            self.calculatedJsonObject =  GoogleDistanceMatrixObject(json : json)
            DispatchQueue.main.async(execute: {         //the thing that need toDo when the Request is finished
                self.calculationFinished()
            })
        }

    }

}
