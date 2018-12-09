//
//  LocationManager.swift
//  Tempo
//
//  Created by Serov Stas on 19.07.18.
//  Copyright © 2018 Devolper. All rights reserved.
//
import UIKit
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
        } else {
            print("Location service is denied")
        }
    }
    
    // reload location and weather every 600 seconds (10 min)
    @objc func refreshTimerLocate(_ :Any) {
        locationManager.requestLocation()
    }
    
    let locationManager = CLLocationManager()
    
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
    
    func getAuthorizationStatus() -> Bool {
        return CLLocationManager.authorizationStatus() == .authorizedWhenInUse ? true : false
    }
    
    private func openAppSettings() {
        if let appSettings = URL(string: UIApplication.openSettingsURLString) {
            UIApplication.shared.open(appSettings, options: [:], completionHandler: nil)
        }
    }
    
    func requestLocationServices() {
        
        switch CLLocationManager.authorizationStatus() {
        case .notDetermined:
            // Request when-in-use authorization initially
            locationManager.requestWhenInUseAuthorization()
            break
            
        case .restricted, .denied:
            // restricted by e.g. parental controls. User can't enable Location Services
            // denied - user denied your app access to Location Services, but can grant access from Settings.app
            if let rootVC = UIApplication.shared.keyWindow?.rootViewController {
                let alert = UIAlertController(title: "", message: "для обновления данных необходимо включить геолакацию", preferredStyle: .alert)
                let cancelAction = UIAlertAction(title: "Отмена", style: .cancel, handler: nil)
                let toSettingsAction = UIAlertAction(title: "В настройки", style: .default) { (action) in
                    self.openAppSettings()
                }
                alert.addAction(toSettingsAction)
                alert.addAction(cancelAction)
                rootVC.show(alert, sender: nil)
            }
            break
            
        case .authorizedWhenInUse, .authorizedAlways:
            // Enable location
            locationManager.requestLocation()
            break
        }
    }

    
    // MARK: - Delegate method of CLLocationManagerDelegate
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        
        switch status {
        case .restricted, .denied:
            if let rootVC = UIApplication.shared.keyWindow?.rootViewController {
                let alert = UIAlertController(title: "внимание!", message: "Без определения местоположения приложение не сможет отображать погоду и данные от ближайших датчиков.", preferredStyle: .alert)
                let cancelAction = UIAlertAction(title: "Отмена", style: .cancel, handler: nil)
                let toSettingsAction = UIAlertAction(title: "В настройки", style: .default) { (action) in
                    self.openAppSettings()
                }
                alert.addAction(toSettingsAction)
                alert.addAction(cancelAction)
    
                rootVC.show(alert, sender: nil)
            }
            break
            
        case .authorizedWhenInUse, .authorizedAlways:
            locationManager.requestLocation()
            break
            
        case .notDetermined:
            break
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if manager.location != nil {
            print("[LocationManager]: координаты определены = \(getCoordinateString()!)")
            NotificationCenter.default.post(name: .locationIsUpdate, object: nil)
        } else {  print("[LocationManager]: ошибка получения координат") }
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print("[LocationManager]: ошибка получения координат = \(error)")
    }
}
