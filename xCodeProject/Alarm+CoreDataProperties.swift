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
    @NSManaged public var active_f_key: Int16
    @NSManaged public var offset: Int16
    @NSManaged public var travel_f_key: Int32
    @NSManaged public var wakeUpTime: NSDate
    @NSManaged public var wakeUpTone_f_key: Int32
    @NSManaged public var name: String

}
