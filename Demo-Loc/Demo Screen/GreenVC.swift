//
//  GreenVC.swift
//  Demo-Loc
//
//  Created by Emil Safier on 9/4/20.
//  Copyright © 2020 Emil Safier. All rights reserved.
//

import UIKit
import MapKit

class GreenVC: UIViewController, MKMapViewDelegate, CLLocationManagerDelegate {

    //  MARK: - Outlet
       @IBOutlet weak var mapView: MKMapView!
       
       //  MARK: - Properties
       //  location Manager
       var locationManager = CLLocationManager()
       var currentCoordinate: CLLocationCoordinate2D!
       var currentLocation: CLLocation?
       var defaultDistanceFilter: Double = 10
       var defaultArtifactSpan: Double = 5000
       var defaultPlaceSpan: Double = 20000
       
       override func viewDidLoad() {
           super.viewDidLoad()
           mapView.delegate = self
           locationManager.delegate = self
           
           locationManager.requestAlwaysAuthorization()
           //  if enabled set
           if CLLocationManager.locationServicesEnabled() {
               locationManager.desiredAccuracy = kCLLocationAccuracyBest
               locationManager.requestLocation()
               // user setable default - distance change since lastposition before update
               locationManager.distanceFilter = CLLocationDistance(defaultDistanceFilter)
           }
           // --  map type
           mapView.mapType = .standard
           mapView.userTrackingMode =  MKUserTrackingMode.follow
       }
       
       func mapRegion(_ center: CLLocationCoordinate2D, span: CLLocationDistance) -> MKCoordinateRegion {
           let region: MKCoordinateRegion = MKCoordinateRegion(center: center, latitudinalMeters: span, longitudinalMeters: span)
           return region
       }
       
       //  MARK: - LocationManager
       func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
           print("error:: (error.localizedDescription)")
       }
       
       private func locationManager(manager: CLLocationManager, didChangeAuthorizationStatus status: CLAuthorizationStatus) {
           if status == .authorizedWhenInUse {
               locationManager.requestLocation()
           }
       }
       
       func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
           print("MapVC/didUpdateLocations")
           if locations.first != nil {
               currentLocation = locations.first!
               let _:CLLocation = locationManager.location!
           }
       }

}
