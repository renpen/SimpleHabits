//
//  MapKitTimeCalc.swift
//  AlarmClock
//
//  Created by ReneUser on 25.10.16.
//  Copyright © 2016 ReneUser. All rights reserved.
//

import Foundation
import CoreLocation
import MapKit
import EventKit

class MapKitTimeCalc : TimeCalculator {
    
    func calculateOverallWakeUpTime(travel : Travel)
    {
        if(travel.completeToCalculate())
        {
            calcTravelTime(travel: travel)
        }
        else
        {
            //Throw Exeption here
        }
    }
    func calcTravelTime(travel: Travel)
    {
        var longLatFrom : CLLocation?
        var longLatTo : CLLocation?
        let geocoder = CLGeocoder()
        geocoder.geocodeAddressString(travel.source!, completionHandler: { (placemark, error) in
            longLatFrom = (placemark?[0].location)!
        })
        geocoder.geocodeAddressString(travel.destionation!, completionHandler: { (placemark, error) in
            longLatTo = (placemark?[0].location)!
            print("geocoder reached")
            print(error)
        })
        let mkplacemarkFrom = MKPlacemark(coordinate: (longLatFrom?.coordinate)!,addressDictionary: [:])
        let mkplacemarkTo = MKPlacemark(coordinate: (longLatTo?.coordinate)!,addressDictionary: [:])
        let mapItemFrom = MKMapItem(placemark: mkplacemarkFrom)
        let mapItemTo = MKMapItem(placemark: mkplacemarkTo)
        let directionRequest = MKDirectionsRequest()
        directionRequest.source = mapItemTo
        directionRequest.destination = mapItemFrom
        directionRequest.transportType = .automobile
        let direction = MKDirections(request: directionRequest)
        direction.calculate { (response, error) in
            let intervall = (response?.routes[0].expectedTravelTime)!
            travel.travelTime? = Int(intervall.truncatingRemainder(dividingBy: 60)) + travel.extraMin
            travel.isTravelTimeCalculated = true
        }
        
    }
    
    
}
