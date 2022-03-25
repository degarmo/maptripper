//
//  ContentModel.swift
//  MapTripper
//
//  Created by CD on 3/23/22.
//

import Foundation
import MapKit


enum MapDetails {
    static let startingLocation = CLLocationCoordinate2D(latitude: 37.33217, longitude: -122.03078)
    static let defaultSpan = MKCoordinateSpan(latitudeDelta: 0.01, longitudeDelta: 0.01)
}

final class MapViewModel: NSObject, ObservableObject,
                            
    CLLocationManagerDelegate {
    
        @Published var region = MKCoordinateRegion(center: MapDetails.startingLocation,
                                                   span: MapDetails.defaultSpan)
    
    
    var locationManager: CLLocationManager?
    
    func checkIfLocationServicesIsEnabled(){
        if CLLocationManager.locationServicesEnabled(){
            locationManager = CLLocationManager()
            locationManager!.delegate = self
        } else {
            print("Please turn on apps access to your location.")
        }
    }
    
    private func checkLocationAuthorization(){
        guard let locationManager = locationManager else {return}
        
        switch locationManager.authorizationStatus {
        case .notDetermined:
            locationManager.requestWhenInUseAuthorization()
        case .restricted:
            print("Your location is restricted likely due to parental controls")
        case .denied:
            print("You have denied this app access to your location")
        case .authorizedAlways, .authorizedWhenInUse:
            region = MKCoordinateRegion(center: locationManager.location!.coordinate,
                                        span: MapDetails.defaultSpan)
        @unknown default:
            break
        }
    }
    
    func locationManagerDidChangeAuthorization(_ manager: CLLocationManager) {
        checkLocationAuthorization()
    }

}

