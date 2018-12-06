//
//  AppDelegate.swift
//  Tempo
//
//  Created by Serov Stas on 15.05.18.
//  Copyright © 2018 Devolper. All rights reserved.
//

import UIKit


@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        let nm = NarodMonAPI()
        nm.appInit()
        LocationManager.shered.requestLocation()
        return true
    }
}


