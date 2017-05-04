//
//  Settings+CoreDataProperties.swift
//  AlarmClock
//
//  Created by René Penkert on 10.04.17.
//  Copyright © 2017 ReneUser. All rights reserved.
//

import Foundation
import CoreData


extension Settings {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Settings> {
        return NSFetchRequest<Settings>(entityName: "Settings");
    }
    
    @NSManaged public var defaultDestLat: Double
    @NSManaged public var defaultDestLong: Double
    @NSManaged public var defaultSourceLat: Double
    @NSManaged public var defaultSourceLong: Double
    @NSManaged public var offsetInMin: Int16

}
