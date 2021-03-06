//
//  CurrentWeather.swift
//  AlarmClock
//
//  Created by René Penkert on 02.05.17.
//  Copyright © 2017 ReneUser. All rights reserved.
//

import Foundation

public class CurrentWeather
{
    private var weather : Weather?
    private var timer : Timer?
    private var closure : ((Weather) -> Void)?
    static let sharedInstance = CurrentWeather()
    private func repeatWeatherRequests() {
        //frage jede Stunde das Wetter neu ab und setzte es entsprechend als InstanzVariable neu
        timer = Timer(timeInterval: 1*60*60, target: self, selector: #selector(requestWeather),userInfo: nil, repeats: true)
        RunLoop.main.add(timer!, forMode: RunLoopMode.commonModes)
        //fire the timer the first time
        timer?.fire()
    }

    func startRequesting(closure : @escaping (Weather) -> Void) {
        self.closure = closure
        if timer == nil {
            repeatWeatherRequests()
        }
        else
        {
            setWeather(weather: self.weather)
        }
        
    }
    
    @objc private func requestWeather() {
        WeatherAPIHandler.sharedInstance.getWeatherForCurrentPosition(closure: setWeather)
    }
    private func setWeather(weather : Weather?)
    {
        self.weather = weather
        if (closure != nil && self.weather != nil){
            closure!(weather!)
        }
    }
}
