//
//  NarodMonAPI.swift
//
//  Created by Serov Stanislav 20.05.2018.
//  Copyright © 2018 Serov Stanislav. All rights reserved.
//

import Foundation
import CommonCrypto

public class NarodMonAPI {
    private let apiKey = "madnPFMPd0HPV"
    private let uuidKeyForUserDefaults = "NarodMonWidgetUUID"
    private let baseUrl = "https://narodmon.ru/api"
    
    private var UUIDinMD5: String?
    private var UUIDString: String
    //private var Login: String?
    
    var dataSensorsOnDevice: NMSensorsOnDevice?
    static var dataSensorsNearby: NMSensorsNearby!
    
    public init() {
        if let uuid = UserDefaults.standard.string(forKey: uuidKeyForUserDefaults) {
            UUIDString = uuid
            UUIDinMD5 = MD5(uuid)
        } else {
            UUIDString = UUID().uuidString
            UUIDinMD5 = MD5(UUIDString)
            UserDefaults.standard.set(UUIDString, forKey: uuidKeyForUserDefaults)
        }
    }
    
    private func addDataToHeader(request: inout URLRequest) {
        request.httpMethod = "GET"
        request.addValue("User-Agent", forHTTPHeaderField: "iosTemp")
    }

    // MARK: - API Metods
    ///проверка актуальности версии приложения при первом запуске и раз в сутки, проверка авторизации пользователя.
    func appInit(complation: @escaping (Any)->()) {
        let url = baseUrl + "/appInit"
        let osVersion = ProcessInfo().operatingSystemVersion
        let requestParam: [String: String] = [
            //"cmd"      : "appInit",
            "uuid"     : UUIDinMD5!,
            "api_key"  : apiKey,
            "version"  : Bundle.main.infoDictionary?["CFBundleShortVersionString"] as! String,
            "platform" : String(format: "%d.%d.%d",
                                osVersion.majorVersion,
                                osVersion.minorVersion,
                                osVersion.patchVersion),
            "lang"     : "ru",
            "utc"      : "3"]     // часовой пояс пользователя в UTC (смещение в часах)
        
        func decodeAppInit(data: Data) -> AppInit? {
//                        let JSONData = try? JSONSerialization.jsonObject(with: data, options: .mutableContainers )
//                        print("[AppInt]: JSONData: \n \(JSONData!)")
            return try? JSONDecoder().decode(AppInit.self, from: data)
        }
        
        var urlRequest = Network.shared.getUrlRequest(url: url, parameters: requestParam)
        addDataToHeader(request: &urlRequest)
 //print(urlRequest)
        Network.shared.getData(urlRequest: urlRequest, decodeFunc: decodeAppInit) { (data) in
            complation((data as? AppInit)!)
        }
    }
    
    ///авторизация пользователя в проекте и его регистрация
    func userLogon(complation: @escaping (NMLogins)->()) {
        let url = baseUrl + "/userLogon"
        let requestParam: [String: String] = [
            //"cmd": "userLogon",
            "uuid": UUIDinMD5!,
            "api_key": apiKey,
            "lang": "ru"]
        
        func decodeUserLogon(data: Data) -> NMLogins? {
            
//            let JSONData = try? JSONSerialization.jsonObject(with: data, options: .mutableContainers )
//            print("[HTTP]: JSONData: \n \(JSONData!)")

            return try? JSONDecoder().decode(NMLogins.self, from: data)
        }
        
        var urlRequest = Network.shared.getUrlRequest(url: url, parameters: requestParam)
        addDataToHeader(request: &urlRequest)
print(urlRequest)
        Network.shared.getData(urlRequest: urlRequest, decodeFunc: decodeUserLogon) { (data) in
            complation((data as? NMLogins)!)
        }
    }
    

    ///запрос списка ближайших к пользователю датчиков
    func sensorsNearby(location: (Double, Double)?, complation: @escaping (NMSensorsNearby)->()) {
        let url = baseUrl + "/sensorsNearby"
        print("[ApiNarodMon]:  start UpdateData ...")
        let requestParam: [String: String] = [
            //"cmd"      : "sensorsNearby",
            "uuid"     : UUIDinMD5!,
            "api_key"  : apiKey,
            "lat"      : String(location!.0),
            "lng"      : String(location!.1),
            //"addr"     : "Москва",  //опционально адрес/город местонахождения пользователя, его приоритет выше чем у lat,lng;
            "radius"   : "100",  //опционально макс удаление от пользователя до датчиков в км, максимум ~111км (1°);
            //"limit"    : 7,    //опционально макс кол-во ближайших публичных устр-в мониторинга, по умолчанию 20, максимум 50;
            "lang"     : "ru"]
        
        func decodeSensorsNearby(data: Data) -> NMSensorsNearby? {
            guard var decodData = try? JSONDecoder().decode(NMSensorsNearby.self, from: data) else {return nil}
            decodData.devices.sort {$0.distance! < $1.distance!}
            return decodData
        }
        
        var urlRequest = Network.shared.getUrlRequest(url: url, parameters: requestParam)
        addDataToHeader(request: &urlRequest)
        Network.shared.getData(urlRequest: urlRequest, decodeFunc: decodeSensorsNearby) { (data) in
            complation((data as? NMSensorsNearby)!)
        }
    }


    // MD5 hash method
    private func MD5(_ string: String) -> String {
        let length = Int(CC_MD5_DIGEST_LENGTH)
        var digest = [UInt8](repeating: 0, count: length)
        
        if let d = string.data(using: String.Encoding.utf8) {
            _ = d.withUnsafeBytes { (body: UnsafePointer<UInt8>) in
                CC_MD5(body, CC_LONG(d.count), &digest)
            }
        }
        
        return (0..<length).reduce("") { $0 + String(format: "%02x", digest[$1]) }
    }

}
