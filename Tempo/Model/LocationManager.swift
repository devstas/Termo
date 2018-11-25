//
//  LocationManager.swift
//  Tempo
//
//  Created by Devolper on 19.07.18.
//  Copyright © 2018 Devolper. All rights reserved.
//

import Foundation
import CoreLocation

// TODO: Опредилится когда вызывать геолакацию

class LocationManager: NSObject, CLLocationManagerDelegate {

    static let shered = LocationManager()
    
    override init() {
        super.init()
        locationManager.delegate = self
        locationManager.requestWhenInUseAuthorization()
        if CLLocationManager.locationServicesEnabled() {
            locationManager.desiredAccuracy = kCLLocationAccuracyHundredMeters
            locationManager.requestLocation()  //получаем координаты
        }
    }
    
    deinit {
        print("[LocationManager]:  <- deinit")
    }
    
    let locationManager = CLLocationManager()
    var locationIsEmpte = false
    
    func requestLocation() {
        locationManager.requestLocation()
    }
    
    func getLocation() -> CLLocation? {
        return locationManager.location
    }

    func getCoordinate() -> CLLocationCoordinate2D? {
        //guard locationManager.location != nil else {return nil}
        return locationManager.location?.coordinate
    }
    
    func getLongitudeLatitude() -> (CLLocationDegrees, CLLocationDegrees)? {
        guard locationManager.location != nil else {return nil}
        return (locationManager.location!.coordinate.longitude, locationManager.location!.coordinate.latitude)
    }
    
    func getCoordinateDoubl() -> (Double, Double)? {
        guard let location = locationManager.location?.coordinate else {return nil}
        return (Double(location.longitude), Double(location.latitude))
    }
    
    func getCoordinateString() -> String? {
        guard let location = locationManager.location?.coordinate else {return nil}
        return "\(Double(location.latitude)),\(Double(location.longitude))"
    }
    
    
    // MARK: - Delegate method of CLLocationManagerDelegate
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if manager.location != nil {
            print("[LocationManager]: координаты определены = \(getCoordinateString()!)")
            NotificationCenter.default.post(name: .locationIsUpdate, object: nil)
        } else {  print("[LocationManager]: ошибка получения координат") }
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print("[LocationManager]: \(error)")
    }
}
