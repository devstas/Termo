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
        
        self.deviceAdress = "[\(device.distance!)км] id = \(device.id!) \(device.name!)"
        
        self.deviceData = device.sensors.map ({ "\($0.value!) \($0.unit!)" }).joined(separator: ", ")
        
        self.deviceExtendedData = "[id=\(device.id!)]  \(device.name!)\n \(device.location!)\n"
        
        self.deviceExtendedData += device.sensors.map ({ "- данные = \($0.value!) \($0.unit!) в \(Double($0.time!).unixTimeToString())" }).joined(separator: "\n")
        
        print(device.location!)

//        without FP
//        for i in 0 ..< device.sensors.count {
//            let sens = device.sensors[i]
//            let time = Double(sens.time!).unixTimeToString()
//
//            extendedData += "* \(sens.name!); id=\(sens.id!)\n"
//
//            extendedData += (device.sensors.count - 1) != i
//                 ? "  - данные = \(sens.value!) \(sens.unit!) в \(time)\n"
//                 : "  - данные = \(sens.value!) \(sens.unit!) в \(time)"
//            extendedData += (device.sensors.count - 1) != i
//                 ? "\(sens.value!) \(sens.unit!), "
//                 : "\(sens.value!) \(sens.unit!)"
//        }

    }
}
