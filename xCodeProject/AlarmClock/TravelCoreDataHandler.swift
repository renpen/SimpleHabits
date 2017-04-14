//
//  TravelCoreDataHandler.swift
//  AlarmClock
//
//  Created by René Penkert on 10.04.17.
//  Copyright © 2017 ReneUser. All rights reserved.
//

import Foundation
import CoreData

class TravelCoreDataHandler : CoreDataHandler
{
    static let sharedInstance = TravelCoreDataHandler()
    internal func getTravelById(id: Int32) -> Travel? {
        let pred = NSPredicate(format: "(id = %@)", String(id))
        let objects = getObjects(entityName: "TravelC", predicate: pred)
        if let objects = objects {
            let travelC = objects[0] as? TravelC
            var travel = InternalHelper.sharedInstance.getTravel()
            travel.setRepresentingCoreDataValues(coreDataTravel: travelC!)
            return travel
        }
        return nil
        
    }
    internal func getNewTravelID () ->Int32
    {
        let entityDescription = getEntityDescirption(entityName: "TravelC")
        let request = NSFetchRequest<NSFetchRequestResult>()
        request.entity = entityDescription
        request.fetchLimit = 1;
        request.sortDescriptors = [NSSortDescriptor.init(key: "id", ascending: false)]
        var objects : Array<Any>? = nil
        do{
            try objects = managedObjectContext.fetch(request)
        }
        catch
        {
            
        }
        if objects?.count != 0
        {
            return (objects![0] as! TravelC).id + 1
        }
        return 0
    }
    internal func fabricateTravelObject() -> Travel {
        let travelC:TravelC = fabricateCoreDataObject(entityName: "TravelC") as! TravelC
        var travel = InternalHelper.sharedInstance.getTravel()
        travel.representingCoreDataObject = travelC
        return travel
        
    }


}
