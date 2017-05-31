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

    func requestPermission(sender: CalendarViewController)
    {
        let status = EKEventStore.authorizationStatus(for: EKEntityType.event)
        switch(status)
        {
        case EKAuthorizationStatus.notDetermined:
            // First Run
            getPermission(sender: sender)
        case EKAuthorizationStatus.authorized:
            sender.permissionGiven()
        case EKAuthorizationStatus.denied,EKAuthorizationStatus.restricted :
            sender.permissionDeied()
    }
}

    private func getPermission(sender: CalendarViewController)
    {
        eventStore.requestAccess(to: EKEntityType.event, completion: { (accesGranted, error) in
            if accesGranted == true {
                sender.permissionGiven()     //the Permission asking is asynchronous, so we need to handle it this way when the permission is granted
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
//    func getCalendarByIdentifier1(identifier: String) -> EKCalendar?
//    {
//        let calendars = getAllCalendar()
//        for calendar in calendars {
//            if calendar.calendarIdentifier == identifier {
//                return calendar
//            }
//        }
//        return nil
//    }
    
func getFirstAppointmentUpToOneDayLater(calendar : EKCalendar) -> EKEvent?
    {
        return getAppointmentUpToOneDayLater(appointmentNumber: 0, calendar: calendar)
    }
    //
func getAppointmentUpToOneDayLater(appointmentNumber: Int,calendar : EKCalendar) -> EKEvent?
{
        var appointmentNumber = appointmentNumber;
        let todayDate = Date()
        var dateComponents = DateComponents()
        dateComponents.day = 1
        //dateComponents.month = 1 HOTFIX at the end of the month. end of the month +1day = start of the current month and not the start of the next month. 31.05 +1day = 01.05
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
            //Schaue solange rein, bis du ein Event findest, welches kein AlldayEvent ist
            while events[appointmentNumber].isAllDay{
                appointmentNumber += 1
            }
            while events[appointmentNumber].startDate < Date() {
                appointmentNumber += 1;
            }
            return events[appointmentNumber]
        }

    }
}


