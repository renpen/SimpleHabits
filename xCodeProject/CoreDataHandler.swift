//
//  AlarmDBController.swift
//  AlarmClock
//
//  Created by ReneUser on 09.11.16.
//  Copyright © 2016 ReneUser. All rights reserved.
//

import Foundation
import CoreData
import UIKit

class CoreDataHandler {
    let managedObjectContext = (UIApplication.shared.delegate as! AppDelegate).managedObjectContext
    static let sharedInstance = CoreDataHandler()
    func fabricateCoreDataObject(entityName: String) -> Any {
        let object = NSEntityDescription.insertNewObject(forEntityName: entityName, into: managedObjectContext)
        return object
    }
    func save() {
        do{
            try managedObjectContext.save()
        }
        catch
        {
            //toDo
        }
    }
    func getAlarmByName(name:String) -> Alarm?
    {
        let pred = NSPredicate(format: "(name = %@)", name)
        var objects = getObjects(entityName: "Alarm", predicate: pred)
        if (objects?.count != 0) {
            return objects?[0] as? Alarm
        }
        return nil
    }
    private func getObjects(entityName: String,predicate: NSPredicate) -> Array<Any>?
    {
        let entityDescription = getEntityDescirption(entityName: entityName)
        let request = NSFetchRequest<NSFetchRequestResult>()
        request.entity = entityDescription
        request.predicate = predicate
        var objects : Array<Any>? = nil
        do{
            try objects = managedObjectContext.fetch(request)
        }
        catch
        {
            
        }
        if objects?.count != 0 {
            return objects!
        }
        return nil
   
    }
    func getObjects(entityName: String)->Array<Any>?
    {
        let entityDescription = getEntityDescirption(entityName: entityName)
        let request = NSFetchRequest<NSFetchRequestResult>()
        request.entity = entityDescription
        var objects : Array<Any>? = nil
        do{
            try objects = managedObjectContext.fetch(request)
        }
        catch
        {
            
        }
        if objects?.count != 0{
            return objects!
        }
        return nil
    }
    private func getEntityDescirption(entityName: String) -> NSEntityDescription
    {
        return NSEntityDescription.entity(forEntityName: entityName, in: managedObjectContext)!
    }
    func deleteObject(entity : Any)
    {
        managedObjectContext.delete(entity as! NSManagedObject)
        self.save()
    }
    func fabricateTravelObject() -> Travel {
        let travelC:TravelC = fabricateCoreDataObject(entityName: "TravelC") as! TravelC
        var travel = InternalHelper.sharedInstance.getTravel()
        travel.representingCoreDataObject = travelC
        return travel
        
    }
    func getTravelById(id: Int32) -> Travel? {
        let pred = NSPredicate(format: "(id = %@)", String(id))
        var objects = getObjects(entityName: "TravelC", predicate: pred)
        if (objects?.count != 0) {
            let travelC = objects?[0] as? TravelC
            var travel = InternalHelper.sharedInstance.getTravel()
            travel.setRepresentingCoreDataValues(coreDataTravel: travelC!)
            return travel
        }
        return nil

    }
    func getNewTravelID () ->Int32
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
}
