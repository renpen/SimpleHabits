//
//  MapKitTravel.swift
//  AlarmClock
//
//  Created by ReneUser on 29.10.16.
//  Copyright © 2016 ReneUser. All rights reserved.
//

import Foundation
import CoreLocation
import MapKit
import EventKit

class MapKitTravel: Travel {
    var offset : Int?
    var source : String?
    var destination : String?
    var departure_time: Int?
    var transitmode : TransitMode?
    var trafficModel: TrafficModel?
    var mode : Mode?
    var representingCoreDataObject : TravelC?
    
    var travelTime = 0
    func getTravelTimeInS() -> Int
    {
        return 0
    }
    func calculationFinished()
    {
        
    }
    func calculateTravelTime(arrivalTime : Int, closure: @escaping (Int) -> Void)
    {
        var longLatFrom : CLLocation?
        var longLatTo : CLLocation?
        let geocoder = CLGeocoder()
        geocoder.geocodeAddressString(self.source!, completionHandler: { (placemark, error) in
            longLatFrom = (placemark?[0].location)!
        })
        geocoder.geocodeAddressString(self.destination!, completionHandler: { (placemark, error) in
            longLatTo = (placemark?[0].location)!
            print("geocoder reached")
            print(error!)
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
            self.travelTime = Int(intervall.truncatingRemainder(dividingBy: 60))
            //travel.isTravelTimeCalculated = true
    }

    }
}
