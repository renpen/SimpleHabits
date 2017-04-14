//
//  LocationTools.swift
//  AlarmClock
//
//  Created by René Penkert on 14.04.17.
//  Copyright © 2017 ReneUser. All rights reserved.
//

import Foundation
import MapKit
import CoreLocation

class LocationTools : NSObject, CLLocationManagerDelegate{
    var currentLong : Double?
    var currentLat : Double?
    static let sharedInstance = LocationTools()
    var locationManager: CLLocationManager = CLLocationManager()
    func startLocating ()
    {
        self.locationManager.requestAlwaysAuthorization()
        self.locationManager.requestWhenInUseAuthorization()
        if CLLocationManager.locationServicesEnabled()
        {
            self.locationManager.delegate = self
            self.locationManager.desiredAccuracy = kCLLocationAccuracyNearestTenMeters
            self.locationManager.startUpdatingLocation()

        }
    }
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        let locValue:CLLocationCoordinate2D = manager.location!.coordinate
        currentLat = locValue.latitude
        currentLong = locValue.latitude
    }
}
