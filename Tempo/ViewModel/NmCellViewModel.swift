//
//  NmCellViewModel.swift
//  Tempo
//
//  Created by Serov Stas on 23/11/2018.
//  Copyright © 2018 Devolper. All rights reserved.
//

import Foundation


class NmCellViewModel {
    
    var deviceAdress: String
    var deviceData: String
    var deviceExtendedData: String
    
    public init(device: NMDevices) {
        var dat = ""
        var res = "[id=\(device.id!)]  \(device.name!)\n"
           res += "\(device.location!)\n"
        
        for i in 0 ..< device.sensors.count {
            let sens = device.sensors[i]
            let time = Double(sens.time!).unixTimeToString()
            
            res += "* \(sens.name!); id=\(sens.id!)\n"
            res += (device.sensors.count - 1) != i
                 ? "  - данные = \(sens.value!) \(sens.unit!) в \(time)\n"
                 : "  - данные = \(sens.value!) \(sens.unit!) в \(time)"
            dat += (device.sensors.count - 1) != i
                 ? "\(sens.value!) \(sens.unit!), "
                 : "\(sens.value!) \(sens.unit!)"
        }
        
        self.deviceAdress = "[\(device.distance!)км] id = \(device.id!) \(device.name!)"
        self.deviceData = dat
        self.deviceExtendedData = res
    }
}
