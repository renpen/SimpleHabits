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
            //toDo
        }
    }
    
        internal func getObjects(entityName: String,predicate: NSPredicate) -> Array<Any>?
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
    internal func getObjects(entityName: String)->Array<Any>?
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
    internal func getEntityDescirption(entityName: String) -> NSEntityDescription
    {
        return NSEntityDescription.entity(forEntityName: entityName, in: managedObjectContext)!
    }
    internal func deleteObject(entity : Any)
    {
        managedObjectContext.delete(entity as! NSManagedObject)
        self.save()
    }
}
