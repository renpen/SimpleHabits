//
//  Travel.swift
//  AlarmClock
//
//  Created by ReneUser on 25.10.16.
//  Copyright © 2016 ReneUser. All rights reserved.
//

import Foundation

protocol Travel {
    var offset : Int? {get set}      //for waking up, eating etc. // in s
    var source : String? {get set}
    var destination : String? {get set}
    var transitmode : TransitMode? {get set}
    var trafficModel: TrafficModel? {get set}
    var mode : Mode? {get set}
    var departure_time: Int? {get set}       //for traffic calculation and ÖPNV // in s
    func getTravelTimeInS() -> Int
    func calculationFinished()
    func calculateTravelTime(closure: @escaping (_ : String)-> Void)
}
extension Travel {
    var properties : NSDictionary{
        return InternalHelper.sharedInstance.getProperties()
    }
}
