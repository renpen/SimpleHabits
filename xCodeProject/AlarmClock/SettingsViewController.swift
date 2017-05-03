//
//  SettingsViewController.swift
//  AlarmClock
//
//  Created by Benedikt Bosshammer on 18.04.17.
//  Copyright © 2017 ReneUser. All rights reserved.
//

import UIKit
import MapKit

class SettingsViewController: UIViewController, MKMapViewDelegate {

    
    @IBOutlet weak var menuButton: UIBarButtonItem!
    
    @IBOutlet weak var homeLocationMapView: MKMapView!
    @IBOutlet weak var timeUnitSegmentedControl: UISegmentedControl!
    @IBOutlet weak var offsetTextField: UITextField!
    @IBOutlet weak var defaultDestinationMapView: MKMapView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    
        if revealViewController() != nil {
            menuButton.target = revealViewController()
            menuButton.action = #selector(SWRevealViewController.revealToggle(_:))
            view.addGestureRecognizer(self.revealViewController().panGestureRecognizer())
        }
        
        homeLocationMapView.layer.cornerRadius = 10
        defaultDestinationMapView.layer.cornerRadius = 10
        
        self.initialMkSetup()
        
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(self.dismissKeyboard))
        view.addGestureRecognizer(tap)
    }
    
    func initialMkSetup() {
        homeLocationMapView.delegate = self
        
        let annotation = MKPointAnnotation()
        annotation.coordinate = CLLocationCoordinate2D(latitude: LocationTools.sharedInstance.currentLat!, longitude: LocationTools.sharedInstance.currentLong!)
        
        homeLocationMapView.addAnnotation(annotation)
        
        let center = CLLocationCoordinate2D(latitude: LocationTools.sharedInstance.currentLat!, longitude: LocationTools.sharedInstance.currentLong!)
        
        let region = MKCoordinateRegion(center: center, span: MKCoordinateSpan(latitudeDelta: 0.05, longitudeDelta: 0.05))
        
        homeLocationMapView.setRegion(region, animated: false)
        
    }
    
    func dismissKeyboard() {
        view.endEditing(true)
    }
    
    func getMorningTimeInMinutes() -> Int {
        let tfValue = Int(offsetTextField.text!)
        if timeUnitSegmentedControl.selectedSegmentIndex == 0 {
            return tfValue! * 60
        } else {
            return tfValue!
        }
    }
    
    override func viewWillDisappear(_ animated: Bool) {
    }
    
}
