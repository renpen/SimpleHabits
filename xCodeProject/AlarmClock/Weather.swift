//
//  WeatherWrapper.swift
//  AlarmClock
//
//  Created by René Penkert on 14.04.17.
//  Copyright © 2017 ReneUser. All rights reserved.
//

import Foundation
import SwiftyJSON

class Weather{
    let long : Double
    let lat : Double
    let icon: String
    let temp: Double
    let humidity: Double
    let windSpeed: Double
    let sunrise: Int
    let sunset:  Int
    
    required init(json : JSON) {
        long = json["coord"]["lon"].doubleValue
        lat = json["coord"]["lat"].doubleValue
        temp = json["main"]["temp"].doubleValue
        icon = json["weather"][0]["icon"].stringValue
        humidity = json["main"]["humidity"].doubleValue
        sunset = json["sys"]["sunset"].intValue
        sunrise = json["sys"]["sunrise"].intValue
        windSpeed = json["wind"]["speed"].doubleValue
    }
}
