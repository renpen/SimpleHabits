//
//  Alarm+CoreDataProperties.swift
//  AlarmClock
//
//  Created by ReneUser on 09.11.16.
//  Copyright © 2016 ReneUser. All rights reserved.
//

import Foundation
import CoreData


extension Alarm {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Alarm> {
        return NSFetchRequest<Alarm>(entityName: "Alarm");
    }
    @NSManaged public var travel_f_key: Int32
    @NSManaged public var wakeUpTime: Date?
    @NSManaged public var wakeUpTone_f_key: Int32
    @NSManaged public var name: String
    @NSManaged public var smartAlarm: Bool
    @NSManaged public var isActivated: Bool
    @NSManaged public var calendarIdentifier: String
    @NSManaged public var id: Int32
}
