//
//  SettingsCoreDataHandler.swift
//  AlarmClock
//
//  Created by René Penkert on 10.04.17.
//  Copyright © 2017 ReneUser. All rights reserved.
//

import Foundation
class SettingsCoreDataHandler : CoreDataHandler
{
    static let sharedInstance = SettingsCoreDataHandler()
    func getSettings() -> Settings {
        var objects = getObjects(entityName: "Settings")
        if let objects = objects {
            return (objects[0] as? Settings)!
        }
        let settings = self.fabricateCoreDataObject(entityName: "Settings") as! Settings
        save()
        return settings
    }
   }
