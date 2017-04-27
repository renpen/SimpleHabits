//
//  Travel.swift
//  AlarmClock
//
//  Created by ReneUser on 25.10.16.
//  Copyright © 2016 ReneUser. All rights reserved.
//

import Foundation
import CoreData

protocol Travel {
    var source : String? {get set}
    var destination : String? {get set}
    var transitmode : TransitMode? {get set}
    var trafficModel: TrafficModel? {get set}
    var mode : Mode? {get set}
    var departure_time: Int? {get set}       //for traffic calculation and ÖPNV // in s
    var representingCoreDataObject : TravelC? {get set}
    func getTravelTimeInS() -> Int
    func calculationFinished()
    func calculateTravelTime(closure: @escaping (_ : Int)-> Void)
}
extension Travel {
    var properties : NSDictionary{
        return InternalHelper.sharedInstance.getProperties()
    }
    mutating func save()
    {
        representingCoreDataObject?.destination = destination
        representingCoreDataObject?.transitmode = transitmode?.rawValue
        representingCoreDataObject?.source = source
        representingCoreDataObject?.trafficModel = trafficModel?.rawValue
        if departure_time == nil {
            departure_time = -1
        }
            representingCoreDataObject?.departure_time = Int32(departure_time!)
        representingCoreDataObject?.mode = mode?.rawValue
        TravelCoreDataHandler.sharedInstance.save()
    }
    mutating func setRepresentingCoreDataValues(coreDataTravel : TravelC)
    {
        source = coreDataTravel.source
        destination = coreDataTravel.destination
        if coreDataTravel.transitmode != nil{
            transitmode = TransitMode(rawValue: coreDataTravel.transitmode!)
        }
        if coreDataTravel.trafficModel != nil{
            trafficModel = TrafficModel(rawValue: coreDataTravel.trafficModel!)
        }
        if coreDataTravel.mode != nil{
            mode = Mode(rawValue: coreDataTravel.mode!)

        }
        departure_time = Int(coreDataTravel.departure_time)
        representingCoreDataObject = coreDataTravel
    }

}
