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
    
    private let alarmEntityName = "Alarm"
    let managedObjectContext = (UIApplication.shared.delegate as! AppDelegate).managedObjectContext
    func getAlarmObject() -> Alarm {
        let alarm = NSEntityDescription.insertNewObject(forEntityName: alarmEntityName, into: managedObjectContext) as! Alarm
        return alarm
    }
    func save() {
        do{
            try managedObjectContext.save()
        }
        catch
        {
            
        }
    }
    func getAllAlarms() -> Array<Any>?
    {
        return getObjects(entityName: alarmEntityName)
    }
    func getAlarmByName(name:String) -> Alarm?
    {
        let pred = NSPredicate(format: "(name = %@)", name)
        var objects = getObjects(entityName: name, predicate: pred)
        if (objects != nil) {
            return objects?[0] as! Alarm
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
    private func getObjects(entityName: String)->Array<Any>?
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
}
