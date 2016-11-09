//
//  Alarm+CoreDataClass.swift
//  AlarmClock
//
//  Created by ReneUser on 09.11.16.
//  Copyright © 2016 ReneUser. All rights reserved.
//

import Foundation
import CoreData

@objc(Alarm)
public class Alarm: NSManagedObject {
    var travel : Travel?
    var activePattern : ActivePattern?
    var wakeUpTone : AlarmSound?
    
}
