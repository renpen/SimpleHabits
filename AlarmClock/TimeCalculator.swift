//
//  TimeCalculator.swift
//  AlarmClock
//
//  Created by ReneUser on 28.10.16.
//  Copyright © 2016 ReneUser. All rights reserved.
//

import Foundation

protocol TimeCalculator {
    func calculateOverallWakeUpTime(travel : Travel)
    func calcTravelTime(travel: Travel)
}

