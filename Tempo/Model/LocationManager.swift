//
//  LocationManager.swift
//  Tempo
//
//  Created by Devolper on 19.07.18.
//  Copyright © 2018 Devolper. All rights reserved.
//

import Foundation
import CoreLocation

class LocationManager: NSObject, CLLocationManagerDelegate {

    static let shered = LocationManager()
    
    private var timer: Timer!
    
    private override init() {
        super.init()
        locationManager.delegate = self
        locationManager.requestWhenInUseAuthorization()
        if CLLocationManager.locationServicesEnabled() {
            locationManager.desiredAccuracy = kCLLocationAccuracyHundredMeters
            locationManager.requestLocation()  //get coordinate
        
            timer = Timer.scheduledTimer(timeInterval: 600, target: self, selector: #selector(refreshTimerLocate(_:)), userInfo: nil, repeats: true)
        }
    }
    
    // reload location and weather every 600 seconds (10 min)
    @objc func refreshTimerLocate(_ :Any) {
        locationManager.requestLocation()
    }
    
    let locationManager = CLLocationManager()
    var locationIsEmpte = false
    
    func requestLocation() {
        locationManager.requestLocation()
    }
    
    func getCoordinateDoubl() -> (Double, Double)? {
        guard let location = locationManager.location?.coordinate else {return nil}
        return (Double(location.latitude), Double(location.longitude))
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
