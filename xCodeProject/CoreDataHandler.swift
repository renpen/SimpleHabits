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
            
        }
    }
    func getObjectByName(name:String) -> Alarm?
    {
        let pred = NSPredicate(format: "(name = %@)", name)
        var objects = getObjects(entityName: name, predicate: pred)
        if (objects != nil) {
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
        if objects != nil{
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
        if objects != nil{
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
}
