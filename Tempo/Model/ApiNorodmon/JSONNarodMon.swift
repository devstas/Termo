//
//  JSONNarodMon.swift
//  Tempo
//
//  Created by Serov Stas on 18.07.18.
//  Copyright © 2018 Devolper. All rights reserved.
//

import Foundation


struct NMLogins: Decodable{
    ///login логин пользователя для авторизации, если он не указан, то возвращается текущий логин для uuid;
    var login: String?
    ///уникальный MD5-хеш в нижнем регистре, однократно сгенерированный Вашим приложением в момент установки на устройстве пользователя.
    var uid: String?
    ///признак партнера, если = 1, то партнер, донат, разработчик, администратор, для остальных = 0.
    var vip: Int?
}

struct AppInit: Decodable {
    ///актуальная версия приложения указанная в Мои приложения;
    var latest: String?
    ///скачивания обновления приложения указанный в Мои приложения;
    var url: String?
    //var uid: Double?
    ///имя авторизованного пользователя для данного uuid иначе "";
    var login: String?
    ///= 1 признак партнера, донатора, разработчика, администрации, для остальных = 0;
    var vip: Int?
    var lat: Double?
    var lng: Double?
    ///ближайший адрес текущего местонахождения пользователя;
    var addr: String?
    ///справочник типов датчиков;
    var types: [SensorsTypes]?
    ///массив из ID избранных датчиков у авторизованного пользователя.
    //var favorites: [Int?]
}

struct SensorsTypes: Decodable {
    ///код типа датчика;
    var type: Int?
    ///название типа датчика;
    var name: String?
    ///единица измерения;
    var unit: String?
}

struct SensorFavorites: Decodable {
    ///массив из ID избранных датчиков у авторизованного пользователя.
    var id: Int?
}

///история показаний датчика за период (для графиков и тенденций).
struct NMSensorsHistory: Decodable {
    var data = [NMHistoryData]()
}

struct NMHistoryData: Decodable {
    ///целочисленный код датчика в проекте;
    var id: Int?
    ///время показания датчика в UnixTime;
    var time: Double?
    ///показание датчика в указанный момент времени.
    var value: Double?
}

///запрос списка ближайших к пользователю датчиков, приватных авторизованного пользователя и Избранного.
struct NMSensorsNearby: Decodable {
    ///список устройст поблизости
    var devices: [NMDevices]
}

struct NMDevices: Decodable {
    ///целочисленный код устройства в проекте;
    var id: Int?
    ///серийный номер устройства (только для владельца);
    var mac: String?
    ///название устройства или его ID (если нет названия);
    var name: String?
    ///= 1, если это устр-во авторизованного пользователя, иначе = 0;
    var my: Int?
    ///ID владельца устройства в проекте;
    var owner: String?
    ///= 1, если включен режим управления устр-вом, иначе = 0;
    var cmd: Int?
    ///местонахождение устройства, населенный пункт или область;
    var location: String?
    ///расстояние в км от текущего местонахождения пользователя;
    var distance: Double?
    ///время последней активности устр-ва в UnixTime;
    var time: Int?
    var lat: Double?
    var lng: Double?
    ///количество положительных отзывов пользователей;
    var liked: Int?
    ///х/з
    //var uptime: Int?
    ///- sensors массив датчиков подключенных к указанному устр-ву;
    var sensors: [NMSensor]
}

///запрос списка датчиков и их показаний по ID устр-ва мониторинга.
struct NMSensorsOnDevice: Decodable {
    ///ID устройства в проекте;
    ///id ID устр-ва из ссылки вида http://narodmon.ru/ID в балуне на карте;
    var id: Int?
    ///серийный номер устройства (только для владельца)
    var mac: String?
    ///название устройства или его ID (если нет названия);
    var name: String?
    ///= 1, если это устр-во авторизованного пользователя, иначе = 0;
    var my: Int?
    ///ID владельца устройства в проекте;
    var owner: String?
    ///местонахождение устройства, населенный пункт или область;
    var location: String?
    ///расстояние в км от текущего местонахождения пользователя;
    var distance: Double?
    ///количество положительных отзывов пользователей;
    var liked: Int?
    var uptime: Int?
    var sensors: [NMSensor]
}

struct NMSensor: Decodable {
    ///целочисленный код датчика в проекте;
    var id: Int?
    var mac: String?
    ///если = 1 датчик в Избранном у пользователя, если = 0 нет или не авторизован;
    var fav: Int?
    ///если = 1 датчик публичный, если = 0 датчик приватный;
    var pub: Int?
    ///код типа датчика (см. appInit);
    var type: Int?
    ///название датчика или его ID (если нет названия);
    var name: String?
    ///последнее показание датчика;
    var value: Double?
    ///единица измерения;
    var unit: String?
    ///время последнего показания датчика в UnixTime;
    var time: Int?
    ///время последнего изменения показаний датчика в UnixTime;
    var changed: Int?
    ///коэффициент линейного роста показаний датчика за последний час, рассчитанный по МНК.
    var trend: Double?  // !! сервак отдает то строку в Double "3.17" если даных нет, то число Int = 0
}
