//
//  TravelC+CoreDataProperties.swift
//  AlarmClock
//
//  Created by ReneUser on 14.11.16.
//  Copyright © 2016 ReneUser. All rights reserved.
//

import Foundation
import CoreData


extension TravelC {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<TravelC> {
        return NSFetchRequest<TravelC>(entityName: "TravelC");
    }

    @NSManaged public var departure_time: Int32
    @NSManaged public var destination: String?
    @NSManaged public var id: Int32
    @NSManaged public var mode: String?
    @NSManaged public var source: String?
    @NSManaged public var trafficModel: String?
    @NSManaged public var transitmode: String?

}
