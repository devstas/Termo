//
//  XuHeaderViewModel.swift
//  Tempo
//
//  Created by Serov Stas on 23/11/2018.
//  Copyright © 2018 Devolper. All rights reserved.
//

import Foundation

class XuHeaderViewModel {
    
    let currentTemp: String
    var conditionInfoTemp: String
    var feelTemp: String
    var urlImageWeather: URL
    
    var pressure: String
    var windSpeed: String
    var humidity: String
    var visibility: String
    
    var city: String?
    
    init(xuCurrent: XuCurrent) {
        
        self.currentTemp = "\(Int((xuCurrent.temp_c)!))"
        self.conditionInfoTemp = "\((xuCurrent.condition.text)!)"
        self.feelTemp = "ощущается как: \(Int((xuCurrent.feelslike_c)!))˚"
        self.urlImageWeather = URL(string: "https:\((xuCurrent.condition.icon)!)")!
        self.pressure = "\(Int((xuCurrent.pressure_mb)! * 0.750064)) ммРс"
        self.windSpeed = "\(Int((xuCurrent.wind_kph)! / 3.6)) м/с"
        self.humidity = "\(Int((xuCurrent.humidity)!)) %"
        self.visibility = "\(Int((xuCurrent.vis_km)!)) км"
    }
}
