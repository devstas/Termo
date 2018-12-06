//
//  JSONApixu.swift
//  Tempo
//
//  Created by Serov Stas on 25.10.18.
//  Copyright © 2018 Devolper. All rights reserved.
//

import Foundation

struct JSONXuWeather: Decodable{
    var location: XuLocation?
    var current: XuCurrent?
    var forecast: XuForecast?
}

struct XuLocation: Decodable {
    var name: String?
    var region: String?
    var country: String?
    var lat: Double?
    var lon: Double?
    var tz_id: String? //"Europe/Moscow"
    var localtime_epoch: Double?
    var localtime: String?//"2018-10-25 15:59"
}

struct XuCurrent: Decodable {
    var last_updated: String? //"2018-10-25 15:45"
    var temp_c: Double?
    var is_day: Int?
    var condition: XuCondition
    var wind_kph: Double?
    var wind_degree: Double?
    var wind_dir: String? //"WNW"
    var pressure_mb: Double?
    var precip_mm: Double?
    var humidity: Double?
    ///облачное покрытие в процентах
    var cloud: Double?
    ///ощущается как
    var feelslike_c: Double?
    ///видимось в км
    var vis_km: Double?
}

struct XuCondition: Decodable {
    var text: String? //"Небольшой дождь со снегом",
    var icon: String? //"cdn.apixu.com/weather/64x64/day/317.png",
    var code: Double? //1204
    
}

struct XuForecast: Decodable {
    var forecastday: [XuForecastDay]?
}

struct XuForecastDay: Decodable {
    var date: String?
    var date_epoch: Double?
    var day: XuDay?
    var astro: XuAstro?
}

struct XuDay: Decodable {
    var maxtemp_c: Double
    var mintemp_c: Double
    var avgtemp_c: Double
    var maxwind_kph: Double?
    var totalprecip_mm: Double?
    var avgvis_km: Double?
    var avghumidity: Double?
    var condition: XuCondition?
    var uv: Double?
}

struct XuAstro: Decodable {
    var sunrise: String?
    var sunset: String?
    var moonrise: String?
    var moonset: String?
}

