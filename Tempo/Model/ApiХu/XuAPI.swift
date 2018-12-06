//
//  XuAPI.swift
//  Tempo
//
//  Created by Serov Stas on 25.10.18.
//  Copyright © 2018 Devolper. All rights reserved.
//

import Foundation

/*
get data of wether from server https://www.apixu.com/
for exemple, response: https://api.apixu.com/v1/ forecast.json? key=apiKey&q=Moscow&days=3&lang=ru
*/

public class XuAPI {

    private let apiKey = "c2ddef88a446462ba25123242182510"
    
    private let baseUrl = "https://api.apixu.com/v1/forecast.json"
    private var requestParam = [
        "key"       : "c2ddef88a446462ba25123242182510",
        "q"         : "",
        "days"      : "7",
        "lang"      : "ru"]
    
    func getWeather(location: String?, completion: @escaping (JSONXuWeather) -> ()) {
        requestParam["q"] = location != nil ? location! : "55.4507, 37.3656"
        print("[ApiXu]: start UpdateData ...")
        func decodeXu(data: Data) -> JSONXuWeather? {
            return try? JSONDecoder().decode(JSONXuWeather.self, from: data)
        }
        
        let urlRequest = Network.shared.getUrlRequest(url: baseUrl, parameters: requestParam)
        Network.shared.getData(urlRequest: urlRequest, decodeFunc: decodeXu) { (data) in
            completion((data as? JSONXuWeather)!)
        }
    }
    
}
