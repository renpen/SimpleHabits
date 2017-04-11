//
//  File.swift
//  AlarmClock
//
//  Created by ReneUser on 25.10.16.
//  Copyright © 2016 ReneUser. All rights reserved.
//

import Foundation
import EventKit

let eventStore = EKEventStore()
class CalendarTools {
    static let sharedInstance = CalendarTools()
    

    func requestPermission(sender: ViewController)
    {
        let status = EKEventStore.authorizationStatus(for: EKEntityType.event)
        switch(status)
        {
        case EKAuthorizationStatus.notDetermined:
            // First Run
            getPermission(sender: sender)
        case EKAuthorizationStatus.authorized:
            sender.permissionAccepted()
        case EKAuthorizationStatus.denied,EKAuthorizationStatus.restricted :
            sender.permissionDenied()
    }
}

    private func getPermission(sender: ViewController)
    {
        eventStore.requestAccess(to: EKEntityType.event, completion: { (accesGranted, error) in
            if accesGranted == true {
                sender.permissionAccepted()     //the Permission asking is asynchronous, so we need to handle it this way when the permission is granted
            }
        })
    }
    
func getAllCalendar() -> [EKCalendar]
    {
        return eventStore.calendars(for: EKEntityType.event)
        
    }
    func getCalendarByIdentifier(identifier: String) -> EKCalendar
    {
        return eventStore.calendar(withIdentifier: identifier)!
    }
    
func getFirstAppointmentOneDayLater(calendar : EKCalendar) -> EKEvent?
    {
        return getAppointmentOneDayLater(appointmentNumber: 0, calendar: calendar)
    }
func getAppointmentOneDayLater(appointmentNumber: Int,calendar : EKCalendar) -> EKEvent?
{
        let todayDate = Date()
        var dateComponents = DateComponents()
        dateComponents.day = 1
        let userCalendar = Calendar.current
        let to = userCalendar.date(byAdding: dateComponents, to: todayDate, wrappingComponents: true)
        let eventsPredicate = eventStore.predicateForEvents(withStart: todayDate,end: to!,calendars: [calendar])
        let events = eventStore.events(matching: eventsPredicate).sorted(){
            (e1: EKEvent, e2: EKEvent) -> Bool in
            return e1.startDate.compare(e2.startDate) == ComparisonResult.orderedAscending
        }
        if(events.count == 0)
        {
            return nil
        }
        else
        {
            return events[appointmentNumber]
        }

    }
}


