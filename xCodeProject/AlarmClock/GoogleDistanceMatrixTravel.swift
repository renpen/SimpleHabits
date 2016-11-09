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
    
    private func isValid() -> Bool      //determine if the minimun that the request need is set
    {
    
        return true
    }
    func getTravelTimeInS() -> Int
    {
        return calculatedJsonObject!.durationValue! + offset!
    }
    func calculationFinished()
    {
        print("FINSIHED: YEEEES " + (self.calculatedJsonObject?.durationText)!)
    }
    func calculateTravelTime(closure: @escaping (_ : String) -> Void)
    {
        if isValid()
        {
            RestApiManager.sharedInstance.request(url: generateUrl()){ (json: JSON) in
                self.calculatedJsonObject =  GoogleDistanceMatrixObject(json : json)
                DispatchQueue.main.async(execute: {         //the thing that need toDo when the Request is finished
                    closure((self.calculatedJsonObject?.durationText)!)
                })
            }
        }
        else{
            //throw some kind of exception
        }
    }
    
    func generateUrl() -> String {
        var url = properties["GoogleDistanceMatrixBaseUrl"] as! String
        print(url)
        url += "?origins=\(source!)&destinations=\(destination!)&key=\(properties["GoogleAPIKey"]!)"
        if (departure_time != nil) {
            url += "&departure_time=\(departure_time!)"
        }
        if (mode != nil)
        {
            url += "&mode=\(mode!)"
                if (mode == .transit && (transitmode) != nil)
                {
                        url += "&transitmode=\(transitmode!)"
                }
                if (mode == .driving && (trafficModel) != nil && departure_time != nil)
                {
                    url += "&traffic_model=\(trafficModel!)"
                }
        }
        var text = "bus"
        let transit: TransitMode = TransitMode(rawValue: text)!
        print(transit)
        return url
    }

}
