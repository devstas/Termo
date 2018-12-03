//
//  MapViewModel.swift
//  Tempo
//
//  Created by Serov Stas on 29/11/2018.
//  Copyright © 2018 Devolper. All rights reserved.
//

import Foundation
import CoreLocation

struct Sens {
    var title = ""
    var subTitel = ""
}

struct Dev {
    var title = ""
    //var subTitel = ""
    var name: String
    var coordinate: CLLocationCoordinate2D
}

class MapViewModel {
    
    var narodmonApi = NarodMonAPI()
    
    // model
    var devices: [Dev]!
    
    
    func getDataSensor(location: (Double, Double), completion: @escaping () -> Void) {
        narodmonApi.sensorsNearby(location: location) { [weak self] (sensorsNear) in
            //self?.nmCellViewModelArray = sensorsNear.devices.map{ NmCellViewModel(device: $0) }
            self?.updeteViewModel(devices: sensorsNear.devices)
            //print(self.nmMapViewModel.devices)
            completion()
        }
    }
    
    
    func updeteViewModel(devices: [NMDevices]) {
        self.devices = []
        
        for dev in devices {
            let coordinate = CLLocationCoordinate2D(latitude: (dev.lat)!, longitude: (dev.lng)!)
            if dev.name! == "" {continue}
            let name = "\(dev.name!) [id = \(dev.id!)]"
            let title = dev.sensors.reduce("") { total, item in
                "\(total)\n\(item.name!) = \(item.value!) \(item.unit!)"
            }
            self.devices.append(Dev(title: title, name: name, coordinate: coordinate))
        }
    }
    
}

