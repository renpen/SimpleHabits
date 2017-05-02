//
//  WeatherAPIHandler.swift
//  AlarmClock
//
//  Created by René Penkert on 14.04.17.
//  Copyright © 2017 ReneUser. All rights reserved.
//

import Foundation
import SwiftyJSON

public class WeatherAPIHandler
{
    static let sharedInstance = WeatherAPIHandler()
    let locationTools = LocationTools.sharedInstance
    let properties = InternalHelper.sharedInstance.getProperties()
    let restApiManager = RestApiManager.sharedInstance
    var temp_closure : ((_ : Weather) -> Void)?
    func getWeatherForCurrentPosition(closure: @escaping (_ : Weather) -> Void)
    {
        if let lat = locationTools.currentLat, let long = locationTools.currentLong
        {
            getWeather(long: long, lat: lat,closure : closure)
        }
        else
            //falls die aktuelle Position noch nicht geladen wurde, versuche es in 1 Sekunde nochmal neu
        {
            temp_closure = closure
            var dateComponents = DateComponents()
            dateComponents.second = 1
            let calendar = Calendar.current
            var currentDate = Date()
            currentDate = calendar.date(byAdding: dateComponents, to: currentDate)!
            let timer = Timer(fireAt: currentDate, interval: 0, target: self, selector: #selector(tryAgain),userInfo: nil, repeats: false)
            RunLoop.main.add(timer, forMode: RunLoopMode.commonModes)
        }
    }
    @objc private func tryAgain()
    {
        getWeatherForCurrentPosition(closure: temp_closure!)
    }
    func getWeather(long : Double,lat: Double,closure: @escaping (_ : Weather) -> Void)
    {
        let url = generateUrl(long: long, lat: lat)
        restApiManager.request(url: url){ (json: JSON) in
            let weather =  Weather(json: json)
            DispatchQueue.main.async(execute: {         //the thing that need toDo when the Request is finished
                closure(weather)
            })
        }
    }
    private func generateUrl(long:Double,lat:Double) -> String
    {
        let baseUrl = properties["OpenWeatherMapBaseUrl"] as! String
        var url = "\(baseUrl)?appid=\(properties["OpenWeatherMapAPIKey"] as! String)"
        url = "\(url)&units=metric&lon=\(long)&lat=\(lat)"
        return url
    }
}
