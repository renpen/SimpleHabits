//
//  AlarmSound+CoreDataProperties.swift
//  AlarmClock
//
//  Created by René Penkert on 11.04.17.
//  Copyright © 2017 ReneUser. All rights reserved.
//

import Foundation
import CoreData


extension AlarmSoundC {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<AlarmSoundC> {
        return NSFetchRequest<AlarmSoundC>(entityName: "AlarmSoundC");
    }

    @NSManaged public var id: Int32
    @NSManaged public var fileName: String?
    @NSManaged public var url: String?
    @NSManaged public var source: String?

}
