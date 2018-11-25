//
//  XuCellViewModel.swift
//  Tempo
//
//  Created by Serov Stas on 23/11/2018.
//  Copyright © 2018 Devolper. All rights reserved.
//

import Foundation


class XuCellViewModel {
    
    let tempDay: String
    var tempNigth: String
    var date: String?
    var dayOfWeek: String?
    var urlImage: URL
    
    //xuWeather = xuWeather.forecast?.forecastday
    init(_ xuWeather: XuForecastDay) {
        self.tempDay = "\(Int((xuWeather.day?.maxtemp_c)!)) ˚"
        self.tempNigth = "\(Int((xuWeather.day?.mintemp_c)!)) ˚"
        self.date = xuWeather.date_epoch!.unixDateToString()
        self.dayOfWeek = xuWeather.date_epoch!.unixDateToDayOfWeek()
        self.urlImage = URL(string: "https:\((xuWeather.day?.condition?.icon)!)")!
    }
    
    // now not use
    func compassTranslete(_ data: String?) -> String {
        let compas = ["N":"С","WNE":"СВ","E":"В","WSE":"ЮВ","S":"Ю","WSW":"ЮЗ","W":"З","WNW":"СЗ"]
        guard let data = data else {return "--"}
        guard let result = compas[data] else {return "--"}
        return result
    }
    
}
